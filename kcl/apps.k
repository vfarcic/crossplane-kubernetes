vllmStack = "0.1.9"
crossplane = "2.1.4"
argocd = "9.4.1"
dapr = "1.16.8"
traefik = "39.0.0"
externalSecrets = "2.0.0"
cilium = "1.19.0"
nvidiaGpuOperator = "v25.10.1"
openFunctionUrl = "https://openfunction.github.io/charts/openfunction-v1.2.0-v0.7.0.tgz"

oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda suffix: str -> any {
    {
        name = oxr.metadata.name
        annotations = {
            "crossplane.io/external-name" = oxr.metadata.name
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-" + suffix
        }
    }
}

schema usage:
    _nameSuffix: str
    _kind: str = "Object"
    apiVersion = "protection.crossplane.io/v1beta1"
    kind = "Usage"
    metadata = {
        name = oxr.metadata.name + "-" + _nameSuffix + "-usage"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "crossplane.io/external-name" = oxr.metadata.name + "-" + _nameSuffix + "-usage"
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-" + _nameSuffix + "-usage"
        }
    }
    spec = {
        of = {
            apiVersion = "CLUSTER_API_VERSION"
            kind = "CLUSTER_KIND"
            resourceRef.name = oxr.metadata.name
        }
        by = {
            if _kind == "Object":
                apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
            elif _kind == "Release":
                apiVersion = "helm.m.crossplane.io/v1beta1"
            kind = _kind
            resourceRef.name = oxr.metadata.name + "-" + _nameSuffix
        }
    }

schema chart:
    _name: str
    _chartName?: str
    _chartRepository?: str
    _chartVersion?: str
    _chartUrl?: str
    _namespace: str
    _values?: any
    _providerConfigRefName?: str
    apiVersion = "helm.m.crossplane.io/v1beta1"
    kind = "Release"
    metadata = {
        name = oxr.metadata.name + "-app-" + _name
        annotations = {
            "crossplane.io/external-name" = _name
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-app-" + _name
        }
    }
    spec = {
        forProvider = {
            chart = {
                if _chartName:
                    name = _chartName
                else:
                    name = _name
                if _chartRepository:
                    repository = _chartRepository
                if _chartVersion:
                    version = _chartVersion
                if _chartUrl:
                    url = _chartUrl
            }
            if _values:
                values = _values
            namespace = _namespace
        }
        managementPolicies = ["Create", "Update", "Observe"]
        rollbackLimit = 3
        if _providerConfigRefName:
            providerConfigRef = {name = _providerConfigRefName, kind = "ProviderConfig"}
        else:
            providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
    }

schema object:
    _name: str
    _externalName?: str
    _manifest: any
    _references?: []
    apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
    kind = "Object"
    metadata = {
        name = oxr.metadata.name + "-app-" + _name
        annotations = {
            if _externalName:
                "crossplane.io/external-name" = _externalName
            else:
                "crossplane.io/external-name" = _name
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-app-" + _name
        }
    }
    spec = {
        if _references:
            references = _references
        forProvider.manifest = _manifest
        providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
    }

_items = [

    {
        apiVersion = "helm.m.crossplane.io/v1beta1"
        kind = "ProviderConfig"
        metadata = {
            name = oxr.metadata.name
            annotations = {
                "krm.kcl.dev/ready": "True"
                "crossplane.io/external-name" = oxr.metadata.name
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-config-helm"
            }
        }
        spec = {
            credentials = {
                secretRef = {
                    namespace = oxr.metadata.namespace
                    key = "kubeconfig"
                    name = oxr.metadata.name + "-cluster"
                }
                source = "Secret"
            }
            if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "google":
                identity = {
                    type = "GoogleApplicationCredentials"
                    source = "Secret"
                    secretRef = {
                        name = "gcp-creds"
                        namespace = "crossplane-system"
                        key = "creds"
                    }
                }
        }
    }

    {
        apiVersion = "helm.m.crossplane.io/v1beta1"
        kind = "ProviderConfig"
        metadata = {
            name = oxr.metadata.name + "-local"
            annotations = {
                "krm.kcl.dev/ready": "True"
                "crossplane.io/external-name" = oxr.metadata.name
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-config-helm-local"
            }
        }
        spec.credentials.source = "InjectedIdentity"
    }

    if oxr.spec.crossplane.compositionSelector.matchLabels.provider != "aws":
        {
            apiVersion = "helm.m.crossplane.io/v1beta1"
            kind = "Release"
            metadata = {
                name = oxr.metadata.name + "-cilium"
                annotations = {
                    "crossplane.io/external-name" = "cilium"
                    "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-app-cilium"
                }
            }
            spec = {
                forProvider = {
                    chart = {
                        name = "cilium"
                        repository = "https://helm.cilium.io"
                        version = cilium
                    }
                    set = [
                        if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "google":
                            {name = "nodeinit.enabled", value = "true"}
                            {name = "nodeinit.reconfigureKubelet", value = "true"}
                            {name = "nodeinit.removeCbrBridge", value = "true"}
                            {name = "cni.binPath", value = "/home/kubernetes/bin"}
                            {name = "gke.enabled", value = "true"}
                            {name = "ipam.mode", value = "kubernetes"}
                            {
                                name = "ipv4NativeRoutingCIDR"
                                if oxr.metadata.name + "-nodepool" in ocds:
                                    value = oxr.status.field1
                            },
                            {name = "authentication.enabled", value = "true"}
                            {name = "authentication.mutual.spire.enabled", value = "true"}
                            {name = "authentication.mutual.spire.install.enabled", value = "true"}
                        if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "azure":
                            {name = "aksbyocni.enabled", value = "true"}
                            {name = "nodeinit.enabled", value = "true"}
                            {name = "authentication.enabled", value = "true"}
                            {name = "authentication.mutual.spire.enabled", value = "true"}
                            {name = "authentication.mutual.spire.install.enabled", value = "true"}
                    ]
                    namespace = "kube-system"
                }
                rollbackLimit = 3
                providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
            }
        }
        usage { _nameSuffix = "cilium", _kind = "Release" }

    {
        apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
        kind = "ProviderConfig"
        metadata = {
            name = oxr.metadata.name
            annotations = {
                "krm.kcl.dev/ready": "True"
                "crossplane.io/external-name" = oxr.metadata.name
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-config-kubernetes"
            }
        }
        spec = {
            credentials = {
                secretRef = {
                    key = "kubeconfig"
                    name = oxr.metadata.name + "-cluster"
                    namespace = oxr.metadata.namespace
                }
                source: "Secret"
            }
            if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "google":
                identity = {
                    type = "GoogleApplicationCredentials"
                    source = "Secret"
                    secretRef = {
                        name = "gcp-creds"
                        namespace = "crossplane-system"
                        key = "creds"
                    }
                }
        }
    }

    if oxr.spec.parameters?.apps?.crossplane?.enabled:
        chart {
            _name = "crossplane"
            _chartRepository = "https://charts.crossplane.io/stable"
            _chartVersion = crossplane
            _namespace = "crossplane-system"
        }
        usage { _nameSuffix = "crossplane", _kind = "Release" }

    if oxr.spec.parameters?.apps?.argocd?.enabled:
        chart {
            _name = "argo-cd"
            _chartRepository = "https://argoproj.github.io/argo-helm"
            _chartVersion = argocd
            _namespace = "argocd"
            _values = {
                global.domain = oxr.spec.parameters.apps.argocd.host
                configs = {
                    secret = {
                        argocdServerAdminPassword = "$2a$10$m3eTlEdRen0nS86c5Zph5u/bDFQMcWZYdG3NVdiyaACCqoxLJaz16"
                        argocdServerAdminPasswordMtime = "2021-11-08T15:04:05Z"
                    }
                    cm = {
                        "application.resourceTrackingMethod" = "annotation"
                        "timeout.reconciliation" = "60s"
                    }
                    params = {
                        "server.insecure" = True
                    }
                }
                server = {
                    if oxr.spec.parameters?.apps?.traefik?.enabled:
                        ingress = {
                            enabled = True
                            ingressClassName = "traefik"
                        }
                    extraArgs = ["--insecure"]
                }
            }
        }
        object {
            _name = "argo-cd-app"
            _manifest = {
                apiVersion = "argoproj.io/v1alpha1"
                kind = "Application"
                metadata = {
                    name = "apps"
                    namespace = "argocd"
                    finalizers = ["resources-finalizer.argocd.argoproj.io"]
                }
                spec = {
                    project = "default"
                    source = {
                        repoURL = oxr.spec.parameters.apps.argocd.repoURL
                        targetRevision = "HEAD"
                        path = oxr.spec.parameters.apps.argocd.sourcePath
                    }
                    destination = {
                        server = "https://kubernetes.default.svc"
                        namespace = oxr.spec.parameters.apps.argocd.destinationNamespace
                    }
                    syncPolicy.automated = {
                        selfHeal = True
                        prune = True
                        allowEmpty = True
                    }
                }
            }
        }
        usage { _nameSuffix = "argo-cd", _kind = "Release" }
        usage { _nameSuffix = "argo-cd-app" }

    if oxr.spec.parameters?.apps?.openfunction?.enabled:
        chart {
            _name = "openfunction"
            _chartUrl = openFunctionUrl
            _namespace = "openfunction"
            _values = {
                revisionController.enable = True
            }
        }
        usage { _nameSuffix = "openfunction", _kind = "Release" }

    if oxr.spec.parameters?.apps?.dapr?.enabled:
        chart {
            _name = "dapr"
            _chartRepository = "https://dapr.github.io/helm-charts/"
            _chartVersion = dapr
            _namespace = "dapr-system"
        }
        usage { _nameSuffix = "dapr", _kind = "Release" }

    if oxr.spec.parameters?.apps?.traefik?.enabled:
        chart {
            _name = "traefik"
            _chartRepository = "https://helm.traefik.io/traefik"
            _chartVersion = traefik
            _namespace = "traefik"
        }
        usage { _nameSuffix = "traefik", _kind = "Release" }

    if oxr.spec.parameters?.apps?.externalSecrets?.enabled:
        chart {
            _name = "external-secrets"
            _chartRepository = "https://charts.external-secrets.io"
            _chartVersion = externalSecrets
            _namespace = "external-secrets"
            _values = {
                installCRDs = True
            }
        }
        usage { _nameSuffix = "external-secrets", _kind = "Release" }

    if oxr.spec.parameters?.apps?.nvidia?.enabled:
        chart {
            _name = "gpu-operator"
            _chartRepository = "https://helm.ngc.nvidia.com/nvidia"
            _chartVersion = nvidiaGpuOperator
            _namespace = "gpu-operator"
            _values = {
                driver.enabled = False
            }
        }
        usage { _nameSuffix = "gpu-operator", _kind = "Release" }

    if oxr.spec.parameters?.apps?.vllm?.enabled:
        chart {
            _name = "vllm-stack"
            _chartRepository = "https://vllm-project.github.io/production-stack"
            _chartVersion = vllmStack
            _namespace = "vllm"
            _values = {
                servingEngineSpec.enableEngine = False
            }
        }
        usage { _nameSuffix = "vllm-stack", _kind = "Release" }

    if oxr.spec.parameters?.apps?.externalSecrets?.enabled and oxr.spec.parameters.apps?.externalSecrets?.store:
        object {
            _name = "secret-store"
            _externalName = oxr.spec.crossplane.compositionSelector.matchLabels.provider
            _manifest = {
                apiVersion = "external-secrets.io/v1beta1"
                kind = "ClusterSecretStore"
                metadata.name = oxr.spec.crossplane.compositionSelector.matchLabels.provider
                if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "google":
                    spec.provider.gcpsm.auth.secretRef.secretAccessKeySecretRef = {
                        name: "gcp-creds"
                        key: oxr.spec.parameters.apps.externalSecrets.googleCredentialsKey
                        namespace: oxr.spec.parameters.creds.namespace
                    }
                elif oxr.spec.crossplane.compositionSelector.matchLabels.provider == "azure":
                    spec.provider.azurekv = {
                        authType = "ManagedIdentity"
                        vaultUrl = oxr.spec.parameters.apps.externalSecrets.azureVaultUrl
                    }
                elif oxr.spec.crossplane.compositionSelector.matchLabels.provider == "aws":
                    spec.provider.aws = {
                        service = "SecretsManager"
                        region = "us-east-1"
                        auth.secretRef = {
                            accessKeyIDSecretRef = {
                                name = oxr.spec.parameters.creds.name
                                key = oxr.spec.parameters.apps.externalSecrets.awsAccessKeyIDKey
                                namespace = oxr.spec.parameters.creds.namespace
                            }
                            secretAccessKeySecretRef = {
                                name = oxr.spec.parameters.creds.name
                                key = oxr.spec.parameters.apps.externalSecrets.awsSecretAccessKeyKey
                                namespace = oxr.spec.parameters.creds.namespace
                            }
                        }
                    }
            }
            if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "google":
                _references = [{
                    patchesFrom = {
                        apiVersion = "gcp.m.upbound.io/v1beta1"
                        kind = "ProviderConfig"
                        name = "default"
                        fieldPath = "spec.projectID"
                    }
                    toFieldPath = "spec.provider.gcpsm.projectID"
                }]
        }
        usage { _nameSuffix = "secret-store" }

]

if oxr.spec.parameters?.apps?.externalSecrets?.secrets:
    _items += [{
        apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
        kind = "Object"
        metadata = {
            name = oxr.metadata.name + "-secret-" + _secret.toSecret
            annotations = {
                "crossplane.io/external-name" = _secret.toSecret
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-secret-" + _secret.toSecret
            }
        }
        spec = {
            forProvider.manifest = {
                apiVersion = "external-secrets.io/v1beta1"
                kind = "ExternalSecret"
                metadata = {
                    name: _secret.toSecret
                    namespace: _secret.toNamespace
                }
                spec = {
                    refreshInterval = "1h"
                    secretStoreRef = {
                        kind: "ClusterSecretStore"
                        name: oxr.spec.crossplane.compositionSelector.matchLabels.provider
                    }
                    target = {
                        name = _secret.toSecret
                        creationPolicy = "Owner"
                        template.type = _secret.type
                    }
                    dataFrom = [{ extract.key = _secret.fromSecret }]
                }
            }
            providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
        }
    } for _secret in oxr.spec.parameters.apps.externalSecrets.secrets ]
    _items += [{
        apiVersion = "protection.crossplane.io/v1beta1"
        kind = "Usage"
        metadata = {
            name = oxr.metadata.name + "-secret-" + _secret.toSecret + "-usage"
            annotations = {
                "krm.kcl.dev/ready": "True"
                "crossplane.io/external-name" = oxr.metadata.name + "-secret-" + _secret.toSecret + "-usage"
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-secret-" + _secret.toSecret + "-usage"
            }
        }
        spec = {
            of = {
                apiVersion = "CLUSTER_API_VERSION"
                kind = "CLUSTER_KIND"
                resourceRef.name = oxr.metadata.name
            }
            by = {
                apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
                kind = "Object"
                resourceRef.name = oxr.metadata.name + "-secret-" + _secret.toSecret
            }
        }
    } for _secret in oxr.spec.parameters.apps.externalSecrets.secrets ]

if oxr.spec.parameters?.namespaces:
    _items += [{
        apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
        kind = "Object"
        metadata = {
            name = oxr.metadata.name + "-ns-" + _namespace
            annotations = {
                "crossplane.io/external-name" = _namespace
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-ns-" + _namespace
            }
        }
        spec = {
            forProvider.manifest = {
                apiVersion = "v1"
                kind = "Namespace"
                metadata.name = _namespace
            }
            managementPolicies = ["Create", "Update", "Observe"]
            providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
        }
    } for _namespace in oxr.spec.parameters.namespaces ]

if oxr.spec.parameters?.creds:
    _items += [{
        apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
        kind = "Object"
        metadata = {
            name = oxr.metadata.name + "-creds"
            annotations = {
                "crossplane.io/external-name" = oxr.spec.parameters.creds.name
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-creds"
            }
        }
        spec = {
            references = [{
                patchesFrom = {
                    apiVersion = "v1"
                    kind = "Secret"
                    name: oxr.spec.parameters.creds.name
                    namespace: oxr.spec.parameters.creds.namespace
                    fieldPath: "data." + _credReference
                }
                toFieldPath: "data." + _credReference
            } for _credReference in oxr.spec.parameters.creds.keys]
            forProvider = {
                manifest = {
                    apiVersion = "v1"
                    kind = "Secret"
                    metadata = {
                        name = oxr.spec.parameters.creds.name
                        namespace = oxr.spec.parameters.creds.namespace
                    }
                }
            }
            providerConfigRef = {name = oxr.metadata.name, kind = "ProviderConfig"}
        }
    }]
    _items += [{
        apiVersion = "protection.crossplane.io/v1beta1"
        kind = "Usage"
        metadata = {
            name = oxr.metadata.name + "-creds-usage"
            annotations = {
                "krm.kcl.dev/ready": "True"
                "crossplane.io/external-name" = oxr.metadata.name + "-creds-usage"
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-creds-usage"
            }
        }
        spec = {
            of = {
                apiVersion = "CLUSTER_API_VERSION"
                kind = "CLUSTER_KIND"
                resourceRef.name = oxr.metadata.name
            }
            by = {
                apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
                kind = "Object"
                resourceRef.name = oxr.metadata.name + "-creds"
            }
        }
    }]

items = _items
