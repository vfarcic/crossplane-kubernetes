package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
)

#ProviderConfigLocal: crossplane.#ComposedTemplate & {
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
            string: fmt: "%s-cluster"
            type: "string"
        }]
    }]
    readinessChecks: [{
        type: "None"
    }]
}

#ProviderConfigKubernetesLocal: crossplane.#ComposedTemplate & {
    #ProviderConfigLocal & {
        name: "kubernetes"
        base: apiVersion: "kubernetes.crossplane.io/v1alpha1"
    }
}

#ProviderConfigHelmLocal: crossplane.#ComposedTemplate & {
    #ProviderConfigLocal & {
        name: "helm"
        base: apiVersion: "helm.crossplane.io/v1beta1"
    }
}

#ProviderKubernetesSa: crossplane.#ComposedTemplate & {
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
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderKubernetesCrb: crossplane.#ComposedTemplate & {
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
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderKubernetesCc: crossplane.#ComposedTemplate & {
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
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}

#ProviderHelmCC: crossplane.#ComposedTemplate & {
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
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}
