# PRD: Add UpCloud (UKS) as a Fourth Cloud Provider

**Issue**: #270
**Priority**: Medium
**Status**: Pending

## Problem

The project currently supports only three cloud providers (AWS/EKS, Azure/AKS, Google/GKE). Users who want to provision Kubernetes clusters on UpCloud's managed Kubernetes service (UKS) cannot do so. UpCloud is a European cloud provider popular for its simplicity and performance, and an official Crossplane provider (`upcloud/provider-upcloud`) already exists on the Upbound Marketplace.

## Solution

Add UpCloud as a fourth cloud provider following existing patterns:

1. **`kcl/upcloud.k`** — provider-specific KCL file creating UKS resources (`KubernetesCluster`, `KubernetesNodeGroup`) via the `uks.upcloud.m.upbound.io/v1alpha1` API
2. **`providers/upcloud.yaml`** — provider package dependency for `upcloud/provider-upcloud`
3. **Composition `cluster-upcloud`** — new entry in `kcl/compositions.k` with `provider=upcloud, cluster=uks` labels
4. **Network resources** — UpCloud network/router via `network.upcloud.m.upbound.io/v1alpha1` if required by UKS
5. **Tests** — full Chainsaw test suite in `tests/upcloud/`

Users will select UpCloud via `spec.crossplane.compositionSelector.matchLabels.provider: upcloud`.

## UpCloud Resource Mapping

The official `upcloud/provider-upcloud` (v0.1.1) provides these managed resources:

| Resource | API Group (namespace-scoped) | Version |
|----------|------------------------------|---------|
| KubernetesCluster | `uks.upcloud.m.upbound.io` | `v1alpha1` |
| KubernetesNodeGroup | `uks.upcloud.m.upbound.io` | `v1alpha1` |
| Network | `network.upcloud.m.upbound.io` | `v1alpha1` |
| Router | `network.upcloud.m.upbound.io` | `v1alpha1` |

## Node Size Mapping

| Size | UpCloud Plan (TBD) |
|------|-------------------|
| small | TBD — to be determined during implementation based on available UKS node plans |
| medium | TBD |
| large | TBD |

## Design Decisions

- **Follow existing provider patterns** — same composition pipeline (provider KCL → apps KCL → auto-ready), same test structure, same parameter schema
- **No GPU support initially** — the UpCloud provider is v0.1.1 (alpha); GPU node pools can be added later if/when UpCloud supports GPU instances via UKS
- **No Cilium initially** — determine whether UKS requires a CNI plugin or uses a native one; add Cilium integration only if needed
- **External Secrets** — defer UpCloud-specific secret store integration; UpCloud may not have a secrets manager equivalent
- **Provider version caveat** — `upcloud/provider-upcloud` is v0.1.1 (alpha, not recommended for production per upstream docs); document this limitation clearly

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
- [ ] Add `upcloud/provider-upcloud` to `kcl/crossplane.k` dependencies
- [ ] Create `providers/upcloud.yaml` with provider package
- [ ] Create `providers/provider-config-upcloud.yaml` for UpCloud auth
- [ ] Add `cluster-upcloud` composition entry in `kcl/compositions.k`
- [ ] Verify `just package-generate` produces valid output with the new composition

### 2. UKS Cluster & Node Group (kcl/upcloud.k)
- [ ] RED: Chainsaw test asserts UKS KubernetesCluster and KubernetesNodeGroup resources are created
- [ ] GREEN: Implement `kcl/upcloud.k` with KubernetesCluster, KubernetesNodeGroup, and any required networking resources
- [ ] Map `nodeSize` (small/medium/large) to appropriate UpCloud node plans
- [ ] Configure kubeconfig secret output for downstream providers

### 3. Application Layer Integration
- [ ] Add UpCloud cluster API version/kind to `apps.k` placeholder replacement
- [ ] Ensure Helm and Kubernetes ProviderConfigs work with UKS kubeconfig
- [ ] Verify Usage resources reference correct UpCloud cluster API

### 4. Chainsaw Test Suite
- [ ] Create `tests/upcloud/chainsaw-test.yaml` with bindings (hyperscaler=upcloud, cluster=uks, clusterApi/clusterKind)
- [ ] Create install, assert, update, and app test steps following existing provider patterns
- [ ] Reuse common assertions from `tests/common/`
- [ ] All UpCloud-specific tests pass

### 5. Examples & Documentation
- [ ] Add example Cluster manifest for UpCloud
- [ ] Update any existing examples that list available providers

### 6. Manual Validation
- [ ] Create a real UKS cluster via the Crossplane composition
- [ ] Verify node pool scaling and kubeconfig connectivity
- [ ] Deploy a sample app via the apps layer (Helm release)
- [ ] Destroy cluster and verify cleanup

## Risks

- **Alpha provider** — `upcloud/provider-upcloud` is v0.1.1; API surface may change, and some resources may have bugs or missing fields
- **Limited resource coverage** — the provider does not yet support load balancers, network gateways, or floating IPs; this may limit networking options
- **UKS node plan mapping** — UpCloud's compute plans differ from AWS/Azure/GCP instance types; determining appropriate small/medium/large mappings requires investigation
- **CNI requirements** — unclear whether UKS requires an external CNI (like Cilium) or uses a built-in one; needs investigation during implementation
- **No `.m` API group confirmation** — need to verify the namespace-scoped `.m` API groups exist in the provider (required for Crossplane v2 compatibility)
- **Regional availability** — UKS may not be available in all UpCloud regions; need to select a reliable default region

## Decision Log

| Date | Decision | Rationale | Impact |
|------|----------|-----------|--------|
| | | | |
