# Impurt CRDs

```bash
kubectl get crd compositions.apiextensions.crossplane.io --output yaml | tee crds/compositions.yaml

timoni mod vendor crd --file crds/compositions.yaml
```

# Build

```bash
timoni build dot-kubernetes . | tee ../package/all.yaml
```
