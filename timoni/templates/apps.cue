package templates

import (
    runtime "k8s.io/apimachinery/pkg/runtime"
)

#AppHelm: {
    _composeConfig: {...}
    name:    _composeConfig.name
    base: {
        apiVersion: "helm.crossplane.io/v1beta1"
        kind: "Release"
        spec: {
            forProvider: {
                chart: {
                    name: _composeConfig.name
                    repository: string
                    version: string
                }
                set: [...]
                namespace: string | *"kube-system"
            }
            rollbackLimit: 3
        }
    }
    patches: [...] | *[{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
        transforms: [{
            type: "string"
            string: {
                fmt: "%s-" + _composeConfig.name
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#AppTraefik: #AppHelm & { _composeConfig:
    name: "traefik"
    base: spec: forProvider: {
        chart: {
            repository: "https://helm.traefik.io/traefik"
            version: string
        }
        namespace: "traefik"
    }
}

#AppCrossplaneProvider: {
    _composeConfig: {...}
    name:           _composeConfig.name
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "pkg.crossplane.io/v1"
                    kind: string | *"Provider"
                    metadata: {
                        name: "crossplane-" + _composeConfig.name
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
                fmt: "%s-" + _composeConfig.name
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#AppCrossplaneConfig: {
    #AppCrossplaneProvider & {
        base: spec: forProvider: manifest: kind: "Configuration"
    }
}

#AppObject: {
    _config: {...}
    name:    _config.name
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
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#AppCrossplane: #AppHelm & { _composeConfig:
	name: "crossplane"
	base: spec: forProvider: {
		chart: {
			repository: "https://charts.crossplane.io/stable"
			// version: _config.versions.crossplane
			version: string
		}
		namespace: "crossplane-system"
	}
}