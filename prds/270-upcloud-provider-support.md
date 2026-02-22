# PRD: Add UpCloud (UKS) as a Fourth Cloud Provider

**Issue**: #270
**Priority**: Medium
**Status**: Blocked

## Problem

The project currently supports only three cloud providers (AWS/EKS, Azure/AKS, Google/GKE). Users who want to provision Kubernetes clusters on UpCloud's managed Kubernetes service (UKS) cannot do so. UpCloud is a European cloud provider popular for its simplicity and performance, and an official Crossplane provider (`upcloud/provider-upcloud`) already exists on the Upbound Marketplace.

## Solution

Add UpCloud as a fourth cloud provider following existing patterns:

1. **`kcl/upcloud.k`** — provider-specific KCL file creating UKS resources (`KubernetesCluster`, `KubernetesNodeGroup`) via the `uks.m.upcloud.com/v1alpha1` API
2. **`providers/upcloud.yaml`** — provider package dependency for `upcloud/provider-upcloud`
3. **Composition `cluster-upcloud`** — new entry in `kcl/compositions.k` with `provider=upcloud, cluster=uks` labels
4. **Network resources** — UpCloud network via `network.m.upcloud.com/v1alpha1` (required by UKS)
5. **Tests** — full Chainsaw test suite in `tests/upcloud/`

Users will select UpCloud via `spec.crossplane.compositionSelector.matchLabels.provider: upcloud`.

## UpCloud Resource Mapping

The official `upcloud/provider-upcloud` (v0.1.1) provides these managed resources:

| Resource | API Group (namespace-scoped) | Version |
|----------|------------------------------|---------|
| KubernetesCluster | `uks.m.upcloud.com` | `v1alpha1` |
| KubernetesNodeGroup | `uks.m.upcloud.com` | `v1alpha1` |
| Network | `network.m.upcloud.com` | `v1alpha1` |
| Router | `network.m.upcloud.com` | `v1alpha1` |

## Node Size Mapping

| Size | UpCloud Node Plan | Cluster Plan |
|------|-------------------|--------------|
| small | `2xCPU-4GB` | `dev-md` (max 30 nodes) |
| medium | `4xCPU-8GB` | `prod-md` (max 120 nodes) |
| large | `8xCPU-32GB` | `prod-md` (max 120 nodes) |

## GPU Node Size Mapping

| GPU Size | UpCloud GPU Plan | Notes |
|----------|-----------------|-------|
| small | `GPU-8xCPU-64GB-1xL40S` | 1x NVIDIA L40S, testing/small inference |
| medium | TBD — depends on available UpCloud GPU plans | 4x GPU equivalent if available |
| large | TBD — depends on available UpCloud GPU plans | 8x GPU equivalent if available |

GPU node groups follow the same pattern as other providers: `nvidia.com/gpu=true:NoSchedule` taint, `gpu=true` label. Since UKS only exposes static `nodeCount` (not min/max), the `gpu.minNodeCount` parameter maps to a fixed count. NVIDIA GPU Operator and vLLM Production Stack are installed via `apps.k` (cloud-agnostic).

## Design Decisions

- **Follow existing provider patterns** — same composition pipeline (provider KCL → apps KCL → auto-ready), same test structure, same parameter schema
- **GPU support included** — UpCloud provider supports GPU node groups (e.g., `GPU-8xCPU-64GB-1xL40S`) with `gpuPlan` block; NVIDIA GPU Operator and vLLM are cloud-agnostic via `apps.k`
- **Cilium is pre-installed by UKS** — UKS comes with Cilium as its built-in CNI; skip Cilium installation in `apps.k` for `upcloud` provider (unlike other providers where we install it)
- **External Secrets** — defer UpCloud-specific secret store integration; UpCloud has no secrets manager service
- **Provider version caveat** — `upcloud/provider-upcloud` is v0.1.1 (alpha, not recommended for production per upstream docs); document this limitation clearly
- **Mandatory Network resource** — UKS requires an explicit SDN Private Network created before the cluster (unlike EKS/AKS/GKE where VPC/VNET can be more implicit); `kcl/upcloud.k` must compose a `Network` resource alongside the cluster
- **Static node count** — UKS node groups expose `nodeCount` (fixed), not `minNodeCount`/`maxNodeCount`; our `minNodeCount` parameter maps directly to `nodeCount`
- **Cluster plan based on nodeSize** — `dev-md` for small (development/testing), `prod-md` for medium/large (production workloads with higher node limits)
- **Load balancing via Kubernetes** — no Crossplane `LoadBalancer` CRD exists, but Ingress controllers (Traefik) and Gateway API implementations create `Service` type `LoadBalancer` which UKS handles natively
- **Default zone** — use `de-fra1` (Frankfurt) as default zone; well-connected European region

## Success Criteria

- Users can create a Cluster with `provider: upcloud` and get a working UKS cluster
- Node pool scales according to `minNodeCount` and `nodeSize` parameters
- Kubeconfig is written to a connection secret for downstream use
- Application deployment layer (`apps.k`) works with UKS clusters (Helm, Kubernetes providers)
- All existing tests continue to pass (no regressions)
- New Chainsaw tests validate UpCloud-specific resources

## Files Affected

- `kcl/upcloud.k` — new provider-specific KCL file (UKS cluster + node group + optional networking)
- `kcl/compositions.k` — add `cluster-upcloud` composition entry
- `kcl/crossplane.k` — add `upcloud/provider-upcloud` dependency
- `kcl/apps.k` — add UpCloud cluster API version/kind constants for Usage resources and ProviderConfig
- `providers/upcloud.yaml` — new provider package manifest
- `providers/provider-config-upcloud.yaml` — UpCloud authentication ProviderConfig
- `tests/upcloud/` — new test directory with chainsaw-test.yaml and assertion files
- `examples/` — example Cluster manifests for UpCloud

## Milestones

### 1. Provider Setup & Composition Wiring
- [x] Add `upcloud/provider-upcloud` to `kcl/crossplane.k` dependencies
- [x] Create `providers/upcloud.yaml` with provider package
- [x] Create `providers/provider-config-upcloud.yaml` for UpCloud auth
- [x] Add `cluster-upcloud` composition entry in `kcl/compositions.k`
- [x] Verify `just package-generate` produces valid output with the new composition

### 2. UKS Cluster & Node Group (kcl/upcloud.k)
- [x] RED: Chainsaw test asserts UKS KubernetesCluster and KubernetesNodeGroup resources are created
- [x] GREEN: Implement `kcl/upcloud.k` with KubernetesCluster, KubernetesNodeGroup, and Network resources
- [x] Map `nodeSize` (small/medium/large) to appropriate UpCloud node plans
- [x] Map cluster plan: `dev-md` for small, `prod-md` for medium/large
- [x] Configure kubeconfig secret output for downstream providers
- [x] Add GPU node group support: conditional `KubernetesNodeGroup` with GPU plan, `gpuPlan` block, `nvidia.com/gpu=true:NoSchedule` taint, and `gpu=true` label

### 3. Application Layer Integration
- [x] Add UpCloud cluster API version/kind to `apps.k` placeholder replacement
- [ ] Ensure Helm and Kubernetes ProviderConfigs work with UKS kubeconfig
- [ ] Verify Usage resources reference correct UpCloud cluster API

### 4. Chainsaw Test Suite
- [x] Create `tests/upcloud/chainsaw-test.yaml` with bindings (hyperscaler=upcloud, cluster=uks, clusterApi/clusterKind)
- [ ] Create install, assert, update, and app test steps following existing provider patterns
- [ ] Reuse common assertions from `tests/common/`
- [x] All UpCloud-specific tests pass (core resources — Cycle 1)

### 5. Examples & Documentation
- [ ] Add example Cluster manifest for UpCloud
- [ ] Update any existing examples that list available providers

### 6. Manual Validation
- [ ] Create a real UKS cluster via the Crossplane composition
- [ ] Verify node pool scaling and kubeconfig connectivity
- [ ] Deploy a sample app via the apps layer (Helm release)
- [ ] Destroy cluster and verify cleanup

## Risks

- **BLOCKER: Provider image missing platform annotations** — The `xpkg.upbound.io/upcloud/provider-upcloud:v0.1.1` container image manifest has empty `architecture` and `os` fields on all entries, so the controller pod fails with `ImagePullBackOff` on any platform (including ARM64/Apple Silicon). CRDs install fine via Crossplane package extraction, so composition tests pass, but the provider controller cannot run. Reported to maintainers — waiting for response. Compare with `provider-aws-eks` which correctly declares `amd64/linux` and `arm64/linux` platform annotations.
- **Alpha provider** — `upcloud/provider-upcloud` is v0.1.1; API surface may change, and some resources may have bugs or missing fields
- **Limited resource coverage** — the provider does not support load balancers or NAT gateways via Crossplane; load balancing works through Kubernetes-native `Service` type `LoadBalancer`
- **No autoscaling via Crossplane** — UKS supports native autoscaling, but the CRD only exposes static `nodeCount`; our `minNodeCount` maps to a fixed count
- ~~**CNI requirements**~~ — **Resolved**: UKS comes with Cilium pre-installed
- ~~**No `.m` API group confirmation**~~ — **Resolved**: Confirmed `.m` API groups exist (`uks.m.upcloud.com`, `network.m.upcloud.com`, `provider.m.upcloud.com`)
- ~~**Regional availability**~~ — **Resolved**: Using `de-fra1` (Frankfurt) as default zone

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| 2026-02-22 | Node plan mapping: small=`2xCPU-4GB`, medium=`4xCPU-8GB`, large=`8xCPU-32GB` | Self-describing plan names from UpCloud's General Purpose server family | Straightforward mapping in `upcloud.k` |
| 2026-02-22 | Cluster plan: `dev-md` for small, `prod-md` for medium/large | Small signals dev/test (30 node limit sufficient), medium/large signals production (needs 120 node headroom) | Simple conditional in KCL based on `nodeSize` |
| 2026-02-22 | Cilium: skip installation for UpCloud | UKS comes with Cilium pre-installed as built-in CNI | Add `upcloud` to Cilium skip list in `apps.k` |
| 2026-02-22 | Mandatory Network resource in composition | UKS requires an explicit SDN Private Network; cannot be implicit like other providers | `upcloud.k` must compose a `Network` resource before the cluster |
| 2026-02-22 | `minNodeCount` maps to static `nodeCount` | UKS CRD only exposes fixed `nodeCount`, not min/max autoscaling | No autoscaling via Crossplane; document limitation |
| 2026-02-22 | Default zone: `de-fra1` | Frankfurt is a well-connected European region | Hardcoded in `upcloud.k`; could be parameterized later |
| 2026-02-22 | Load balancing via Kubernetes-native mechanism | No Crossplane `LoadBalancer` CRD, but Ingress/Gateway API creates LB services that UKS handles natively | No impact on apps layer; Traefik/Gateway API work as expected |
| 2026-02-22 | Include GPU support from the start | UpCloud provider supports GPU node groups (`gpuPlan` block); NVIDIA GPU Operator and vLLM are cloud-agnostic via `apps.k` | Add GPU `KubernetesNodeGroup` in `upcloud.k` with same taint/label pattern as other providers |
| 2026-02-22 | API groups use `upcloud.com` not `upbound.io` | Discovered from CRD inspection: actual API groups are `uks.m.upcloud.com`, `network.m.upcloud.com`, `provider.m.upcloud.com` | Updated all references in compositions, tests, and provider config |
| 2026-02-22 | Provider image has broken platform annotations | `docker manifest inspect` shows empty `architecture`/`os` on all manifest entries; controller pod cannot start on any platform | Blocked on maintainer fix; composition tests still work via CRD extraction |
| 2026-02-22 | KubernetesCluster CRD requires `labels` field | CRD validation rejects clusters without `labels` even when empty | Added `labels = {}` to upcloud.k |
