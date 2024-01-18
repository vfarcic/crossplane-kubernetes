# Google Cloud GKE Example

## Setup

```bash
# Install `crossplane` CLI by following the instructions at
#   https://docs.crossplane.io/latest/cli/#installing-the-cli

# Create a management Kubernetes cluster manually
#   (e.g., minikube, Rancher Desktop, eksctl, etc.).

export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

gcloud projects create $PROJECT_ID

echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$PROJECT_ID"

# Open the URL and *ENABLE* the API

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

export ROLE=roles/admin

gcloud projects add-iam-policy-binding --role $ROLE $PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $PROJECT_ID --iam-account $SA

helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json

kubectl apply \
    --filename ../providers/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename ../providers/provider-helm-incluster.yaml

kubectl apply --filename ../providers/google.yaml

kubectl apply --filename ../config.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" \
    | kubectl apply --filename -
```

## Create a GKE Cluster

```bash
kubectl create namespace infra

kubectl --namespace infra apply \
    --filename ../examples/gcp-gke.yaml

crossplane beta trace clusterclaim a-team-gke --namespace infra

# Wait until all the resources are `READY`

export KUBECONFIG=$PWD/kubeconfig.yaml

gcloud container clusters get-credentials a-team-gke \
    --region us-east1 --project $PROJECT_ID

kubectl get nodes
```

## Destroy 

```bash
unset KUBECONFIG

kubectl --namespace infra delete \
    --filename ../examples/gcp-gke.yaml

kubectl get managed

# Wait until all the resources are deleted (ignore `object`).

gcloud projects delete $PROJECT_ID --quiet
```