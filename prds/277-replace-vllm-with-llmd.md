# PRD: Replace vLLM Production Stack with llm-d

**Status**: In Progress
**Priority**: High
**Created**: 2026-03-31
**GitHub Issue**: #277

## Problem Statement

The vLLM Production Stack operator (`apps.vllm`) continuously reconciles `Deployment.spec.replicas` from `deploymentConfig.replicas`, making it impossible to use any external autoscaler (KEDA, HPA). This was the blocking issue that deferred the Gateway + KEDA inference work in crossplane-inference.

The [crossplane-inference](https://github.com/vfarcic/crossplane-inference) project is switching to [llm-d](https://llm-d.ai/) — a CNCF Sandbox project (accepted March 2026) backed by Red Hat, Google Cloud, IBM, CoreWeave, and NVIDIA — for model serving. dot-kubernetes must replace the cluster-level vLLM infrastructure with llm-d infrastructure.

## Context

### What exists today (`apps.vllm`)

When `apps.vllm.enabled: true`, the following are installed:
- 4 CRDs: `CacheServer`, `LoraAdapter`, `VLLMRouter`, `VLLMRuntime` (API group `production-stack.vllm.ai`)
- Namespace `production-stack-system`
- Full RBAC: ServiceAccount, Role, ClusterRoles, RoleBindings, ClusterRoleBindings
- Metrics Service (port 8443)
- Controller-manager Deployment (`lmcache/production-stack-operator:2025-12-12`)

### What llm-d needs at the cluster level

llm-d uses a modular multi-chart architecture. For dot-kubernetes (cluster-level infrastructure), only the **Workload Variant Autoscaler (WVA)** is needed:

- **Chart**: `oci://ghcr.io/llm-d/workload-variant-autoscaler`
- **Namespace**: `workload-variant-autoscaler-system`
- **Purpose**: SLO-aware, traffic-and-hardware-aware autoscaling for LLM inference workloads
- **Scope**: Cluster-level controller (not per-model)

Per-model components (`llm-d-modelservice`, `inferencepool` EPP) are handled by crossplane-inference.

### What stays unchanged

- `apps.envoyGateway` — Already provides Envoy Gateway + AI Gateway Controller + GAIE CRDs (InferencePool v1, InferenceObjective v1alpha2). llm-d uses this as its GAIE-compatible gateway.
- `apps.keda` — Generic event-driven autoscaler, useful beyond inference.
- `apps.nvidia` — GPU Operator, still required.
- `apps.prometheus` — Monitoring stack, still required.
- `gpu` node pool configuration — Unchanged.

## Solution

### Remove: `apps.vllm`

Delete all vLLM Production Stack resources from `kcl/apps.k` and the `appVllm` schema from `kcl/data.k`. Remove test assertions for vLLM.

### Add: `apps.llmd`

New API field:

```yaml
spec:
  parameters:
    apps:
      llmd:
        enabled: true
```

When enabled, deploy a single Helm release for the WVA controller. No dependency on other apps — the WVA operates independently and works with InferencePool resources (CRDs already installed by `envoyGateway`).

## Relationship to crossplane-inference

- **dot-kubernetes** (this project): Installs cluster-level llm-d infrastructure (WVA controller)
- **crossplane-inference**: Composes per-model resources (llm-d-modelservice Helm release, InferencePool, EPP, HTTPRoute, InferenceObjective). See [crossplane-inference PRD #7](https://github.com/vfarcic/crossplane-inference/issues/7).

## Implementation Progress

### Milestone 1: Remove vLLM Production Stack
- [x] Remove `appVllm` schema from `kcl/data.k`
- [x] Remove all vLLM resources from `kcl/apps.k` (CRDs, RBAC, Deployment, Namespace, Service)
- [x] Remove vLLM test assertions from `tests/common/`
- [x] Run `just package-generate` and verify clean output
- [x] All existing tests pass with vLLM removed

### Milestone 2: Add llm-d Variant Autoscaler
- [ ] Add `appLlmd` schema to `kcl/data.k`
- [ ] Wire `appLlmd` into `definition.k` XRD
- [ ] Add WVA Helm release to `kcl/apps.k` gated on `llmd.enabled`
- [ ] Add version variable for WVA chart
- [ ] Run `just package-generate` and verify WVA Release appears in output

### Milestone 3: Update tests and verify
- [ ] Add llm-d assertion file in `tests/common/`
- [ ] Update provider test claims to include `llmd.enabled: true`
- [x] Remove vLLM assertions from provider tests
- [ ] `just test-once` passes for all providers

## Dependencies

- **Upstream**: llm-d Workload Variant Autoscaler Helm chart (`oci://ghcr.io/llm-d/workload-variant-autoscaler`)
- **Downstream**: crossplane-inference — will consume the WVA controller for per-model autoscaling

## References

- [llm-d project](https://llm-d.ai/)
- [llm-d GitHub org](https://github.com/llm-d)
- [Workload Variant Autoscaler repo](https://github.com/llm-d/llm-d-workload-variant-autoscaler)
- [crossplane-inference PRD #7](https://github.com/vfarcic/crossplane-inference/issues/7) — llm-d integration on inference side
- Previous vLLM PRDs: #266 (vllm-inference-ready), #275 (scale subresource workaround)

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-03-31 | Replace vLLM with llm-d | vLLM operator fights autoscalers; llm-d is CNCF Sandbox with broad industry backing | Remove ~350 lines of vLLM KCL; add ~20 lines for WVA Helm release |
| 2026-03-31 | Keep KEDA and Envoy Gateway | Both serve purposes beyond inference (generic autoscaling, general gateway) | No changes to existing apps |
| 2026-03-31 | Only install WVA at cluster level | Per-model components (modelservice, EPP) belong in crossplane-inference | Clean separation of cluster-level vs workload-level concerns |
