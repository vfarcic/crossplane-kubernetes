# Civo Example

## Setup

```bash
# The commands assume that you are inside the `package` directory

# Create a management Kubernetes cluster manually (e.g., minikube, Rancher Desktop, eksctl, etc.)

helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

# Replace `[...]` with your Civo token
export CIVO_TOKEN=[...]

export CIVO_TOKEN_ENCODED=$(echo $CIVO_TOKEN | base64)

echo "apiVersion: v1
kind: Secret
metadata:
  namespace: crossplane-system
  name: civo-creds
type: Opaque
data:
  credentials: $CIVO_TOKEN_ENCODED" \
    | kubectl apply --filename -

kubectl apply \
  --filename ../providers/provider-helm-incluster.yaml

kubectl apply \
  --filename ../providers/provider-kubernetes-incluster.yaml

kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout=300s

kubectl apply --filename ../providers/civo.yaml

kubectl apply --filename ../config.yaml

kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout=300s

kubectl apply --filename ../providers/civo-config.yaml

kubectl create namespace a-team
```

## Create a cluster

```bash
kubectl --namespace a-team apply \
  --filename ../examples/civo-ck-all.yaml

kubectl get managed

kubectl --namespace a-team get clusterclaims

# Wait until the cluster is ready
```

## Use the cluster

```bash
kubectl --namespace crossplane-system \
    get secret cluster-civo-a-team-ck \
    --output jsonpath="{.data.kubeconfig}" \
    | base64 -d \
    | tee kubeconfig.yaml

# The credentials in `kubeconfig.yaml` are temporary for security reasons

kubectl --kubeconfig kubeconfig.yaml \
    get nodes
```

## Destroy 

```bash
kubectl --namespace a-team \
    delete clusterclaim a-team-ck

kubectl get managed

# Wait until all managed AWS resources are removed
```