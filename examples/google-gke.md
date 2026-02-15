# Google GKE Example

## Setup

> Make sure that Docker is up-and-running. We'll use it to create a KinD cluster.

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

```sh
devbox shell

kind create cluster

helm upgrade --install crossplane crossplane \
    --repo https://charts.crossplane.io/stable \
    --namespace crossplane-system --create-namespace --wait

kubectl apply --filename config.yaml

kubectl apply \
    --filename providers/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename providers/provider-helm-incluster.yaml

gum spin --spinner dot \
    --title "Waiting for Crossplane providers to be deployed..." \
    -- sleep 60

gum spin --spinner dot \
    --title "Waiting for Crossplane providers to be deployed..." \
    -- kubectl wait \
    --for=condition=healthy provider.pkg.crossplane.io --all \
    --timeout 5m

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

gcloud projects create $PROJECT_ID

open "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID"

# Enable the API

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

export ROLE=roles/admin

gcloud projects add-iam-policy-binding \
    --role $ROLE $PROJECT_ID --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $PROJECT_ID --iam-account $SA

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

yq --inplace ".spec.projectID = \"$PROJECT_ID\"" \
    providers/provider-config-google.yaml

kubectl apply --filename providers/provider-config-google.yaml

kubectl create namespace a-team
```

## Do

```sh
kubectl --namespace a-team apply \
    --filename examples/google-gke.yaml

crossplane beta trace cluster.devopstoolkit.ai a-team --namespace a-team
```

## GPU Cluster

Create a cluster with a GPU node pool for AI/ML workloads:

```sh
kubectl --namespace a-team apply --filename examples/google-gke-gpu.yaml

crossplane beta trace cluster.devopstoolkit.ai a-team-gpu --namespace a-team
```

> Wait until all the resources are `Available`.

Verify the GPU NodePool configuration:

```sh
kubectl --namespace a-team get nodepool.container.gcp.m.upbound.io \
    a-team-gpu-gpu -o jsonpath='{.spec.forProvider}' | jq .
```

> Confirm: `machineType: "n1-standard-4"`, `guestAccelerator: [{type: "nvidia-tesla-t4", count: 1}]`, `labels: {gpu: "true"}`, `taint: [{key: "nvidia.com/gpu", value: "true", effect: "NO_SCHEDULE"}]`.

### Destroy GPU Cluster

```sh
kubectl --namespace a-team delete --filename examples/google-gke-gpu.yaml
```

## Destroy

```sh
kubectl --namespace a-team delete \
    --filename examples/google-gke.yaml

kubectl get managed | grep a-team
```

> Wait until all managed resources are removed

```sh
gcloud projects delete $PROJECT_ID --quiet
```