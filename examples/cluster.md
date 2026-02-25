## Setup

```sh
devbox shell

./dot.nu setup-demo

source .env
```

## Clusters

```sh
cat examples/$PROVIDER-k8s.yaml

kubectl --namespace a-team apply --filename examples/$PROVIDER-k8s.yaml

crossplane beta trace --namespace a-team clusters.devopstoolkit.ai a-team

./dot.nu get kubeconfig $PROVIDER --name a-team --destination kubeconfig-remote.yaml --resource_group a-team

kubectl --kubeconfig kubeconfig-remote.yaml get crds
```
