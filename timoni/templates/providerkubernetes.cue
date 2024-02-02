package templates

// #ProviderConfig: {
//     _composeConfig: {...}
//     name:    _composeConfig.name + "-pc"
//     base: {
//         apiVersion: "kubernetes.crossplane.io/v1alpha2"
//         kind: "Object"
//         spec: {
//             forProvider: {
//                 manifest: {
//                     apiVersion: _composeConfig.name + ".upbound.io/v1beta1"
//                     kind: "ProviderConfig"
//                     metadata: name: "default"
//                     spec: {
// 						credentials: {
//                 			source: "Secret"
//                 			secretRef: {
//                   				namespace: "crossplane-system"
//                   				name: _composeConfig.name + "-creds"
//                   				key: "creds"
// 							}
// 						}
//                     }
//                 }
//             }
//         }
//     }
//     patches: [{
//         fromFieldPath: "spec.id"
//         toFieldPath: "metadata.name"
//         transforms: [{
//             type: "string"
//             string: {
//                 fmt: "%s-" + _composeConfig.name + "-pc"
//                 type: "Format"
//             }
//         }]
//     }, {
//         fromFieldPath: "spec.id"
//         toFieldPath: "spec.providerConfigRef.name"
//     }]
// }

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

#Creds: {
    #FunctionGoTemplating & { 
        step: "creds"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.creds }}
        ---
        apiVersion: kubernetes.crossplane.io/v1alpha2
        kind: Object
        metadata:
          name: {{ $.observed.composite.resource.spec.id }}-creds
          annotations:
            gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-creds
            crossplane.io/external-name: {{ $.observed.composite.resource.spec.parameters.creds.name }}
        spec:
          references:
          {{ range $.observed.composite.resource.spec.parameters.creds.keys }}
          - patchesFrom:
              apiVersion: v1
              kind: Secret
              name: {{ $.observed.composite.resource.spec.parameters.creds.name }}
              namespace: {{ $.observed.composite.resource.spec.parameters.creds.namespace }}
              fieldPath: data.{{ . }}
            toFieldPath: data.{{ . }}
          {{ end }}
          forProvider:
            manifest:
              apiVersion: v1
              kind: Secret
              metadata:
                name: {{ $.observed.composite.resource.spec.parameters.creds.name }}
                namespace: {{ $.observed.composite.resource.spec.parameters.creds.namespace }}
          providerConfigRef:
            name: {{ $.observed.composite.resource.spec.id }}
        {{ end }}
        """
    }
}

#ReleaseTemplate: {
    _id:              "{{ $.observed.composite.resource.spec.id }}"
    _name:            string
    _chartVersion:    string
    _chartRepository: string
    _chartURL:        string
    _namespace:       string
    _rollbackLimit:   int | *3
    _set:             [...]
    apiVersion: "helm.crossplane.io/v1beta1"
    kind:       "Release"
    metadata: {
        name: _id + "-app-" + _name
        annotations: {
            "crossplane.io/external-name": _name
            "gotemplating.fn.crossplane.io/composition-resource-name": _id + "-app-" + _name
        }
    }
    spec: {
        forProvider: {
            chart: {
                name:       _name
                repository: _chartRepository
                version:    _chartVersion
                url:        _chartURL
            }
            set: _set
            namespace: _namespace
        }
        rollbackLimit: 3
        providerConfigRef: name: _id
        rollbackLimit: _rollbackLimit
    }
}
