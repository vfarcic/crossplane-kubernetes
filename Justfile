timeout := "300s"

# List tasks.
default:
  just --list

# Generates package files.
package-generate:
  timoni build dot-kubernetes timoni > package/all.yaml
  head -n -1 package/all.yaml > package/all.yaml.tmp
  mv package/all.yaml.tmp package/all.yaml

# Applies Compositions and Composite Resource Definition.
package-apply:
  kubectl apply --filename package/definition.yaml && sleep 1
  kubectl apply --filename package/all.yaml

# Builds and pushes the package.
package-publish: package-generate
  up login --token $UP_TOKEN
  up xpkg build --package-root package --name kubernetes.xpkg
  up xpkg push --package package/kubernetes.xpkg xpkg.upbound.io/$UP_ACCOUNT/dot-kubernetes:$VERSION
  rm package/kubernetes.xpkg
  yq --inplace ".spec.package = \"xpkg.upbound.io/devops-toolkit/dot-kubernetes:$VERSION\"" config.yaml

# Combines `package-generate` and `package-apply`.
package-generate-apply: package-generate package-apply

# Runs tests once assuming that the cluster is already created and everything is installed.
test: package-generate package-apply
  chainsaw test

# Runs tests in the watch mode assuming that the cluster is already created and everything is installed.
test-watch: package-generate package-apply
  watchexec -w timoni -w tests "just package-generate-apply && chainsaw test"

# Creates a kind cluster, installs Crossplane, providers, and packages, waits until they are healthy, and runs tests.
cluster-create: package-generate _cluster-create-kind
  helm upgrade --install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace --wait
  for provider in `ls -1 providers | grep -v config`; do kubectl apply --filename providers/$provider; done
  just package-apply
  sleep 60
  kubectl wait --for=condition=healthy provider.pkg.crossplane.io --all --timeout={{timeout}}
  kubectl wait --for=condition=healthy function.pkg.crossplane.io --all --timeout={{timeout}}

# Destroys the cluster
cluster-destroy:
  kind delete cluster

# Creates a kind cluster
_cluster-create-kind:
  -kind create cluster

_helm-repo:
  helm repo add crossplane-stable https://charts.crossplane.io/stable
  helm repo update
