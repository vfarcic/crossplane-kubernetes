# PRD: Gateway API and KEDA Installation

**Status**: In Progress
**Priority**: High
**Created**: 2026-02-22

## Problem Statement

Clusters provisioned by dot-kubernetes currently lack Gateway API and KEDA infrastructure. Without these, downstream configurations (dot-application for general workloads, dot-inference for LLM workloads) cannot leverage intelligent request routing or event-driven autoscaling. Users must manually install and configure these components, which is inconsistent with the dot-kubernetes model of delivering fully operational clusters with system-level tooling pre-installed.

## Context

dot-kubernetes already installs system-level applications (Traefik, Crossplane, Argo CD, NVIDIA GPU Operator, External Secrets, Cilium) as optional Helm-based components. This PRD extends that pattern with three new components:

1. **Envoy Gateway** — A Gateway API implementation that serves as the general-purpose gateway for all cluster traffic (replaces or supplements Traefik)
2. **KEDA** — Event-driven autoscaler that scales workloads based on external metrics (Prometheus, queue depth, custom triggers)
3. **Gateway API Inference Extension** — An add-on to Envoy Gateway that enables inference-aware routing (InferencePool, InferenceModel) for LLM workloads

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
      gatewayInferenceExtension:
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

#### Gateway API Inference Extension
- **Helm chart**: `oci://ghcr.io/kubernetes-sigs/gateway-api-inference-extension/charts/gateway-api-inference-extension`
- **Namespace**: `gateway-api-inference-extension`
- **Purpose**: Inference-aware routing (model selection, KV-cache-aware load balancing, criticality-based shedding, scale-to-zero request holding)
- **Consumers**: dot-inference only
- **Prerequisite**: Envoy Gateway must be enabled. If `gatewayInferenceExtension.enabled: true` and `envoyGateway.enabled: false`, the composition should either error or auto-enable Envoy Gateway

### Node Profile Considerations

- **CPU-only clusters**: Envoy Gateway + KEDA are relevant. Gateway API Inference Extension is not needed (no inference workloads without GPUs)
- **GPU clusters**: All three components are relevant
- **Validation**: The composition should not block `gatewayInferenceExtension` on GPU being enabled — users may have external GPU nodes or use CPU-based inference for small models

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

### KEDA + Prometheus Dependency
- KEDA's Prometheus trigger requires a Prometheus endpoint
- The vLLM Production Stack exposes metrics natively, but Prometheus itself must be scraping them
- Should dot-kubernetes also install Prometheus/Victoria Metrics? Or is that a separate concern?
- Recommendation: Document Prometheus as a prerequisite for metric-based scaling. Don't install it as part of this PRD — it's a larger observability concern

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
- [ ] Schema definition in `kcl/data.k`
- [ ] XRD property in `kcl/definition.k`
- [ ] Helm release in `kcl/apps.k`
- [ ] Dependency validation (requires Envoy Gateway)
- [ ] Chainsaw tests
- [ ] All tests passing

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-22 | Implement KEDA first | Simplest component, no dependencies on other new components, validates approach | Unblocks Envoy Gateway and Inference Extension work |
| 2026-02-22 | Use KEDA Helm chart v2.19.0 from kedacore repo | Latest stable version, standard Helm repository pattern | Version pinned in apps.k, Renovate will manage updates |
| 2026-02-22 | Use Envoy Gateway v1.7.0 via OCI registry | Latest stable release (Feb 2026), OCI distribution pattern | Version pinned in apps.k, uses _chartUrl for OCI |
| 2026-02-22 | HTTP-only default Gateway (no HTTPS) | HTTPS requires TLS certificate config best handled by consuming configurations | Users can add HTTPS listeners via dot-application or dot-inference |
