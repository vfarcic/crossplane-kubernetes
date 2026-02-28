# PRD: Envoy AI Gateway Controller Integration

**Status**: In Progress
**Priority**: High
**Created**: 2026-02-28
**GitHub Issue**: #273

## Problem Statement

When `envoyGateway.enabled: true`, Envoy Gateway crashes with `Error: registered extension has no hooks specified`. The `ExtensionManager` API type requires `hooks` and `service` fields (both `+kubebuilder:validation:Required`). Our current config only sets `backendResources` for InferencePool, which creates an `extensionManager` block but leaves the required fields empty.

The `service` field must point to the **AI Gateway controller** — a separate deployment that hooks into the xDS translation pipeline to translate InferencePool resources into xDS config. This controller doesn't exist in our current setup.

## Context

PR #272 added `extensionManager.backendResources` to the Envoy Gateway Helm values and inline CRDs (InferencePool, InferenceObjective) to support inference-aware routing. This was requested by crossplane-inference to unblock Gateway API + KEDA inference work.

Investigation revealed that the official [envoy-gateway-values-addon.yaml](https://github.com/envoyproxy/ai-gateway/blob/main/examples/inference-pool/envoy-gateway-values-addon.yaml) (which we copied) is meant to be combined with a [base values file](https://github.com/envoyproxy/ai-gateway/blob/main/manifests/envoy-gateway-values.yaml) that includes `hooks` and `service` pointing to the AI Gateway controller.

The full architecture requires:
1. **Envoy Gateway** — Core gateway (already installed)
2. **AI Gateway controller** — Extension server that handles InferencePool xDS translation (missing)
3. **Per-InferencePool EPP** — Endpoint Picker deployed per inference workload (crossplane-inference concern)

This PRD covers deploying the AI Gateway controller (#2) and fixing the extensionManager configuration. The inline CRDs from PR #272 remain unchanged (established pattern matching vLLM stack).

Related: `prds/gateway-api-inference-extension.md` (predecessor PRD, partially superseded — the CRDs and extensionManager are now bundled with `envoyGateway.enabled` rather than a separate flag).

## Solution

When `envoyGateway.enabled: true`, deploy the full Envoy AI Gateway stack:

1. **AI Gateway controller** via Helm chart `oci://docker.io/envoyproxy/ai-gateway-helm`
2. **Full extensionManager** with hooks + service + backendResources
3. No XRD changes — everything bundled with `envoyGateway.enabled`

## Technical Details

### AI Gateway Controller
- **Helm chart**: `oci://docker.io/envoyproxy/ai-gateway-helm`
- **Namespace**: `envoy-ai-gateway-system`
- **Image**: `docker.io/envoyproxy/ai-gateway-controller`
- **Ports**: gRPC 1063 (extensionManager), webhook 9443, metrics 8080
- **Health probes**: gRPC on port 1063
- **Includes**: RBAC for reading InferencePool resources, mutating webhook for Envoy Gateway-managed pods

### ExtensionManager Helm Values
```yaml
config:
  envoyGateway:
    extensionApis:
      enableBackend: true
    extensionManager:
      hooks:
        xdsTranslator:
          translation:
            listener:
              includeAll: true
            route:
              includeAll: true
            cluster:
              includeAll: true
            secret:
              includeAll: true
          post:
            - Translation
            - Cluster
            - Route
      service:
        fqdn:
          hostname: ai-gateway-controller.envoy-ai-gateway-system.svc.cluster.local
          port: 1063
      backendResources:
        - group: inference.networking.k8s.io
          kind: InferencePool
          version: v1
```

## Implementation Progress

### Milestone 1: Deploy AI Gateway controller Helm release
- [ ] Add version variable for AI Gateway chart in `kcl/apps.k`
- [ ] Add `chart` block for `ai-gateway-helm` gated on `envoyGateway.enabled`
- [ ] Add `usage` resource for the new Release
- [ ] Verify package generates correctly

### Milestone 2: Update Envoy Gateway extensionManager Helm values
- [ ] Replace `backendResources`-only config with full extensionManager (hooks + service + backendResources)
- [ ] Add `extensionApis.enableBackend: true`
- [ ] Verify package generates correctly

### Milestone 3: Update tests and verify
- [ ] Update `assert-envoy-gateway.yaml` with full extensionManager values and AI Gateway controller Release
- [ ] Add usage assertion for AI Gateway controller Release in AWS chainsaw test
- [ ] All 4 Chainsaw tests pass

### Milestone 4: Respond to crossplane-inference
- [ ] Write `../crossplane-inference/tmp/feature-response.md` with implementation details
- [ ] Delete `tmp/feature-request.md`

## Dependencies

- **Upstream**: Envoy Gateway (PRD #269, complete)
- **Downstream**: crossplane-inference (blocked on this — Envoy Gateway crash prevents inference routing validation)

## References

- [Envoy AI Gateway repo](https://github.com/envoyproxy/ai-gateway)
- [ExtensionManager API types](https://github.com/envoyproxy/gateway/blob/main/api/v1alpha1/envoygateway_types.go)
- [AI Gateway controller Helm chart](https://github.com/envoyproxy/ai-gateway/tree/main/manifests/charts/ai-gateway-helm)
- [Base extensionManager values](https://github.com/envoyproxy/ai-gateway/blob/main/manifests/envoy-gateway-values.yaml)
- [InferencePool addon values](https://github.com/envoyproxy/ai-gateway/blob/main/examples/inference-pool/envoy-gateway-values-addon.yaml)

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-28 | Bundle AI Gateway controller with `envoyGateway.enabled` | Avoid extending XRD; AI Gateway is needed for InferencePool routing which is core to Envoy Gateway's inference story | No XRD changes; clusters come ready for inference |
| 2026-02-28 | Keep inline CRDs (InferencePool, InferenceObjective) | No Helm chart exists for just the inference extension CRDs; inline approach matches vLLM pattern; file-based injection adds fragile string escaping complexity | 15 lines of KCL per CRD; update manually when upstream changes |
| 2026-02-28 | Remove `extensionManager.backendResources`-only config | Causes Envoy Gateway crash — `hooks` and `service` are required fields | Must deploy AI Gateway controller before extensionManager works |
