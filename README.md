## Genera manifests

```bash
timoni build dot-kubernetes timoni | tee package/all.yaml

# Remove the last line that contains `---`.
sed -i '' -e '$ d' package/all.yaml
```

## Run tests

```bash
kubectl krew install kuttl

kind create cluster

helm repo update

# The first time `kuttl` is run, it has to install a bunch of
#   packages and that might take more time than the default
#   timeout.
# Feel free to remote `--timeout` from all subsequent runs.
timoni build dot-kubernetes timoni | tee package/all.yaml && kubectl kuttl test --timeout 600

kind delete cluster
```

## Publish To Upbound

```bash
cd package

# Replace `[...]` with the Upbound Cloud account
export UP_ACCOUNT=[...]

# Replace `[...]` with the Upbound Cloud token
export UP_TOKEN=[...]

# Create `dot-kubernetes` repository

up login

# Replace `[...]` with the version of the package (e.g., `v0.5.0`)
export VERSION=[...]

up xpkg build --name k8s.xpkg

up xpkg push \
    --package k8s.xpkg \
    xpkg.upbound.io/$UP_ACCOUNT/dot-kubernetes:$VERSION
```
