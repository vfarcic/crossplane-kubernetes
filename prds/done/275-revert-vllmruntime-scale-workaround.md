# PRD: Revert VLLMRuntime CRD Scale Subresource Workaround

**Status**: Blocked (waiting on upstream)
**Priority**: Low
**Created**: 2026-02-28
**GitHub Issue**: #275

## Problem Statement

The VLLMRuntime CRD deployed by dot-kubernetes includes a custom `/scale` subresource and `status.replicas` field that are **not part of the upstream vLLM Production Stack operator CRD**. This is a temporary workaround to enable KEDA autoscaling — without it, KEDA and the vLLM operator fight over Deployment replicas.

## Trigger Condition

Monitor [vllm-project/production-stack#300](https://github.com/vllm-project/production-stack/issues/300). When the upstream operator adds native HPA support, this workaround should be removed.

## What to Revert

### In `kcl/apps.k` (VLLMRuntime CRD definition)

1. Remove the `scale` subresource — revert `subresources` back to `subresources.status = {}`
2. Remove `properties.status` (the `status.replicas` field) from `openAPIV3Schema`
3. Remove the `TODO` comments

The affected code has `TODO: Remove scale subresource` comments marking exactly what to change.

### In `tests/common/assert-vllm.yaml`

1. Remove the `scale` assertion from `subresources`
2. Remove the `status.properties.replicas` assertion

### Generate and test

1. Run `just package-generate` to regenerate compositions
2. Run `just test-once` to verify all tests pass

## Dependencies

- **Upstream**: [vllm-project/production-stack#300](https://github.com/vllm-project/production-stack/issues/300) — "Autoscale CRD & controller"
- **Downstream**: crossplane-inference — uses the scale subresource for KEDA autoscaling; must coordinate removal

## References

- Workaround added: 2026-02-28 (crossplane-inference feature request)
- `kcl/apps.k` — search for `TODO: Remove scale subresource`
