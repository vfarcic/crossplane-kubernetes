# PRD: Replace vLLM Production Stack with llm-d

**Status**: Complete
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

llm-d uses a modular multi-chart architecture. For dot-kubernetes (cluster-level infrastructure), two llm-d-specific components are needed, plus three generic infrastructure dependencies:

**llm-d-specific components:**
- **Workload Variant Autoscaler (WVA)**: SLO-aware, traffic-and-hardware-aware autoscaling for LLM inference workloads. Chart: `oci://ghcr.io/llm-d/workload-variant-autoscaler` v0.5.1, namespace: `workload-variant-autoscaler-system`.

**Generic infrastructure (auto-installed when llm-d is enabled):**
- **Redis/Valkey**: Distributed backend for the KV Cache Indexer. Valkey (Redis-compatible, BSD-licensed) is preferred.
- **LeaderWorkerSet (LWS) Controller**: Kubernetes SIG-apps multi-pod workload controller. Required for distributed tensor/expert parallelism (e.g., DeepSeek-R1, Llama 405B across multiple nodes).
- **OpenTelemetry Collector**: Distributed tracing across vLLM, EPP, and gateway.

Valkey gets its own `apps.valkey` toggle (usable independently of llm-d). LWS and OTel Collector are auto-installed when `llmd.enabled` (LWS) or `llmd.enabled or prometheus.enabled` (OTel) — no standalone toggles needed.

Per-model components (`llm-d-modelservice`, Endpoint Picker/EPP, routing sidecar, InferencePool CRs) are handled by crossplane-inference.

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

When enabled, deploy:
1. **WVA Helm release** — cluster-level autoscaler controller

Additionally, auto-install these generic dependencies (each also available as standalone `apps.*`):
2. **Redis/Valkey** — shared cluster-level backend (used by KV Cache Indexer instances deployed per-model by crossplane-inference)
3. **LeaderWorkerSet (LWS)** — multi-pod workload controller for distributed inference
4. **OpenTelemetry Collector** — distributed tracing

### Add: `apps.valkey`

New independent API field:

```yaml
spec:
  parameters:
    apps:
      valkey:
        enabled: true    # standalone, or auto-enabled by llmd
```

Valkey is a general-purpose Redis-compatible store usable beyond llm-d. The conditional pattern in `apps.k`:
```
if oxr.spec.parameters?.apps?.valkey?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled:
```

### Auto-installed infrastructure (no standalone toggles)

**LeaderWorkerSet (LWS)**: Auto-installed when `llmd.enabled` — only useful for multi-node distributed inference.

**OpenTelemetry Collector**: Auto-installed when `llmd.enabled or prometheus.enabled` — distributed tracing for inference and observability stacks.

## Relationship to crossplane-inference

- **dot-kubernetes** (this project): Installs cluster-level llm-d infrastructure (WVA, KV Cache Indexer) and generic dependencies (Redis/Valkey, LWS, OTel Collector)
- **crossplane-inference**: Composes per-model resources (llm-d-modelservice Helm release, Endpoint Picker/EPP, routing sidecar, InferencePool, HTTPRoute, InferenceObjective). See [crossplane-inference PRD #7](https://github.com/vfarcic/crossplane-inference/issues/7).

## Implementation Progress

### Milestone 1: Remove vLLM Production Stack
- [x] Remove `appVllm` schema from `kcl/data.k`
- [x] Remove all vLLM resources from `kcl/apps.k` (CRDs, RBAC, Deployment, Namespace, Service)
- [x] Remove vLLM test assertions from `tests/common/`
- [x] Run `just package-generate` and verify clean output
- [x] All existing tests pass with vLLM removed

### Milestone 2: Add llm-d components (WVA)
- [x] Add `appLlmd` schema to `kcl/data.k`
- [x] Wire `appLlmd` into `definition.k` XRD
- [x] Add WVA Helm release to `kcl/apps.k` gated on `llmd.enabled`
- [x] Add version variable for WVA chart (`wva = "0.5.1"`)
- [x] Run `just package-generate` and verify WVA Release appears in output

### Milestone 3: Add generic infrastructure apps (Valkey, LWS, OTel)
- [x] Add `appValkey` schema to `kcl/data.k` (LWS and OTel have no standalone toggles — see decision log)
- [x] Wire `valkey` into `definition.k` XRD
- [x] Add Valkey Helm release to `kcl/apps.k` (gated on `valkey.enabled` OR `llmd.enabled`)
- [x] Add LeaderWorkerSet Helm release to `kcl/apps.k` (gated on `llmd.enabled`)
- [x] Add OpenTelemetry Collector Helm release to `kcl/apps.k` (gated on `llmd.enabled` OR `prometheus.enabled`)
- [x] Add version variables for all three charts (`valkey = "0.9.3"`, `lws = "0.8.0"`, `opentelemetryCollector = "0.147.1"`)
- [x] Run `just package-generate` and verify Releases appear in output

### Milestone 4: Update tests and verify
- [x] Add llm-d assertion file in `tests/common/` (WVA)
- [x] Add Valkey, LWS, OTel assertion files in `tests/common/`
- [x] Update provider test claims to include `llmd.enabled: true`
- [x] Remove vLLM assertions from provider tests
- [x] `just test-once` passes for all providers

## Dependencies

- **Upstream**: llm-d WVA Helm chart (`oci://ghcr.io/llm-d/workload-variant-autoscaler`), llm-d KV Cache Indexer, Valkey Helm chart, LeaderWorkerSet Helm chart, OpenTelemetry Collector Helm chart
- **Downstream**: crossplane-inference — will consume WVA and KV Cache Indexer for per-model autoscaling and cache-aware routing

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
| 2026-03-31 | Include KV Cache Indexer as llm-d-specific cluster component | Cache-aware routing requires a global index of KV-cache block locations; this is llm-d's own component, not generic infra | Adds KV Cache Indexer + Redis/Valkey backend to cluster setup |
| 2026-03-31 | Redis, LWS, OTel as separate `apps.*` with auto-install from llmd | These are generic infra (not llm-d-specific) useful independently, but llm-d needs them as dependencies | 3 new `apps.*` entries; `llmd.enabled` auto-installs all three |
| 2026-03-31 | Per-model components (EPP, ModelService, routing sidecar) stay in crossplane-inference | EPP runs per-InferencePool, ModelService is per-model Helm release, sidecar is per-decode-pod | No per-model resources in dot-kubernetes |
| 2026-03-31 | All llm-d components are Helm-installable — no raw manifests needed | Unlike vLLM operator which required ~350 lines of hand-coded CRDs, RBAC, Deployments, etc., WVA is published as a Helm chart | Implementation is simple `chart {}` + `usage {}` blocks in apps.k, following the same pattern as KEDA/Prometheus/Envoy Gateway |
| 2026-03-31 | Drop KV Cache Indexer from dot-kubernetes — it's per-model, belongs in crossplane-inference | KV Cache Indexer is a library (v0.6.0) that runs per-InferencePool alongside EPP, not a cluster-level service. No standalone Helm chart exists. | Milestone 2 reduced to WVA only. Redis stays as cluster-level shared backend that per-model indexer instances connect to. |
| 2026-03-31 | Use `apps.valkey` instead of `apps.redis` | Valkey is the actual BSD-licensed implementation being deployed; using the real name avoids confusion | API field is `valkey`, not `redis` |
| 2026-03-31 | LWS has no standalone toggle — auto-installed by `llmd.enabled` only | LWS is only useful for multi-node distributed inference; nobody would enable it without llm-d | 1 fewer API field; simpler surface |
| 2026-03-31 | OTel Collector has no standalone toggle — auto-installed by `llmd.enabled` or `prometheus.enabled` | Tracing is an observability concern that pairs naturally with both inference and monitoring | 1 fewer API field; OTel appears whenever observability or inference is enabled |
