## GKE Cluster with llm-d Inference Stack

### What `llmd.enabled` auto-installs

Enabling `apps.llmd` automatically provisions all cluster-level infrastructure needed for LLM inference:

- **Workload Variant Autoscaler (WVA)** — SLO-aware autoscaling for inference workloads
- **Envoy Gateway + AI Gateway** — Gateway API implementation with GAIE support (InferencePool, InferenceObjective CRDs)
- **Prometheus (kube-prometheus-stack)** — Monitoring and metrics
- **Valkey** — Redis-compatible key-value store for KV Cache Indexer
- **LeaderWorkerSet (LWS)** — Multi-pod workload controller for distributed inference
- **OpenTelemetry Collector** — Distributed tracing

### Setup control plane cluster

```sh
export KUBECONFIG=$PWD/kubeconfig.yaml

kind create cluster

helm upgrade --install crossplane crossplane \
    --repo https://charts.crossplane.io/stable \
    --namespace crossplane-system --create-namespace --wait
```

### Install the configuration and providers

```sh
kubectl apply --filename providers/provider-helm-incluster.yaml

kubectl apply --filename providers/provider-kubernetes-incluster.yaml

kubectl apply --filename config.yaml

sleep 60

kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout 5m
```

### Configure GCP credentials

Create a GCP service account with permissions to manage GKE clusters (at minimum `roles/container.admin`) and export its key as JSON. See [Creating and managing service account keys](https://cloud.google.com/iam/docs/keys-create-delete) for instructions.

```sh
kubectl --namespace crossplane-system create secret generic gcp-creds \
    --from-file creds=gcp-creds.json

kubectl apply --filename providers/provider-config-google.yaml
```

### Create a namespace and deploy the cluster

```sh
kubectl create namespace a-team

cat examples/google-gke-llmd.yaml

kubectl --namespace a-team apply --filename examples/google-gke-llmd.yaml

crossplane beta trace --namespace a-team clusters.devopstoolkit.ai a-team-gke
```

### Per-model resources

This cluster provides the infrastructure layer. Per-model components (llm-d ModelService, Endpoint Picker/EPP, InferencePool, HTTPRoute) are deployed separately via [crossplane-inference](https://github.com/vfarcic/crossplane-inference).
