package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
    runtime "k8s.io/apimachinery/pkg/runtime"
)

#AppHelm: crossplane.#ComposedTemplate & {
    _config:    crossplane.#ComposedTemplate
    name: _config.name
    base: {
        apiVersion: "helm.crossplane.io/v1alpha1"
        kind: "Release"
        spec: {
            forProvider: {
                chart: {
                    name: _config.name
                    repository: string
                    version: string
                }
                namespace: string
            }
            rollbackLimit: 3
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
        transforms: [{
            type: "string"
            string: {
                fmt: "%s-" + _config.name
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#AppTraefik: #AppHelm & { _config:
    name: "traefik"
    base: spec: forProvider: {
        chart: {
            repository: "https://helm.traefik.io/traefik"
            version: string
        }
        namespace: "traefik"
    }
}


#AppCrossplane: #AppHelm & { _config:
    name: "crossplane"
    base: spec: forProvider: {
        chart: {
            repository: "https://charts.crossplane.io/stable"
            version: string
        }
        namespace: "crossplane-system"
    }
}

#AppCrossplaneProvider: crossplane.#ComposedTemplate & {
    _config:    crossplane.#ComposedTemplate
    name: _config.name
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "pkg.crossplane.io/v1"
                    kind: string | *"Provider"
                    metadata: {
                        name: "crossplane-" + _config.name
                    }
                    spec: {
                        package: string
                        controllerConfigRef: {
                            name: "provider-kubernetes"
                        }
                    }
                }
            }
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
        transforms: [{
            type: "string"
            string: {
                fmt: "%s-" + _config.name
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#AppCrossplaneProviderKubernetes: #AppCrossplaneProvider & { _config:
    name: "kubernetes-provider"
    base: spec: forProvider: manifest: kind: "Provider"
}

#AppCrossplaneProviderHelm: #AppCrossplaneProvider & { _config:
    name: "helm-provider"
}

#AppCrossplaneConfigApp: #AppCrossplaneProvider & { _config:
    name: "app-config"
    base: spec: forProvider: manifest: kind: "Configuration"
}

#AppCrossplaneConfigSql: #AppCrossplaneProvider & { _config:
    name: "sql-config"
    base: spec: forProvider: manifest: kind: "Configuration"
}

#AppObject: crossplane.#ComposedTemplate & {
    _config:    crossplane.#ComposedTemplate
    name: _config.name
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: runtime.#RawExtension
            }
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
        transforms: [{
            type: "string"
            string: {
                fmt: "%s-" + _config.name
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

// TODO: Remove
// #AppSchemaHeroNs: #AppObject & { _config:
//     name: "schemahero-ns"
//     base: spec: forProvider: manifest: {
//         apiVersion: "v1"
//         kind: "Namespace"
//         metadata: {
//             name: "schemahero-system"
//         }
//     }
// }
