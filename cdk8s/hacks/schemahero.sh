# cat dist/civo-all.k8s.yaml hacks/schemahero.yaml | tee dist/civo-all.k8s.yaml.tmp
cat dist/civo-all.k8s.yaml hacks/schemahero.yaml hacks/write-connection-secrets-to-namespace.yaml > dist/civo-all.k8s.yaml.tmp

mv dist/civo-all.k8s.yaml.tmp dist/civo-all.k8s.yaml
