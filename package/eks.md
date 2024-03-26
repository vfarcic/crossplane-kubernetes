# AWS EKS Example

## Setup

```bash
# Create a management Kubernetes cluster manually (e.g., minikube, Rancher Desktop, eksctl, etc.)

helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

kubectl --namespace crossplane-system \
    create secret generic aws-creds \
    --from-file creds=./aws-creds.conf

kubectl apply \
    --filename ../providers/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename ../providers/provider-helm-incluster.yaml

kubectl wait --for=condition=healthy provider.pkg.crossplane.io \
    --all

kubectl apply --filename ../config.yaml

sleep 5

kubectl wait --for=condition=healthy provider.pkg.crossplane.io \
    --all --timeout=300s

# Wait until all the packages are healthy

kubectl apply \
    --filename ../providers/provider-config-aws.yaml

kubectl create namespace infra
```

## Create an EKS Cluster

```bash
kubectl --namespace infra apply \
    --filename ../examples/aws-eks.yaml
    
kubectl --namespace infra get clusterclaims

kubectl get managed
```

## Destroy 

```bash
kubectl --namespace infra delete \
    --filename ../examples/aws-eks.yaml

kubectl get managed

# Wait until all the resources are deleted (ignore `object` and
#   `release` resources)
```