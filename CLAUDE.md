# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Crossplane Configuration package for provisioning Kubernetes clusters across AWS (EKS), Azure (AKS), and Google Cloud (GKE) using declarative Composite Resources. Published to Upbound registry as `xpkg.upbound.io/devops-toolkit/dot-kubernetes`.

## Common Commands

Enter dev environment first: `devbox shell`

| Command | Description |
|---|---|
| `just package-generate` | Compile KCL files into YAML manifests in `package/` |
| `just package-apply` | Apply definition and compositions to the current cluster |
| `just package-generate-apply` | Generate + apply in one step |
| `just cluster-create` | Create KinD cluster, install Crossplane, providers, and functions |
| `just cluster-destroy` | Delete the KinD cluster |
| `just test` | Full cycle: create cluster, generate, apply, run tests, destroy |
| `just test-once` | Generate, apply, and run Chainsaw tests (cluster must exist) |
| `just test-watch` | Watch `kcl/` and `tests/` dirs, re-run tests on changes |

### Testing

Tests use **Kyverno Chainsaw** (`chainsaw test`). Test suites are per cloud provider in `tests/{aws,azure,google}/`. Configuration is in `.chainsaw.yaml` (5m global timeout, 2m assert timeout).

**Always redirect test/long-running command output to `./tmp/`** to avoid wasting tokens. Use `>` redirection (not `tee`). After the command finishes, read just the tail of the output file to check results. Only read the full file if tests failed.
- `just test > tmp/test-output.txt 2>&1`
- `just test-once > tmp/test-output.txt 2>&1`
- `chainsaw test > tmp/chainsaw-output.txt 2>&1`

### TDD Workflow

Always follow incremental TDD when implementing PRD milestones. Each feature slice gets its own RED/GREEN cycle: write one failing test, implement just enough to make it pass, then move to the next slice. Never batch all tests or all implementation together.

### Publishing

Requires `UP_ACCOUNT`, `UP_TOKEN`, and `VERSION` env vars. Run `just package-publish`.

## Architecture

### KCL Source → Generated YAML Pipeline

Source of truth is KCL code in `kcl/`. Running `just package-generate` produces:
- `kcl/crossplane.k` → `package/crossplane.yaml` (Configuration metadata + provider/function dependencies)
- `kcl/definition.k` → `package/definition.yaml` (CompositeResourceDefinition for `CompositeCluster`)
- `kcl/compositions.k` → `package/compositions.yaml` (one Composition per cloud provider)

**Never edit files in `package/` directly** — they are generated from KCL.

### Composition Pipeline (per provider)

Each Composition uses Crossplane Pipeline mode with three steps:
1. **Provider-specific KCL function** (`aws.k`, `azure.k`, or `google.k`) — creates cloud resources (VPCs, subnets, node groups, etc.)
2. **Apps KCL function** (`apps.k`) — optionally deploys applications (Crossplane, Argo CD, Dapr, Traefik, External Secrets, OpenFunction) via Helm releases
3. **Auto-ready function** — automatically detects resource readiness

### Key KCL Files

- `data.k` — Schema definitions for cluster parameters (nodeSize, version, minNodeCount, namespaces) and app configuration
- `definition.k` — XRD defining the namespace-scoped `Cluster` API (Crossplane v2)
- `compositions.k` — Composition template that reads provider-specific KCL files and injects them as inline KCLRun sources
- `aws.k` / `azure.k` / `google.k` — Provider-specific infrastructure resources
- `apps.k` — Application deployment logic (uses `CLUSTER_API_VERSION` and `CLUSTER_KIND` placeholders replaced at generation time)

### Crossplane Custom API

- **API Group**: `devopstoolkit.ai/v1alpha1`
- **Resource**: `Cluster` (namespace-scoped, Crossplane v2)
- **Provider selection**: `spec.compositionSelector.matchLabels.provider` (aws/azure/google)

### Providers and Functions

Provider manifests live in `providers/`. These are applied during `cluster-create` and include:
- Cloud providers: AWS (EKS, EC2, IAM), Azure, Google (Container)
- In-cluster providers: Helm, Kubernetes
- Functions: `function-kcl`, `function-auto-ready`
