# Azure AKS Example

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

az login

RESOURCE_GROUP=dot-$(date +%Y%m%d%H%M%S)

export LOCATION=eastus

az group create --name $RESOURCE_GROUP --location $LOCATION

export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner --scopes \ 
    subscriptions/$SUBSCRIPTION_ID | tee azure-creds.json

kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json

kubectl apply --filename providers/provider-config-azure.yaml

kubectl create namespace a-team
```

## Do

```sh
kubectl --namespace a-team apply \
    --filename examples/azure-aks.yaml

crossplane beta trace clusterclaim a-team --namespace a-team
```

## GPU Cluster

Create a cluster with a GPU node pool for AI/ML workloads:

```sh
kubectl --namespace a-team apply --filename examples/azure-aks-gpu.yaml

crossplane beta trace cluster.devopstoolkit.ai ateamgpu --namespace a-team
```

> Wait until all the resources are `Available`.

Verify the GPU NodePool configuration:

```sh
kubectl --namespace a-team get kubernetesclusternodepool.containerservice.azure.m.upbound.io \
    a-team-gpu-gpu -o jsonpath='{.spec.forProvider}' | jq .
```

> Confirm: `vmSize: "Standard_NC4as_T4_v3"`, `nodeLabels: {gpu: "true"}`, `nodeTaints: ["nvidia.com/gpu=true:NoSchedule"]`.

### Destroy GPU Cluster

```sh
kubectl --namespace a-team delete --filename examples/azure-aks-gpu.yaml
```

## Destroy

```sh
kubectl --namespace a-team delete \
    --filename examples/azure-aks.yaml

kubectl get managed | grep a-team
```

> Wait until all managed resources are removed

```sh
gcloud projects delete $PROJECT_ID --quiet
```