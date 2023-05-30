## Import CRDs

```bash
export CRD=[...] # e.g. providerconfigs.helm.crossplane.io

export OUTFILE=[...] # crds/helm.yaml

touch $OUTFILE.yaml

echo "---" | tee -a $OUTFILE

kubectl get crd $CRD -o yaml | tee -a $OUTFILE

cdk8s import $OUTFILE
```