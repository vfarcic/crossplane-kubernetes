package templates

#ProviderConfig: {
    _composeConfig: {...}
    name:    _composeConfig.name + "-pc"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha2"
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

#ProviderKubernetesNamespaces: {
    #FunctionGoTemplating & { 
        step: "namespaces"
        input: inline: template: """
        {{ range .observed.composite.resource.spec.parameters.namespaces }}
        ---
        apiVersion: kubernetes.crossplane.io/v1alpha2
        kind: Object
        metadata:
          name: {{ $.observed.composite.resource.spec.id }}-ns-{{ . }}
          annotations:
            crossplane.io/external-name: {{ . }}
            gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-ns-{{ . }}
        spec:
          forProvider:
            manifest:
              apiVersion: "v1"
              kind: "Namespace"
              metadata:
                name: {{ . }}
          providerConfigRef:
            name: {{ $.observed.composite.resource.spec.id }}
        {{ end }}
        """
    }
}
