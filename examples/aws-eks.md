# AWS EKS Example

## Setup

> Make sure that Docker is up-and-running. We'll use it to create a KinD cluster.

> Watch https://youtu.be/WiFLtcBvGMU if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

```sh
devbox shell

chmod +x examples/setup.nu

./examples/setup.nu
```

## Simple Cluster

```sh
kubectl --namespace a-team apply --filename examples/aws-eks.yaml

crossplane beta trace cluster.devopstoolkit.ai a-team --namespace a-team
```

## Package

```sh
cat package/compositions.yaml

cat kcl/aws.k

start "https://marketplace.upbound.io/configurations/devops-toolkit/dot-kubernetes"
```

> Open the URL from the output in a browser

```sh
crossplane beta trace cluster.devopstoolkit.ai a-team --namespace a-team
```

> Wait until all the resources are `Available`.

## Simple Cluster (cont.)

```sh
aws eks update-kubeconfig --region us-east-1 --name a-team \
    --kubeconfig kubeconfig.yaml

kubectl --kubeconfig kubeconfig.yaml get namespaces

chmod +x examples/get-traefik-eks.nu

let ingress_ip = ./examples/get-traefik-eks.nu
```

## Complete Cluster

```sh
cat examples/aws-eks-full.yaml

kubectl --namespace a-team apply --filename examples/aws-eks-full.yaml

crossplane beta trace cluster.devopstoolkit.ai a-team --namespace a-team

kubectl --kubeconfig kubeconfig.yaml get namespaces

start "http://argocd.$INGRESS_IP.nip.io"
```

> Use `admin` as the username and `admin123`

## GPU Cluster

Create a cluster with a GPU node pool for AI/ML workloads:

```sh
kubectl --namespace a-team apply --filename examples/aws-eks-gpu.yaml

crossplane beta trace cluster.devopstoolkit.ai a-team-gpu --namespace a-team
```

> Wait until all the resources are `Available`.

Verify the GPU NodeGroup configuration:

```sh
kubectl --namespace a-team get nodegroup.eks.aws.m.upbound.io \
    a-team-gpu-gpu -o jsonpath='{.spec.forProvider}' | jq .
```

> Confirm: `instanceTypes: ["g5.xlarge"]`, `labels: {gpu: "true"}`, `taint: [{effect: "NO_SCHEDULE", key: "nvidia.com/gpu", value: "true"}]`.

### Destroy GPU Cluster

```sh
kubectl --namespace a-team delete --filename examples/aws-eks-gpu.yaml
```

## Destroy

```sh
chmod +x examples/destroy.nu

./examples/destroy.nu
```
