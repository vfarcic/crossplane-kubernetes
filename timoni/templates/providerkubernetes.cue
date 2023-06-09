package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
)

#ProviderConfigKubernetesLocal: crossplane.#ComposedTemplate & {
    name: "kubernetes"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "ProviderConfig"
        spec: {
            credentials: {
                secretRef: {
                    key: "kubeconfig"
                    name: "kubeconfig"
                    namespace: "crossplane-system"
                }
                source: "Secret"
            }
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
    }, {
        fromFieldPath: "spec.claimRef.namespace"
        toFieldPath: "spec.credentials.secretRef.namespace"
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.credentials.secretRef.name"
        transforms: [{
            string:
                fmt: "%s-cluster"
            type: "string"
        }]
    }]
    readinessChecks: [{
        type: "None"
    }]
}

#ProviderConfigHelmLocal: crossplane.#ComposedTemplate & {
    base: {
        apiVersion: "helm.crossplane.io/v1alpha1"
        kind: "ProviderConfig"
        spec: {
            credentials: {
                secretRef: {
                    key: "kubeconfig"
                    name: "kubeconfig"
                    namespace: "crossplane-system"
                }
                source: "Secret"
            }
        }
    }
    name: "helm"
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
    }, {
        fromFieldPath: "spec.claimRef.namespace"
        toFieldPath: "spec.credentials.secretRef.namespace"
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.credentials.secretRef.name"
        transforms: [{
            string:
                fmt: "%s-cluster"
            type: "string"
        }]
    }]
    readinessChecks: [{
        type: "None"
    }]
}

#ProviderKubernetesSA: crossplane.#ComposedTemplate & {
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

#ProviderKubernetesCRB: crossplane.#ComposedTemplate & {
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
                        namespace: "crossplane-system"
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

#ProviderKubernetesCC: crossplane.#ComposedTemplate & {
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
                fmt: "%s-helm-provider-cc"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}
