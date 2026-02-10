# PRD: GPU/Inference-Capable Cluster Support

**Issue**: #264
**Priority**: High
**Status**: In Progress

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

- Users can create a ClusterClaim with `gpu.enabled: true` and get a working GPU node pool
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
- `kcl/backstage-template.k` — expose GPU + NVIDIA params in Backstage UI
- `tests/` — new test steps and assertions per provider + common nvidia assertion
- `examples/` — example ClusterClaim with GPU enabled

## Milestones

- [x] Existing test suite passes (baseline verified, pre-existing issues fixed)
- [ ] Chainsaw tests written for GPU node pools and NVIDIA operator (RED — tests fail)
- [ ] KCL schemas, XRD definition, and compositions implemented (GREEN — tests pass)
- [ ] GPU node pools created correctly for all three providers (AWS, Azure, Google)
- [ ] NVIDIA GPU Operator deployed as optional Helm release
- [ ] Backstage template updated with GPU and NVIDIA parameters
- [ ] Example ClusterClaim with GPU configuration added

## Risks

- **GPU instance availability**: GPU instances may not be available in all regions; we hardcode `us-east-1` / `us-east1` / `eastus` matching existing provider defaults
- **vLLM Helm chart values**: Not applicable — no inference framework in this PRD
- **Azure GPU node pool API**: `KubernetesClusterNodePool` resource field names need verification against Upbound provider CRDs
- **GKE guest accelerator syntax**: The `guestAccelerator` field format may vary by Upbound provider version
