# PRD: GPU/Inference-Capable Cluster Support

**Issue**: #264
**Priority**: High
**Status**: Complete (Milestone 10 deferred)

## Problem

Provisioned Kubernetes clusters only support general-purpose compute nodes. Users who want to run AI inference workloads (LLMs like Qwen, Kimi, embedding models) cannot do so because the clusters lack GPU hardware and the GPU software stack.

## Solution

Add two optional features following existing codebase patterns:

1. **`spec.parameters.gpu`** — new parameter section (sibling to `usage`) that creates a dedicated GPU node pool per cloud provider with appropriate GPU instance types, labels (`gpu=true`), and taints (`nvidia.com/gpu=true:NoSchedule`)
2. **`spec.parameters.apps.nvidia`** — optional NVIDIA GPU Operator Helm chart (v25.10.1) for GPU driver and device plugin management

No inference serving framework is included — that is a separate concern. This PRD focuses solely on making clusters GPU-capable.

## GPU Instance Types

| Size   | AWS              | Azure                    | Google                       |
|--------|------------------|--------------------------|------------------------------|
| small  | g5.xlarge (A10G) | Standard_NC4as_T4_v3     | n1-standard-4 + 1x T4       |
| medium | g5.2xlarge (A10G)| Standard_NC8as_T4_v3     | n1-standard-8 + 1x T4       |
| large  | g5.12xlarge (4xA10G) | Standard_NC24ads_A100_v4 | a2-highgpu-1g (1x A100) |

## Design Decisions

- **Separate GPU node pool** alongside the existing general-purpose pool (system pods, GPU operator, etc. run on regular nodes)
- **`gpu` as a top-level parameter** (not under `apps`) since it creates infrastructure, not an app
- **Taints on GPU nodes** prevent non-GPU workloads from wasting expensive GPU resources
- **NVIDIA GPU Operator** handles drivers uniformly across all three cloud providers

## Success Criteria

- Users can create a cluster resource with `gpu.enabled: true` and get a working GPU node pool
- Users can enable the NVIDIA GPU Operator via `apps.nvidia.enabled: true`
- GPU node pool is correctly configured per cloud provider (instance types, labels, taints)
- All existing tests continue to pass (no regressions)
- New Chainsaw tests validate GPU resources are created correctly

## Files Affected

- `kcl/data.k` — new `gpu` and `appNvidia` schemas
- `kcl/definition.k` — wire new schemas into XRD
- `kcl/apps.k` — NVIDIA GPU Operator Helm release
- `kcl/aws.k` — conditional GPU NodeGroup
- `kcl/google.k` — conditional GPU NodePool with guest accelerators
- `kcl/azure.k` — conditional GPU KubernetesClusterNodePool
- `tests/` — new test steps and assertions per provider + common nvidia assertion
- `examples/` — example Cluster with GPU enabled

## Milestones

### 0. Baseline
- [x] Existing test suite passes (baseline verified, pre-existing issues fixed)

### 1. GPU Schema & XRD
- [x] RED: Chainsaw test asserts `gpu` fields exist in XRD
- [x] GREEN: Add `gpu` schema to `data.k`, wire into `definition.k`

### 2. Transition to Namespace-Scoped Resources
- [x] Migrate XRD from `ClusterClaim`/`CompositeCluster` to namespace-scoped `.m` resources (Crossplane v2 pattern)
- [x] Update all existing tests to use the new resource kinds
- [x] Verify existing test suite passes after migration

### 3. AWS GPU Node Pool
- [x] RED: Chainsaw test asserts AWS GPU NodeGroup is created
- [x] GREEN: Implement conditional GPU NodeGroup in `aws.k`
- [x] Manual validation: create minimal GPU cluster in AWS with NVIDIA GPU Operator, verify GPU NodeGroup reaches Ready and `nvidia.com/gpu` is allocatable, destroy

### 4. NVIDIA GPU Operator
- [x] RED: Chainsaw test asserts NVIDIA GPU Operator Helm release is created
- [x] GREEN: Implement NVIDIA GPU Operator in `apps.k` with `appNvidia` schema in `data.k`

### 5. AWS GPU + NVIDIA Manual Validation
- [x] Create GPU cluster in AWS with `gpu.enabled: true` and `apps.nvidia.enabled: true`
- [x] Verify GPU NodeGroup reaches Ready and NVIDIA device plugin exposes `nvidia.com/gpu` on nodes
- [x] Destroy cluster

### 6. Azure GPU Node Pool
- [x] RED: Chainsaw test asserts Azure GPU KubernetesClusterNodePool is created
- [x] GREEN: Implement conditional GPU node pool in `azure.k`
- [x] Manual validation: create minimal GPU cluster in Azure (`gpu.enabled: true`, `gpu.nodeSize: small`), verify GPU node pool reaches Ready, destroy

### 7. Google GPU Node Pool
- [x] RED: Chainsaw test asserts Google GPU NodePool with guest accelerators is created
- [x] GREEN: Implement conditional GPU NodePool in `google.k`
- [x] Manual validation: create minimal GPU cluster in GCP (`gpu.enabled: true`, `gpu.nodeSize: small`), verify GPU NodePool reaches Ready, destroy

### 8. Examples
- [x] Add example Cluster with GPU configuration

### 9. API Domain Migration
- [x] Change XRD API group from `devopstoolkitseries.com` to `devopstoolkit.ai` in `kcl/definition.k` and `kcl/compositions.k`
- [x] Update all test files and examples to use `devopstoolkit.ai/v2`
- [x] Regenerate `package/` via `just package-generate`
- [x] Verify all tests pass after migration

### 10. Renovate for Dependency Management
- [~] Add `renovate.json` with custom regex managers for `providers/*.yaml` and `kcl/crossplane.k`
- [~] Ensure Renovate can auto-detect and update Crossplane provider package versions
- [~] Validate Renovate PRs don't break KCL generation pipeline

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-10 | Migrate to Crossplane v2 namespace-scoped XRDs (`scope: Namespaced`) | Crossplane v2 eliminates claim/composite distinction; namespace-scoped XRs are the new default pattern | XRD apiVersion → `v2`, kind → `Cluster`, removed `claimNames`/`connectionSecretKeys`, Crossplane-managed fields move under `spec.crossplane.*` |
| 2026-02-10 | Switch all managed resources to `.m` namespace-scoped APIs | Crossplane v2 rejects cluster-scoped composed resources under namespace-scoped XRs (`cannot apply cluster scoped composed resource for a namespaced composite resource`) | All KCL compositions and test assertions must reference `.m` API groups (e.g., `eks.aws.m.upbound.io/v1beta1` instead of `eks.aws.upbound.io/v1beta1`) |
| 2026-02-10 | Replace `oxr.spec.claimRef.namespace` with `oxr.metadata.namespace` | Namespace-scoped XRs have namespace directly in metadata, no claimRef | 5 occurrences in KCL composition functions (`apps.k`, `aws.k`, `google.k`, `azure.k`) |
| 2026-02-10 | Replace `oxr.spec.compositionSelector` with `oxr.spec.crossplane.compositionSelector` | Crossplane v2 moves Crossplane-managed fields under `spec.crossplane.*` | All KCL functions referencing compositionSelector (12 occurrences in `apps.k`) |
| 2026-02-10 | Bump provider dependency versions to `>=v2.3.0` | `.m` namespace-scoped APIs require provider v2.x packages | `kcl/crossplane.k` dependency constraints updated |
| 2026-02-10 | Add Renovate for automated dependency updates | Provider versions are hardcoded in `providers/*.yaml` and `kcl/crossplane.k`; manual tracking is error-prone | New Milestone 8; separate from GPU work but identified as a gap during v2 migration |
| 2026-02-10 | Bump CRD API version to `devopstoolkit.ai/v2` | Breaking change (ClusterClaim → namespace-scoped Cluster) warrants major version bump; keeps API version in sync with package version | XRD version name `v1alpha1` → `v2`, all test/example files updated, `.semver.yaml` set to `v2.0.0` |
| 2026-02-10 | Add ManagedResourceActivationPolicy for namespace-scoped resources only | Halves CRD count (294 → 147 active) by deactivating cluster-scoped MRDs; reduces API server overhead | New `providers/managed-resource-activation-policy.yaml`, Helm install uses `provider.defaultActivations={}` |
| 2026-02-10 | GCP `taint` field stays as list (not map) in `.m` API | Unlike `vpcConfig`/`scalingConfig`/`defaultNodePool` which flattened to maps, `taint` is `type: array` — nodes can have multiple taints | `google.k` keeps `taint = [{...}]` syntax; test assertions use list format |
| 2026-02-10 | `.m` API schema changes: `deletionPolicy` → `managementPolicies`, `providerConfigRef.kind` required | `.m` namespace-scoped MRs removed `deletionPolicy` (use `managementPolicies` instead), and require `providerConfigRef.kind` to distinguish `ProviderConfig` vs `ClusterProviderConfig` | All KCL source and test assertions updated; `deletionPolicy: Orphan` → `managementPolicies: [Create, Update, Observe]` |
| 2026-02-10 | `crossplane.io/claim-name` label replaced by `crossplane.io/composite` | Crossplane v2 has no claims; the old label was a bug (GitHub issue #6363, fixed in PR #6541) | All test assertions updated to use `crossplane.io/composite` |
| 2026-02-10 | Remove hardcoded Kubernetes version default from all providers | All three cloud providers support omitting version (defaults to latest); hardcoding pins clusters to stale versions | `aws.k` removed `version = "1.30"` fallback, `google.k` and `azure.k` now conditionally set version only when user specifies it |
| 2026-02-10 | Reorganize milestones: NVIDIA before Azure/Google | NVIDIA GPU Operator is needed to validate GPUs are actually usable (exposes `nvidia.com/gpu`); testing Azure/Google without it only validates node pool creation, not GPU functionality | Milestone order: AWS → NVIDIA → AWS manual validation → Azure → Google |
| 2026-02-10 | Bump all Helm chart dependency versions to latest stable | Versions were significantly outdated (some 2+ major versions behind); updated Crossplane 1.14.5→2.1.4, Argo CD 3.35.4→9.4.1, Dapr 1.12.4→1.16.8, Traefik 26.0.0→39.0.0, External Secrets 0.9.11→2.0.0, Cilium 1.14.2→1.19.0 | `kcl/apps.k` version constants and 9 test assertion files updated; all tests pass |
| 2026-02-11 | Remove `spec.id`, use `oxr.metadata.name` | In Crossplane v2 namespace-scoped resources, `metadata.name` already serves as identity; redundant `spec.id` caused AKS node pool naming failures (hyphens not allowed) | All KCL files updated (`oxr.spec.id` → `oxr.metadata.name`), `id` removed from XRD schema, all tests/examples updated |
| 2026-02-11 | AKS node pool names must be alphanumeric only | Azure rejects hyphens in `agentPoolProfile.name`; default pool uses `nodepool1`, GPU pool external name uses `gpu` | `azure.k` default node pool name hardcoded to `nodepool1`, GPU pool `crossplane.io/external-name` set to `gpu` |
| 2026-02-11 | Add Chainsaw test cleanup scripts to patch ProviderConfig finalizers | `in-use.crossplane.io` finalizer on ProviderConfigs blocks namespace deletion during test cleanup; Crossplane Usage controller doesn't remove finalizer fast enough during parallel garbage collection | All 3 provider chainsaw tests add cleanup step: delete Cluster, sleep, patch out finalizers |
| 2026-02-13 | Change API group domain from `devopstoolkit.ai` to `devopstoolkit.ai` | Rebranding — new domain is shorter and more aligned with the project's AI/ML focus | All KCL source files (`definition.k`, `compositions.k`), all test files, examples, and `CLAUDE.md` must replace `devopstoolkit.ai` with `devopstoolkit.ai`; API version stays `v2` |
| 2026-02-11 | GPU device plugin must be deployed on AWS and Azure; GKE auto-installs it | EKS `AL2023_x86_64_NVIDIA` AMI pre-installs NVIDIA drivers but NOT the device plugin (`nvidia.com/gpu` does not appear without GPU Operator). AKS also installs drivers only. GKE is the only provider that auto-installs both drivers and device plugin. | AWS GPU NodeGroup uses `amiType: AL2023_x86_64_NVIDIA` (faster GPU Operator startup — skips driver install); `apps.nvidia` (GPU Operator) is required for AWS and Azure, optional for GKE |
| 2026-02-13 | GKE GPU NodePool must exclude `us-east1-b` from nodeLocations | T4 GPUs (`nvidia-tesla-t4`) are not available in `us-east1-b`; GKE API returns `accelerator type "nvidia-tesla-t4" does not exist in zone us-east1-b` | GPU nodeLocations reduced to `["us-east1-c", "us-east1-d"]`; regular NodePool keeps all three zones |
| 2026-02-13 | GKE GPU nodes must not have explicit `nvidia.com/gpu` taint | GKE auto-adds `nvidia.com/gpu=present:NoSchedule` taint via `effectiveTaints`; specifying it explicitly causes `found more than one taint with key nvidia.com/gpu` error | Removed explicit taint from `google.k` GPU NodePool; GKE handles taint automatically unlike AWS/Azure |
| 2026-02-13 | Cilium v1.19.0 requires `authentication.enabled=true` for SPIRE | Newer Cilium chart validates that `authentication.enabled=true` is set when `authentication.mutual.spire.enabled=true` | Added `authentication.enabled=true` to Cilium Helm set values for both Google and Azure compositions |
| 2026-02-13 | Defer Milestone 10 (Renovate custom regex managers) | Existing `renovate.json` already handles `providers/*.yaml` via built-in `crossplane` manager; custom regex managers for `kcl/crossplane.k` (floor constraints) and `kcl/apps.k` (Helm chart versions) add complexity for marginal benefit | Milestone 10 marked deferred; basic Renovate config remains functional for provider package updates |
| 2026-02-13 | Split CI: test on PR, release on main | Tests ran only on push to main, meaning broken code could be merged; splitting ensures PRs are validated before merge | `build12.yaml` replaced by `test.yaml` (PR trigger) and `release.yaml` (push to main, publish only) |

## Risks

- **GPU instance availability**: GPU instances may not be available in all regions; we hardcode `us-east-1` / `us-east1` / `eastus` matching existing provider defaults
- **vLLM Helm chart values**: Not applicable — no inference framework in this PRD
- **Azure GPU node pool API**: `KubernetesClusterNodePool` resource field names need verification against Upbound provider CRDs
- **GKE guest accelerator syntax**: The `guestAccelerator` field format may vary by Upbound provider version
- **`.m` API version differences**: Some `.m` APIs use different versions than their cluster-scoped counterparts (e.g., GCP `v1beta2` → `v1beta1`, Kubernetes Object `v1alpha2` → `v1alpha1`); schema fields may differ between versions
