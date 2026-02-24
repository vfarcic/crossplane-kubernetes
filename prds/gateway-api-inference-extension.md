# PRD: Gateway API Inference Extension

**Status**: Pending
**Priority**: High
**Created**: 2026-02-22

## Problem Statement

Clusters provisioned by dot-kubernetes that serve LLM inference workloads need inference-aware routing — the ability to route requests based on model name, balance load using KV-cache awareness, and support features like LoRA adapter routing and scale-from-zero. Without the Gateway API Inference Extension, all inference traffic is treated as generic HTTP, missing significant optimization opportunities for LLM serving.

## Context

PRD #269 implemented Envoy Gateway and KEDA as cluster-level infrastructure. The Gateway API Inference Extension was originally scoped as a simple Helm install in PRD #269, but investigation reveals it is architecturally more complex:

- **CRDs** (`InferencePool`) must be installed cluster-wide so that downstream configurations (dot-inference) can create InferencePool instances
- The **Endpoint Picker (EPP)** is deployed per-InferencePool, not as a single cluster-wide component — this means dot-kubernetes only installs the CRDs and optionally the Body-Based Router, while actual InferencePool instances are created by consuming configurations
- The project is GA (v1.3.1, Feb 2026) under `kubernetes-sigs/gateway-api-inference-extension`

This PRD covers what dot-kubernetes should install at the cluster level. Per-workload InferencePool creation is a dot-inference concern.

## Proposed API Surface

Extend `spec.parameters.apps` with a new optional section:

```yaml
spec:
  parameters:
    apps:
      gatewayInferenceExtension:
        enabled: true
```

### What Gets Installed

When `gatewayInferenceExtension.enabled: true`:

1. **InferencePool CRD** — The GA `inference.networking.k8s.io/v1` CRD for `InferencePool`, installed as a Kubernetes Object so that downstream configurations can create InferencePool instances
2. **Body-Based Router (BBR)** — An optional ext-proc server that parses HTTP request bodies to extract the model name (for OpenAI API-compatible endpoints) and makes it available for gateway routing. Deployed as a cluster-wide service

### Component Details

#### InferencePool CRD
- **Source**: `https://github.com/kubernetes-sigs/gateway-api-inference-extension/releases/download/v1.3.1/v1-manifests.yaml`
- **API Group**: `inference.networking.k8s.io`
- **Kind**: `InferencePool` (namespaced)
- **Version**: v1 (GA)
- **Purpose**: Enables downstream configurations to create InferencePool instances that group model server pods and attach EPP (Endpoint Picker) sidecars for intelligent routing

#### Body-Based Router
- **Helm chart**: From `config/charts/body-based-routing` in the gateway-api-inference-extension repo (check OCI availability at `oci://ghcr.io/kubernetes-sigs/gateway-api-inference-extension/charts/body-based-routing`)
- **Namespace**: `gateway-api-inference-extension`
- **Purpose**: Parses the HTTP body of inference requests to extract model names, enabling the gateway to route based on `model` field in OpenAI-compatible chat completion requests
- **How it works**: Runs as an ext-proc filter in the Envoy Gateway pipeline, before the EPP

### Prerequisites

- **Envoy Gateway** must be enabled (`envoyGateway.enabled: true`). If `gatewayInferenceExtension.enabled: true` and `envoyGateway.enabled: false`, the composition should auto-enable Envoy Gateway or log a clear error
- Gateway API CRDs are bundled with Envoy Gateway's Helm chart

## Discussion Topics

### CRD Installation Strategy
- **Option A**: Install CRDs from the release manifest URL as Kubernetes Objects (similar to vLLM operator CRDs pattern)
- **Option B**: Install CRDs via the inferencepool Helm chart (but this chart is designed per-pool, not cluster-wide)
- **Recommendation**: Option A — install only the GA CRD (`InferencePool`) from the release manifests, matching the existing vLLM operator CRD pattern in `apps.k`

### Body-Based Router
- The BBR is a cluster-wide ext-proc service. It's useful when clients send model names in the HTTP body (OpenAI API format) rather than headers
- It may not be needed if clients set model names via HTTP headers directly
- **Recommendation**: Install BBR by default when inference extension is enabled. Most LLM clients use the OpenAI API format with model names in the body

### Experimental CRDs
- The project also has experimental CRDs: `InferenceModelRewrite`, `InferenceObjective`, `InferencePoolImport` (under `inference.networking.x-k8s.io`)
- **Recommendation**: Only install the GA CRD (`InferencePool` under `inference.networking.k8s.io`) for now. Experimental CRDs can be added later as they stabilize

### Envoy Gateway ext-proc Configuration
- Envoy Gateway needs an `EnvoyExtensionPolicy` to wire the BBR and EPP ext-proc filters into the request pipeline
- This configuration is typically per-InferencePool (dot-inference concern), but the BBR ext-proc may need cluster-level configuration
- **Decision needed**: Should dot-kubernetes configure the BBR ext-proc policy, or leave all ext-proc wiring to dot-inference?

## Implementation Approach

Follow the existing patterns in `kcl/apps.k`:

1. **Schema definition** in `kcl/data.k` — `appGatewayInferenceExtension` with `enabled` boolean
2. **XRD property** in `kcl/definition.k` — add under `spec.parameters.apps`
3. **CRD installation** in `kcl/apps.k` — install `InferencePool` CRD as a Kubernetes Object (same pattern as vLLM operator CRDs)
4. **BBR Helm release** in `kcl/apps.k` — conditional on inference extension being enabled
5. **Dependency validation** — check that Envoy Gateway is also enabled
6. **Chainsaw tests** — verify CRD and BBR resources are created

### Version Pinning
- Pin to v1.3.1 in `kcl/apps.k` (or `data.k`)
- CRD manifest URL includes version tag
- Renovate will manage updates

## Testing

- Extend Chainsaw tests with new test cases
- Test scenarios:
  - Inference extension enabled with Envoy Gateway enabled → CRD + BBR installed
  - Inference extension enabled without Envoy Gateway → verify behavior (error or auto-enable)
  - Inference extension disabled → no resources created
- Verify InferencePool CRD is present and correct apiVersion
- Verify BBR Helm release has correct chart and namespace
- Test across all 3 providers (AWS, Azure, Google)

## Dependencies

- **Upstream**: Envoy Gateway (PRD #269, already implemented)
- **Downstream**: dot-inference (will create InferencePool instances using the CRD installed here)

## Implementation Progress

### InferencePool CRD
- [ ] Schema definition in `kcl/data.k`
- [ ] XRD property in `kcl/definition.k`
- [ ] CRD installation as Kubernetes Object in `kcl/apps.k`
- [ ] Chainsaw tests (common patch + assertion, all 3 providers)
- [ ] All tests passing

### Body-Based Router
- [ ] Helm release in `kcl/apps.k`
- [ ] Chainsaw tests
- [ ] All tests passing

### Dependency Validation
- [ ] Envoy Gateway prerequisite check
- [ ] Chainsaw test for dependency behavior

### Manual Validation on Real Cluster
- [ ] Provision a real cloud cluster (EKS, AKS, or GKE) with `envoyGateway.enabled: true` and `gatewayInferenceExtension.enabled: true`
- [ ] Verify InferencePool CRD is installed and `kubectl get crd inferencepools.inference.networking.k8s.io` returns the GA v1 CRD
- [ ] Verify Body-Based Router pods are running in the expected namespace
- [ ] Create a test InferencePool instance to confirm the CRD is functional
- [ ] Verify Envoy Gateway and BBR ext-proc integration works end-to-end

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-22 | Split inference extension into separate PRD from #269 | Component is architecturally more complex than originally scoped — involves CRDs, per-pool EPP, and cluster-wide BBR | Clearer scope; PRD #269 can be completed with KEDA + Envoy Gateway |
| 2026-02-22 | Only install GA CRD (InferencePool v1) | Experimental CRDs are not stable; GA CRD is sufficient for dot-inference integration | Reduces maintenance burden; experimental CRDs added later |
| 2026-02-22 | Use v1.3.1 as initial version | Latest GA release (Feb 20, 2026) | Version pinned, Renovate manages updates |
