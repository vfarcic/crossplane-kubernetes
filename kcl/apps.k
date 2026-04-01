crossplane = "2.1.4"
argocd = "9.4.1"
dapr = "1.16.8"
traefik = "39.0.0"
externalSecrets = "2.0.0"
cilium = "1.19.0"
nvidiaGpuOperator = "v25.10.1"
keda = "2.19.0"
kedaHttpAddon = "0.12.2"
wva = "0.5.1"
valkey = "0.9.3"
lws = "0.8.0"
opentelemetryCollector = "0.147.1"
certManager = "1.20.1"

caCert = """\
-----BEGIN CERTIFICATE-----
MIICtDCCAZwCCQCwutQ4rXrN1zANBgkqhkiG9w0BAQsFADAcMRowGAYDVQQDDBFs
bG0tZC1pbnRlcm5hbC1jYTAeFw0yNjA0MDEyMTE2NTFaFw0zNjAzMjkyMTE2NTFa
MBwxGjAYBgNVBAMMEWxsbS1kLWludGVybmFsLWNhMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAwVIzxDwt2A3lKbXi38vae+1EmSZY7Mr/Vo/XfPbvtcq5
n2zHk4Fv/1sI8HeynOftj84sRn7JpuhrznlEtsIj3qqAHsfksOnF5J1cp9V0ZgA7
regImD5vE6LXgI87UEtzR0hczGyBtoEknER5pfSxr4MNRpHK+61DjriLxaKzzEk8
RSlyei17WtAzvRFnWdC7G6eSjqs22NFTH10TBXGYcieOZEGScABv5fO+0TFbr1JD
GTBUQPvKHsZp3gMCWixHh0vKGZZINepxWaVeCFGTvXnmfHoESwHSTOgc7KgKXQIU
+ajf1yD7fHvAaYkIqqdQqErhdVlraHeeqwuIfmdR0QIDAQABMA0GCSqGSIb3DQEB
CwUAA4IBAQAJTLEPkhtTssTTDXAi+8UOgrYWHeA+gq8+EiiCcn2Qxxga+mBCmd4U
Q8cjJhoqxbLAVWTdvAokYtxIPwGmdNrF+mgrlQhohieusZPVFGzvPOJMhVJmJkxr
NFngWvriDH1j9LIL/cLAsep1cahW8H2pCLT4baubkcEZ8W4SPzAnAYM5Igo86VUr
MDsD0CwG7uk9MFxJjkj2yW0S91YOGYgYCU0aBazjqlyoDPvhUnPPUXXar8/Qw87U
GxiMVeFMA63tKS5jIk4F3SD2AUZUE8aWEvsqyIlrXbLQsWxjs9lG9r8ngyaX+jsr
9TXEi9MyhtApHPfL9Z0b/SeAZDvOrVGj
-----END CERTIFICATE-----\
"""

promTlsCert = """\
-----BEGIN CERTIFICATE-----
MIIDQzCCAiugAwIBAgIJAMZ5uzevd6k6MA0GCSqGSIb3DQEBCwUAMBwxGjAYBgNV
BAMMEWxsbS1kLWludGVybmFsLWNhMB4XDTI2MDQwMTIxMTcwN1oXDTM2MDMyOTIx
MTcwN1owFTETMBEGA1UEAwwKcHJvbWV0aGV1czCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMR7rvljWNlc6XXYfVtUtHbf/R6Es97wsYePUqp248UTlRCH
FOfdUKwUqeoyIKn3fRv53hEMff7sh6rYKwd1CzXIR7+EZq0uAijUxINBgu7+S3EZ
35a+s4SLhzyqb1sZk+5Yw/ufV4bXgT6xcwwm/MGvlpcOhNkhHqRGSKFDaTMTseaa
KDH2VOqwqNniFg+z3KGszGaAYzxyIHGswCqGpDGXjgGtxy4Y8x9lQuLEneUeIQeT
vrlX5kyjW49Rqf0RWa5nrVnQlUpasuV6TAuTJW6s/nPvd6qn+1RnZbiiTsTaG0UL
+oqAGpfnSlnEP14Q1xCraAIUJozvdvr8EQNoJx0CAwEAAaOBjjCBizCBiAYDVR0R
BIGAMH6CRGt1YmUtcHJvbWV0aGV1cy1zdGFjay1wcm9tZXRoZXVzLnByb21ldGhl
dXMtc3lzdGVtLnN2Yy5jbHVzdGVyLmxvY2FsgjZrdWJlLXByb21ldGhldXMtc3Rh
Y2stcHJvbWV0aGV1cy5wcm9tZXRoZXVzLXN5c3RlbS5zdmMwDQYJKoZIhvcNAQEL
BQADggEBAEdSwDv/YHxGKUi9LsBg3cF6+4qmDU7gjapgEsNtUK6RPver8ST1TcNr
68BBt41fzkakYoReXtRfMYYh9ZZ1o3iPyHSxmwL/7WtnAWlQKoKP4Wd3OpNnzROu
qgYvvVrS68P1CTpFAOG/fATvH3pk8ZPTIW5c4ZivTEn0LLzxoBDymRyiUPLOpcA9
Q0NEWQ7roM46GD+V4OUtWE2EPlVJfCjnk/nh23WEoaMWvvsx62rgxThy+fTlYZSD
JpX16L92D77FZKDJxJgSOuYadLKHE7VK5yA8/IKt5pueiigalCkTkGfSBCY3DGwa
0mSM05qAjrjhgYe8qVtEzdKHUFb3YzQ=
-----END CERTIFICATE-----\
"""

promTlsKey = """\
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEe675Y1jZXOl1
2H1bVLR23/0ehLPe8LGHj1KqduPFE5UQhxTn3VCsFKnqMiCp930b+d4RDH3+7Ieq
2CsHdQs1yEe/hGatLgIo1MSDQYLu/ktxGd+WvrOEi4c8qm9bGZPuWMP7n1eG14E+
sXMMJvzBr5aXDoTZIR6kRkihQ2kzE7Hmmigx9lTqsKjZ4hYPs9yhrMxmgGM8ciBx
rMAqhqQxl44BrccuGPMfZULixJ3lHiEHk765V+ZMo1uPUan9EVmuZ61Z0JVKWrLl
ekwLkyVurP5z73eqp/tUZ2W4ok7E2htFC/qKgBqX50pZxD9eENcQq2gCFCaM73b6
/BEDaCcdAgMBAAECggEAMeum0jAeo+NKYammd+z2iPlx6y4WMT+AK4wLmcnpJupJ
xlA7zIlbdM0vOpSP3f9GZzQ96qD85iccdRjFHfjr5zdCm3M9TyTQYaVlZF/hr20m
p87GExvSqot0ycIX1tKR1k3xRV3/s//PE6msLFs/fspo/Wov8KbMjTpaO7bP5Kzb
UFjVmFiI+yh5NcYDwQ6qyh6EA1hxkZYwooVvNyx6dn4mf2OnPAYUWBgXtPye+4Kv
HhY9nBLTV84xT8zVPPk3EkFDssI0jpSxWarjL16M00JSxeKAeeA3SVIVaS1Wg1ZS
KgYmcgRLe4P1IrY0/sJ7MJdkl6IYfdIv8snawLsXYQKBgQDnyp4EV44lcoFyWTUP
xb2IFDEjSExLtZSrJQUAFpWRP3oSVAtpoWJzXSi6+QDlUyIAOZMMtLvDmSPiyHZK
et/ZXJqBE3mRlXCGp+y91eg/e5c4lJmi473kfC1D/ifOHQJUtyyfV0S3AVWbXpf0
mNlxXWLmcyX+nW7T5P37BtP06QKBgQDZAQf+oPs8rkumZOQKp3aSKVBVWEAZxWGd
E9xpbvqBDtsgi6t1H6g15a7njm9sX1i4BBWj2nJLlma3lN9S362uFQF2UVl4M8P3
5nfpGXWjXaCyLK4PQXAq1qsnSjvHkU51avunRTVucghZUd1Bq1GI3E8Fo8xYfUZ2
s0LFRvKQFQKBgDlINWzVRmeyuJLNwPM45vHuK4aQo2pCYY86AtZWvne6vCwzYO6l
13KzHxG136bMuKZdlB2bvJtGCTxOVg1p+E/7NqOXcH+t8rUUYsk3R8IIhQKSlrVO
musQVQ9si+HAAYd2DS0DoBOp3MIcymjELVh6v6o74rPdrDnpaWrT8SWhAoGBAMTV
8KCA+SMDnk8iOM+JMz5FBz9Cu3Ik3fQTLdzc85DZHt6Ykj+9JWEuI8aaJmuQ2PKh
kdd8sCvsEuP2v9N2XR4Io7jk9VjY66sTfDUOCOzUYoz7hi8EVnAlJD6RUUQmg5py
Hi6N0neKLBSI8z873MtdurgM6bBigeXtmGVFg4Q5AoGBALY6kkWWL8kgQgLTZipg
UQCoXRw2nsTulqlkGu5pw0WNALD/HYQ55C5UFOL1ahLwwM5756OJn/4x0KAcV/0k
zDOpJVe6ywAnrefQBbfBBqloyh+ESYfrlkq+/blRLkbkPIcX01AR1i9PhTnEhao5
3/SP2c4xXBwvOzIlAuxwIVXa
-----END PRIVATE KEY-----\
"""

envoyGateway = "1.7.0"
aiGateway = "0.5.0"
kubePrometheusStack = "82.2.1"
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
    _managementPolicies?: [str]
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
        if _managementPolicies:
            managementPolicies = _managementPolicies
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
        usage { _nameSuffix = "app-crossplane", _kind = "Release" }

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
        usage { _nameSuffix = "app-argo-cd", _kind = "Release" }
        usage { _nameSuffix = "app-argo-cd-app" }

    if oxr.spec.parameters?.apps?.openfunction?.enabled:
        chart {
            _name = "openfunction"
            _chartUrl = openFunctionUrl
            _namespace = "openfunction"
            _values = {
                revisionController.enable = True
            }
        }
        usage { _nameSuffix = "app-openfunction", _kind = "Release" }

    if oxr.spec.parameters?.apps?.dapr?.enabled:
        chart {
            _name = "dapr"
            _chartRepository = "https://dapr.github.io/helm-charts/"
            _chartVersion = dapr
            _namespace = "dapr-system"
        }
        usage { _nameSuffix = "app-dapr", _kind = "Release" }

    if oxr.spec.parameters?.apps?.traefik?.enabled:
        chart {
            _name = "traefik"
            _chartRepository = "https://helm.traefik.io/traefik"
            _chartVersion = traefik
            _namespace = "traefik"
        }
        usage { _nameSuffix = "app-traefik", _kind = "Release" }

    if oxr.spec.parameters?.apps?.keda?.enabled:
        chart {
            _name = "keda"
            _chartRepository = "https://kedacore.github.io/charts"
            _chartVersion = keda
            _namespace = "keda"
        }
        usage { _nameSuffix = "app-keda", _kind = "Release" }
        chart {
            _name = "keda-add-ons-http"
            _chartRepository = "https://kedacore.github.io/charts"
            _chartVersion = kedaHttpAddon
            _namespace = "keda"
        }
        usage { _nameSuffix = "app-keda-add-ons-http", _kind = "Release" }

    if oxr.spec.parameters?.apps?.envoyGateway?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled:
        chart {
            _name = "gateway-helm"
            _chartUrl = "oci://docker.io/envoyproxy/gateway-helm"
            _chartVersion = envoyGateway
            _namespace = "envoy-gateway-system"
            _values = {
                config.envoyGateway = {
                    extensionApis.enableBackend = True
                    extensionManager = {
                        hooks.xdsTranslator = {
                            translation = {
                                listener.includeAll = True
                                route.includeAll = True
                                cluster.includeAll = True
                                secret.includeAll = True
                            }
                            post = ["Translation", "Cluster", "Route"]
                        }
                        service.fqdn = {
                            hostname = "ai-gateway-controller.envoy-ai-gateway-system.svc.cluster.local"
                            port = 1063
                        }
                        backendResources = [{
                            group = "inference.networking.k8s.io"
                            kind = "InferencePool"
                            version = "v1"
                        }]
                    }
                }
            }
        }
        usage { _nameSuffix = "app-gateway-helm", _kind = "Release" }
        chart {
            _name = "ai-gateway-crds-helm"
            _chartUrl = "oci://docker.io/envoyproxy/ai-gateway-crds-helm"
            _chartVersion = aiGateway
            _namespace = "envoy-ai-gateway-system"
        }
        usage { _nameSuffix = "app-ai-gateway-crds-helm", _kind = "Release" }
        chart {
            _name = "ai-gateway-helm"
            _chartUrl = "oci://docker.io/envoyproxy/ai-gateway-helm"
            _chartVersion = aiGateway
            _namespace = "envoy-ai-gateway-system"
        }
        usage { _nameSuffix = "app-ai-gateway-helm", _kind = "Release" }
        object {
            _name = "envoy-gateway-class"
            _manifest = {
                apiVersion = "gateway.networking.k8s.io/v1"
                kind = "GatewayClass"
                metadata = {
                    name = "eg"
                }
                spec = {
                    controllerName = "gateway.envoyproxy.io/gatewayclass-controller"
                }
            }
        }
        usage { _nameSuffix = "app-envoy-gateway-class" }
        object {
            _name = "envoy-gateway"
            _manifest = {
                apiVersion = "gateway.networking.k8s.io/v1"
                kind = "Gateway"
                metadata = {
                    name = "eg"
                    namespace = "envoy-gateway-system"
                }
                spec = {
                    gatewayClassName = "eg"
                    listeners = [{
                        name = "http"
                        protocol = "HTTP"
                        port = 80
                        allowedRoutes = {
                            namespaces = {
                                from = "All"
                            }
                        }
                    }]
                }
            }
        }
        usage { _nameSuffix = "app-envoy-gateway" }
        object {
            _name = "inference-crd-inferencepools"
            _externalName = "inferencepools.inference.networking.k8s.io"
            _managementPolicies = ["Create", "Update", "Observe"]
            _manifest = {
                apiVersion = "apiextensions.k8s.io/v1"
                kind = "CustomResourceDefinition"
                metadata = {
                    name = "inferencepools.inference.networking.k8s.io"
                    annotations = {
                        "api-approved.kubernetes.io" = "https://github.com/kubernetes-sigs/gateway-api-inference-extension/pull/1173"
                        "inference.networking.k8s.io/bundle-version" = "v1.3.1"
                    }
                }
                spec = {
                    group = "inference.networking.k8s.io"
                    names = { kind = "InferencePool", listKind = "InferencePoolList", plural = "inferencepools", singular = "inferencepool", shortNames = ["infpool"] }
                    scope = "Namespaced"
                    versions = [{
                        name = "v1"
                        served = True
                        storage = True
                        subresources.status = {}
                        schema.openAPIV3Schema = { type = "object", "x-kubernetes-preserve-unknown-fields" = True }
                    }]
                }
            }
        }
        usage { _nameSuffix = "app-inference-crd-inferencepools" }
        object {
            _name = "inference-crd-inferenceobjectives"
            _externalName = "inferenceobjectives.inference.networking.x-k8s.io"
            _managementPolicies = ["Create", "Update", "Observe"]
            _manifest = {
                apiVersion = "apiextensions.k8s.io/v1"
                kind = "CustomResourceDefinition"
                metadata = {
                    name = "inferenceobjectives.inference.networking.x-k8s.io"
                    annotations = {
                        "api-approved.kubernetes.io" = "https://github.com/kubernetes-sigs/gateway-api-inference-extension/pull/1173"
                        "inference.networking.k8s.io/bundle-version" = "v1.3.1"
                    }
                }
                spec = {
                    group = "inference.networking.x-k8s.io"
                    names = { kind = "InferenceObjective", listKind = "InferenceObjectiveList", plural = "inferenceobjectives", singular = "inferenceobjective" }
                    scope = "Namespaced"
                    versions = [{
                        name = "v1alpha2"
                        served = True
                        storage = True
                        subresources.status = {}
                        schema.openAPIV3Schema = { type = "object", "x-kubernetes-preserve-unknown-fields" = True }
                    }]
                }
            }
        }
        usage { _nameSuffix = "app-inference-crd-inferenceobjectives" }

    if oxr.spec.parameters?.apps?.certManager?.enabled:
        chart {
            _name = "cert-manager"
            _chartUrl = "oci://quay.io/jetstack/charts/cert-manager"
            _chartVersion = certManager
            _namespace = "cert-manager"
            _values = {
                crds.enabled = True
            }
        }
        usage { _nameSuffix = "app-cert-manager", _kind = "Release" }

    if oxr.spec.parameters?.apps?.prometheus?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled:
        chart {
            _name = "kube-prometheus-stack"
            _chartRepository = "https://prometheus-community.github.io/helm-charts"
            _chartVersion = kubePrometheusStack
            _namespace = "prometheus-system"
            if oxr.spec.parameters?.apps?.llmd?.enabled:
                _values = {
                    prometheus.prometheusSpec.web.tlsConfig = {
                        cert.secret = {
                            name = "prometheus-tls"
                            key = "tls.crt"
                        }
                        keySecret = {
                            name = "prometheus-tls"
                            key = "tls.key"
                        }
                    }
                }
        }
        usage { _nameSuffix = "app-kube-prometheus-stack", _kind = "Release" }

    if oxr.spec.parameters?.apps?.llmd?.enabled:
        object {
            _name = "prometheus-tls"
            _manifest = {
                apiVersion = "v1"
                kind = "Secret"
                metadata = {
                    name = "prometheus-tls"
                    namespace = "prometheus-system"
                }
                type = "kubernetes.io/tls"
                stringData = {
                    "tls.crt" = promTlsCert
                    "tls.key" = promTlsKey
                    "ca.crt" = caCert
                }
            }
        }
        usage { _nameSuffix = "app-prometheus-tls" }
        chart {
            _name = "wva"
            _chartName = "workload-variant-autoscaler"
            _chartUrl = "oci://ghcr.io/llm-d/workload-variant-autoscaler"
            _chartVersion = wva
            _namespace = "workload-variant-autoscaler-system"
            _values = {
                llmd.namespace = "workload-variant-autoscaler-system"
                wva.prometheus = {
                    monitoringNamespace = "prometheus-system"
                    baseURL = "https://kube-prometheus-stack-prometheus.prometheus-system.svc.cluster.local:9090"
                    caCert = caCert
                }
            }
        }
        usage { _nameSuffix = "app-wva", _kind = "Release" }

    if oxr.spec.parameters?.apps?.valkey?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled:
        chart {
            _name = "valkey"
            _chartRepository = "https://valkey.io/valkey-helm/"
            _chartVersion = valkey
            _namespace = "valkey-system"
        }
        usage { _nameSuffix = "app-valkey", _kind = "Release" }

    if oxr.spec.parameters?.apps?.llmd?.enabled:
        chart {
            _name = "lws"
            _chartUrl = "oci://registry.k8s.io/lws/charts/lws"
            _chartVersion = lws
            _namespace = "lws-system"
        }
        usage { _nameSuffix = "app-lws", _kind = "Release" }

    if oxr.spec.parameters?.apps?.llmd?.enabled or oxr.spec.parameters?.apps?.prometheus?.enabled:
        chart {
            _name = "opentelemetry-collector"
            _chartRepository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
            _chartVersion = opentelemetryCollector
            _namespace = "opentelemetry-collector-system"
            _values = {
                mode = "deployment"
                image.repository = "ghcr.io/open-telemetry/opentelemetry-collector-releases/opentelemetry-collector-k8s"
            }
        }
        usage { _nameSuffix = "app-opentelemetry-collector", _kind = "Release" }

    if (oxr.spec.parameters?.apps?.envoyGateway?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled) and (oxr.spec.parameters?.apps?.prometheus?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled):
        object {
            _name = "envoy-gateway-pod-monitor"
            _manifest = {
                apiVersion = "monitoring.coreos.com/v1"
                kind = "PodMonitor"
                metadata = {
                    name = "envoy-gateway-proxy"
                    namespace = "envoy-gateway-system"
                    labels = {
                        release = "kube-prometheus-stack"
                    }
                }
                spec = {
                    selector = {
                        matchLabels = {
                            "app.kubernetes.io/component" = "proxy"
                        }
                    }
                    podMetricsEndpoints = [{
                        port = "metrics"
                        path = "/stats/prometheus"
                    }]
                }
            }
        }
        usage { _nameSuffix = "app-envoy-gateway-pod-monitor" }

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
        usage { _nameSuffix = "app-external-secrets", _kind = "Release" }

    if oxr.spec.parameters?.apps?.nvidia?.enabled or oxr.spec.parameters?.apps?.llmd?.enabled:
        chart {
            _name = "gpu-operator"
            _chartRepository = "https://helm.ngc.nvidia.com/nvidia"
            _chartVersion = nvidiaGpuOperator
            _namespace = "gpu-operator"
            _values = {
                driver.enabled = False
            }
        }
        usage { _nameSuffix = "app-gpu-operator", _kind = "Release" }

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
        usage { _nameSuffix = "app-secret-store" }

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
