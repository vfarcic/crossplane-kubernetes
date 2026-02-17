# PRD: Optional vLLM Support for Inference-Ready GPU Clusters

**Issue**: #266
**Priority**: Medium
**Status**: Complete

## Problem

GPU-enabled clusters provisioned by this Configuration have the infrastructure (GPU node pools, NVIDIA GPU Operator) but no inference serving layer. Users who want to run LLM inference must manually install and configure vLLM or a similar framework before they can serve models. This adds friction and delays time-to-first-inference.

## Solution

Add an optional `spec.parameters.apps.vllm.enabled` toggle that deploys the [vLLM Production Stack](https://github.com/vllm-project/production-stack) Helm chart (`vllm-stack`), making the cluster immediately ready for users to deploy inference workloads. The vLLM stack provides:

- Prefix-aware request routing and KV-cache sharing for optimized inference
- Built-in support for autoscaling, fault tolerance, and observability
- Multi-GPU and tensor parallelism support

**Scope boundary**: This Configuration installs only the vLLM infrastructure/operator. Actual model deployment (which models to serve, resource allocation, HuggingFace tokens, etc.) is the user's responsibility and happens outside this Configuration.

## Design Decisions

- **vLLM as an app** (under `spec.parameters.apps.vllm`), not a top-level parameter — it is a software deployment, not infrastructure
- **Uses vLLM Production Stack** (`vllm-stack` chart from `https://vllm-project.github.io/production-stack`) — the official Kubernetes-native reference deployment from the vLLM project
- **Minimal default values** — deploy the stack infrastructure only; no model is pre-configured since model selection is user-specific
- **Depends on GPU + NVIDIA** — vLLM requires GPU nodes with the NVIDIA device plugin; this is documented but not enforced at the schema level (consistent with how `apps.nvidia` doesn't enforce `gpu.enabled`)

## Success Criteria

- Users can enable vLLM via `spec.parameters.apps.vllm.enabled: true`
- The vLLM Production Stack Helm release is created in the target cluster
- All existing tests continue to pass (no regressions)
- New Chainsaw tests validate vLLM Helm release is created correctly
- Examples are updated to show vLLM alongside GPU + NVIDIA configuration

## Files Affected

- `kcl/data.k` — new `appVllm` schema
- `kcl/definition.k` — wire `vllm` into XRD apps section
- `kcl/apps.k` — vLLM Production Stack Helm release (conditional)
- `tests/` — new test steps and common assertion for vLLM
- `examples/` — update GPU examples to show vLLM option

## Milestones

### 1. vLLM Schema & XRD
- [x] RED: Chainsaw test asserts `vllm` fields exist in XRD apps section
- [x] GREEN: Add `appVllm` schema to `data.k`, wire into `definition.k`

### 2. vLLM Helm Release
- [x] RED: Chainsaw test asserts vLLM Helm release is created when enabled
- [x] GREEN: Implement conditional vLLM Production Stack Helm release in `apps.k`

### 3. Tests Across Providers
- [x] Add vLLM test steps to AWS, Azure, and Google test suites
- [x] Verify all existing tests still pass (no regressions)

### 4. Examples & Documentation
- [x] Update GPU example files to include `vllm.enabled: true` option
- [x] Verify examples are valid against the updated XRD

## Risks

- **vLLM Helm chart stability**: The `vllm-stack` chart (currently v0.1.x) is relatively new; chart values may change across versions
- **Resource requirements**: vLLM stack components need GPU-capable nodes; without GPU + NVIDIA enabled, the deployment will be non-functional (documented, not enforced)
- **Chart version pinning**: Need to pick a stable version and add to Renovate for automated updates
