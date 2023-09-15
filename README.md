## Publish To Upbound

```bash
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

## Test

```bash
# Create a Kubernetes cluster (a local cluster should do)

# TODO: Move to GitHub Actions

kubectl krew install kuttl

# TODO: Run from Okteto

kubectl kuttl test tests/

# Destroy or reset the Kubernetes cluster
```