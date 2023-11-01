package templates

#ProviderConfig: {
    _composeConfig: {...}
    name:    _composeConfig.name + "-pc"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: _composeConfig.name + ".upbound.io/v1beta1"
                    kind: "ProviderConfig"
                    metadata: name: "default"
                    spec: {
						credentials: {
                			source: "Secret"
                			secretRef: {
                  				namespace: "crossplane-system"
                  				name: _composeConfig.name + "-creds"
                  				key: "creds"
							}
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
                fmt: "%s-" + _composeConfig.name + "-pc"
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderConfigLocal: {
    name: string
    base: {
        apiVersion: string
        kind:       "ProviderConfig"
        spec: {
            credentials: {
                secretRef: {
                    key:       "kubeconfig"
                    name:      "kubeconfig"
                    namespace: "crossplane-system"
                }
                source: "Secret"
            }
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath:   "metadata.name"
    }, {
        fromFieldPath: "spec.claimRef.namespace"
        toFieldPath:   "spec.credentials.secretRef.namespace"
    }, {
        fromFieldPath: "spec.id"
        toFieldPath:   "spec.credentials.secretRef.name"
        transforms: [{
            string: {
                fmt: "%s-cluster"
                type: "Format"
            }
            type: "string"
        }]
    }]
    readinessChecks: [{
        type: "None"
    }]
}

#ProviderConfigKubernetesLocal: {
    #ProviderConfigLocal & {
        name: "kubernetes"
        base: apiVersion: "kubernetes.crossplane.io/v1alpha1"
    }
}

#ProviderConfigHelmLocal: {
    #ProviderConfigLocal & {
        name: "helm"
        base: apiVersion: "helm.crossplane.io/v1beta1"
    }
}

#ProviderKubernetesSa: {
    name: "k8s-provider-sa"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "v1"
                    kind: "ServiceAccount"
                    metadata: {
                        name: "provider-kubernetes"
                        namespace: "crossplane-system"
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
                fmt: "%s-k8s-provider-sa"
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderKubernetesCrb: {
    name: "k8s-provider-crb"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "rbac.authorization.k8s.io/v1"
                    kind: "ClusterRoleBinding"
                    metadata: {
                        name: "provider-kubernetes"
                    }
                    subjects: [{
                        kind: "ServiceAccount"
                        name: "provider-kubernetes"
                        namespace: "crossplane-system"
                    }]
                    roleRef: {
                        kind: "ClusterRole"
                        name: "cluster-admin"
                        apiGroup: "rbac.authorization.k8s.io"
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
                fmt: "%s-k8s-provider-crb"
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderKubernetesCc: {
    name: "k8s-provider-cc"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "pkg.crossplane.io/v1alpha1"
                    kind: "ControllerConfig"
                    metadata: {
                        name: "provider-kubernetes"
                    }
                    spec: {
                        serviceAccountName: "provider-kubernetes"
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
                fmt: "%s-k8s-provider-cc"
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderHelmCC: {
    name: "helm-provider-cc"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "pkg.crossplane.io/v1beta1"
                    kind: "ControllerConfig"
                    metadata: {
                        name: "provider-kubernetes"
                    }
                    spec: {
                        serviceAccountName: "provider-kubernetes"
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
                fmt: "%s-helm-provider-cc"
                type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}
