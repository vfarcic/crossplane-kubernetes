# PRD: Gateway API and KEDA Installation

**Status**: In Progress (scope expanded)
**Priority**: High
**Created**: 2026-02-22

## Problem Statement

Clusters provisioned by dot-kubernetes currently lack Gateway API and KEDA infrastructure. Without these, downstream configurations (dot-application for general workloads, dot-inference for LLM workloads) cannot leverage intelligent request routing or event-driven autoscaling. Users must manually install and configure these components, which is inconsistent with the dot-kubernetes model of delivering fully operational clusters with system-level tooling pre-installed.

## Context

dot-kubernetes already installs system-level applications (Traefik, Crossplane, Argo CD, NVIDIA GPU Operator, External Secrets, Cilium) as optional Helm-based components. This PRD extends that pattern with new components:

1. **Envoy Gateway** — A Gateway API implementation that serves as the general-purpose gateway for all cluster traffic (replaces or supplements Traefik) *(done)*
2. **KEDA** — Event-driven autoscaler that scales workloads based on external metrics (Prometheus, queue depth, custom triggers) *(done)*
3. **kube-prometheus-stack** — Prometheus + Grafana observability stack, required for KEDA Prometheus-trigger scaling (e.g., scale-to-zero based on Envoy Gateway traffic metrics) *(done)*
4. **Gateway API Inference Extension** — Moved to separate PRD (see `prds/gateway-api-inference-extension.md`)

These components follow the same pattern as existing apps: installed via Helm, optional, enabled through the Cluster XR spec.

## Proposed API Surface

Extend `spec.parameters.apps` with new optional sections:

```yaml
spec:
  parameters:
    apps:
      envoyGateway:
        enabled: true
      keda:
        enabled: true
      prometheus:
        enabled: true
```

### Component Details

#### Envoy Gateway
- **Helm chart**: `oci://docker.io/envoyproxy/gateway-helm`
- **Namespace**: `envoy-gateway-system`
- **Purpose**: General-purpose Gateway API implementation for all workloads
- **Consumers**: dot-application (HTTPRoute), dot-inference (InferencePool)
- **Note**: This is complementary to Traefik. Traefik handles traditional Ingress resources. Envoy Gateway handles Gateway API resources. Users may run both during migration or choose one

#### KEDA
- **Helm chart**: `kedacore/keda`
- **Namespace**: `keda`
- **Purpose**: Event-driven autoscaling for any workload type
- **Consumers**: dot-application (CPU/memory/Prometheus-based scaling), dot-inference (vLLM metrics-based scaling)
- **Prerequisite**: Prometheus must be available for Prometheus-trigger-based scaling. Document this dependency but don't enforce it — KEDA works with other trigger types too

#### kube-prometheus-stack
- **Helm chart**: `prometheus-community/kube-prometheus-stack`
- **Namespace**: `prometheus-system`
- **Purpose**: Observability stack providing Prometheus metrics collection and Grafana dashboards. Required for KEDA Prometheus-trigger-based scaling (e.g., scale-to-zero based on Envoy Gateway traffic metrics)
- **Consumers**: dot-application (KEDA Prometheus triggers for scale-to-zero), dot-inference (vLLM metrics-based scaling)
- **Prometheus service URL**: `http://kube-prometheus-stack-prometheus.prometheus-system:9090` — this is what crossplane-app users reference in their `spec.scaling.prometheusAddress`

#### Envoy Gateway PodMonitor
- **Bundled with**: Envoy Gateway installation (only created when both `envoyGateway` and `prometheus` are enabled)
- **Purpose**: Configures Prometheus to scrape Envoy Gateway proxy pod metrics, making `envoy_http_downstream_rq_total` and other Envoy metrics available for KEDA Prometheus triggers
- **Selector**: `app.kubernetes.io/component: proxy` in `envoy-gateway-system` namespace
- **Endpoint**: port `metrics`, path `/stats/prometheus`

#### Gateway Cross-Namespace Routes
- The default `Gateway` resource (name: `eg`, namespace: `envoy-gateway-system`) needs `allowedRoutes.namespaces.from: All` so that HTTPRoutes from application namespaces can attach to it
- crossplane-app references this Gateway as parentRef with name `eg`

## Implementation Approach

Follow the existing pattern in `kcl/apps.k`:

1. Add new conditional blocks for each component (same pattern as `traefik`, `nvidia`, etc.)
2. Each component gets a Helm Release object with appropriate values
3. Gateway API CRDs may need to be installed separately before Envoy Gateway (check if the Helm chart bundles them)
4. Add a `Gateway` resource (the actual listener) as a Kubernetes Object, configured with HTTP/HTTPS listeners — this is the shared entry point that HTTPRoute and InferencePool resources attach to

## Discussion Topics

### Traefik Coexistence
- Traefik is the current default ingress. Envoy Gateway serves a different role (Gateway API vs Ingress API)
- Both can coexist: Traefik handles `Ingress` resources, Envoy Gateway handles `HTTPRoute`/`InferencePool`
- Long-term, Envoy Gateway could replace Traefik entirely since it supports both Gateway API and legacy Ingress
- Should we deprecate Traefik in favor of Envoy Gateway, or keep both indefinitely?

### Gateway Resource
- Envoy Gateway needs a `Gateway` resource (listeners on ports 80/443) to function
- Should dot-kubernetes create a default `Gateway`, or leave that to consuming configurations?
- Recommendation: Create a default `Gateway` with HTTP and HTTPS listeners. Consuming configurations (dot-application, dot-inference) create `HTTPRoute`/`InferencePool` that attach to it

### KEDA + Prometheus Dependency (RESOLVED)
- **Decision**: Install kube-prometheus-stack as an optional app component
- crossplane-app requires Prometheus for KEDA Prometheus-trigger scale-to-zero (queries `envoy_http_downstream_rq_total` to detect traffic)
- A PodMonitor for Envoy Gateway proxy pods is needed so Prometheus scrapes their metrics
- The PodMonitor is created as a Kubernetes Object when both `envoyGateway` and `prometheus` are enabled

### Version Pinning
- Follow the existing pattern: pin Helm chart versions in `kcl/data.k` and let Renovate manage updates
- Gateway API CRD version must be compatible with both Envoy Gateway and the Inference Extension

## Testing

- Extend existing Chainsaw tests with new test cases for each component
- Test matrix: Envoy Gateway alone, KEDA alone, all three together
- Verify Helm releases are created with correct values
- Verify `Gateway` resource is created when Envoy Gateway is enabled
- Verify Inference Extension is not installed when disabled (even if GPU nodes are present)

## Dependencies

- **Upstream**: None — this is foundational infrastructure
- **Downstream**: [crossplane-app Gateway + KEDA PRD], [crossplane-inference combined Gateway + KEDA PRD]

## Implementation Progress

### KEDA
- [x] Schema definition in `kcl/data.k`
- [x] XRD property in `kcl/definition.k`
- [x] Helm release in `kcl/apps.k` (kedacore/keda v2.19.0, namespace: keda)
- [x] Chainsaw tests (common patch + assertion, all 3 providers)
- [x] All tests passing

### Envoy Gateway
- [x] Schema definition in `kcl/data.k`
- [x] XRD property in `kcl/definition.k`
- [x] Helm release in `kcl/apps.k` (OCI: docker.io/envoyproxy/gateway-helm v1.7.0, namespace: envoy-gateway-system)
- [x] Default Gateway resource (HTTP listener on port 80, gatewayClassName: eg)
- [x] Chainsaw tests (common patch + assertion, all 3 providers)
- [x] All tests passing

### Gateway API Inference Extension
- [~] Moved to separate PRD — see `prds/gateway-api-inference-extension.md`

### Gateway Cross-Namespace Fix
- [x] Update Gateway resource in `kcl/apps.k` to add `allowedRoutes.namespaces.from: All`
- [x] Update Chainsaw assertions for the Gateway resource
- [x] All tests passing

### kube-prometheus-stack
- [x] Schema definition in `kcl/data.k`
- [x] XRD property in `kcl/definition.k`
- [x] Helm release in `kcl/apps.k` (prometheus-community/kube-prometheus-stack v82.2.1, namespace: prometheus-system)
- [x] Chainsaw tests (common patch + assertion, Google provider)
- [x] All tests passing

### Envoy Gateway PodMonitor
- [x] PodMonitor Kubernetes Object in `kcl/apps.k` (conditional on both `envoyGateway` and `prometheus` enabled)
- [x] Chainsaw tests
- [x] All tests passing

### KEDA HTTP Add-on
- [x] Helm release in `kcl/apps.k` (keda-add-ons-http v0.12.2, namespace: keda, conditional on KEDA enabled)
- [x] ReferenceGrant Object in `kcl/apps.k` (conditional on both KEDA and Envoy Gateway enabled, allows HTTPRoutes from any namespace to reference Services in keda namespace)
- [x] Chainsaw tests (assertions in `assert-keda.yaml`, Usage assertions in AWS test)
- [x] All tests passing

### Test Reorganization
- [x] Moved Envoy Gateway, Prometheus, and PodMonitor tests from Google → AWS test suite (consolidates related tests)

### Respond to crossplane-app
- [x] After all milestones above are complete, write a feature response to `../crossplane-app/tmp/feature-response.md` with: Gateway name (`eg`), Prometheus service URL and namespace, PodMonitor details, KEDA namespace — see `tmp/feature-request.md` for full request and response format
- [x] Delete `tmp/feature-request.md` after response is written
- [x] Respond to KEDA HTTP Add-on feature request from crossplane-app with implementation details (interceptor service, port, chart version)

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-22 | Implement KEDA first | Simplest component, no dependencies on other new components, validates approach | Unblocks Envoy Gateway and Inference Extension work |
| 2026-02-22 | Use KEDA Helm chart v2.19.0 from kedacore repo | Latest stable version, standard Helm repository pattern | Version pinned in apps.k, Renovate will manage updates |
| 2026-02-22 | Use Envoy Gateway v1.7.0 via OCI registry | Latest stable release (Feb 2026), OCI distribution pattern | Version pinned in apps.k, uses _chartUrl for OCI |
| 2026-02-22 | HTTP-only default Gateway (no HTTPS) | HTTPS requires TLS certificate config best handled by consuming configurations | Users can add HTTPS listeners via dot-application or dot-inference |
| 2026-02-22 | Split inference extension into separate PRD | Component is more complex than originally scoped (CRDs, per-pool EPP, BBR) | PRD #269 scope reduced to KEDA + Envoy Gateway (both complete) |
| 2026-02-22 | Add kube-prometheus-stack as optional app | crossplane-app needs Prometheus for KEDA scale-to-zero via Envoy Gateway traffic metrics | New milestone; Prometheus service URL: `http://kube-prometheus-stack-prometheus.prometheus-system:9090` |
| 2026-02-22 | Fix Gateway to allow cross-namespace routes | crossplane-app HTTPRoutes in app namespaces need to attach to the Gateway in envoy-gateway-system | Update Gateway object to add `allowedRoutes.namespaces.from: All` |
| 2026-02-22 | Add PodMonitor for Envoy Gateway metrics | Without it, Prometheus cannot scrape Envoy proxy metrics and KEDA Prometheus triggers fail | PodMonitor created when both envoyGateway and prometheus are enabled |
| 2026-02-22 | Gateway name is `eg` (not `contour`) | Matches Envoy Gateway's default GatewayClass name | crossplane-app will update parentRef from `contour` to `eg` |
| 2026-02-23 | Use kube-prometheus-stack v82.2.1 | Latest stable version from prometheus-community Helm repo | Version pinned in apps.k, Renovate will manage updates |
| 2026-02-23 | Deduplicate Chainsaw test assertions | Common patch+assert+usage blocks now run in one provider only, reducing test time ~40% | Each common app tested once; provider-specific tests remain per-provider |
| 2026-02-23 | Install KEDA HTTP Add-on alongside KEDA | crossplane-app needs interceptor proxy for scale-from-zero (holds requests while pods start) | `keda-add-ons-http` v0.12.2 installed when KEDA enabled; ReferenceGrant when KEDA + Envoy Gateway enabled |
| 2026-02-23 | Consolidate Envoy Gateway/Prometheus/KEDA tests in AWS | All three components are related and need to be tested together for ReferenceGrant | Moved from Google to AWS test suite |
