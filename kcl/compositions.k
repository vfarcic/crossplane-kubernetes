import file

schema composition:
    _cluster: str
    _provider: str
    _source: str
    apiVersion = "apiextensions.crossplane.io/v1"
    kind = "Composition"
    metadata = {
        labels = {
            cluster = _cluster
            provider = _provider
        }
        name = "cluster-" + _provider
    }
    spec = {
        compositeTypeRef = {
            apiVersion = "devopstoolkitseries.com/v1alpha1"
            kind = "CompositeCluster"
        }
        mode = "Pipeline"
        pipeline = [
            {
                step = _provider
                functionRef.name = "crossplane-contrib-function-kcl"
                input = {
                    apiVersion = "krm.kcl.dev/v1alpha1"
                    kind = "KCLRun"
                    spec.source = _source
                }
            }, {
                step = "apps"
                functionRef.name = "crossplane-contrib-function-kcl"
                input = {
                    apiVersion = "krm.kcl.dev/v1alpha1"
                    kind = "KCLRun"
                    spec.source = file.read("kcl/apps.k")
                }
            }, {
                step = "automatically-detect-ready-composed-resources"
                functionRef.name = "crossplane-contrib-function-auto-ready"
            }
        ]
        writeConnectionSecretsToNamespace = "crossplane-system"
    }
        
[
    composition {
        _cluster = "gke"
        _provider = "google"
        _source = file.read("kcl/google.k")
    }

    composition {
        _cluster = "aks"
        _provider = "azure"
        _source = file.read("kcl/azure.k")
    }

    composition {
        _cluster = "eks"
        _provider = "aws"
        _source = file.read("kcl/aws.k")
    }

]