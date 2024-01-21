package templates

import "encoding/yaml"

#AppHelm: {
    _composeConfig: {...}
    name: _composeConfig.name
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

// TODO: Add to hyperscalers
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

#AppCrossplane: {
    _version: string
    _template: #ReleaseTemplate & {
        _name:            "crossplane"
        _chartVersion:    _version
        _chartRepository: "https://charts.crossplane.io/stable"
        _chartURL:        ""
        _namespace:       "crossplane-system"
    }
    #FunctionGoTemplating & {
        step: "app-crossplane"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.crossplane.enabled }}
        ---
        \( yaml.Marshal(_template) )
        {{ end }}
        """
    }
}

#AppOpenFunction: {
    _url: string
    _template: #ReleaseTemplate & {
        _name:            "openfunction"
        _chartVersion:    ""
        _chartRepository: ""
        _chartURL:        _url
        _set: [{
            name:  "revisionController.enable"
            value: "true"
        }]
        _namespace: "openfunction"
    }
    #FunctionGoTemplating & {
        step: "app-openfunction"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.openfunction.enabled }}
        ---
        \( yaml.Marshal(_template) )
        {{ end }}
        """
    }
}

#AppExternalSecrets: {
    _version: string
    _template: #ReleaseTemplate & {
        _name:            "external-secrets"
        _chartVersion:    _version
        _chartRepository: "https://charts.external-secrets.io"
        _chartURL:        ""
        _set: [{
            name: "installCRDs"
            value: "true"
        }]
        _namespace: "external-secrets"
    }
    #FunctionGoTemplating & {
        step: "app-external-secrets"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled }}
        ---
        \( yaml.Marshal(_template) )
        {{ end }}
        """
    }
}

#AppExternalSecretsStore: {
    _name:                  string
    _id:                    "{{ $.observed.composite.resource.spec.id }}"
    _credsName:             "{{ $.observed.composite.resource.spec.parameters.creds.name }}"
    _googleCredsKey:        "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.googleCredentialsKey }}"
    _awsAccessKeyIDKey:     "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.awsAccessKeyIDKey }}"
    _awsSecretAccessKeyKey: "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.awsSecretAccessKeyKey }}"
    _azureVaultUrl:         "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.azureVaultUrl }}"
    _credsNamespace:        "{{ $.observed.composite.resource.spec.parameters.creds.namespace }}"
    #FunctionGoTemplating & {
        step: "secret-store"
        input: inline: template: """
        {{ if and .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled .observed.composite.resource.spec.parameters.apps.externalSecrets.store }}
        ---
        apiVersion: kubernetes.crossplane.io/v1alpha2
        kind: Object
        metadata:
          name: \( _id )-secret-store
          annotations:
            crossplane.io/external-name: \( _name )
            gotemplating.fn.crossplane.io/composition-resource-name: \( _id )-secret-store
        spec:
          {{ if $.observed.composite.resource.spec.parameters.apps.externalSecrets.googleCredentialsKey }}
          references:
            - patchesFrom:
                apiVersion: gcp.upbound.io/v1beta1
                kind: ProviderConfig
                name: default
                fieldPath: spec.projectID
              toFieldPath: spec.provider.gcpsm.projectID
          {{ end }}
          forProvider:
            manifest:
              apiVersion: external-secrets.io/v1beta1
              kind: ClusterSecretStore
              metadata:
                name: \( _name )
              spec:
                provider:
                  {{ if $.observed.composite.resource.spec.parameters.apps.externalSecrets.googleCredentialsKey }}
                  gcpsm:
                    auth:
                      secretRef:
                        secretAccessKeySecretRef:
                          name: \( _credsName )
                          key: \( _googleCredsKey )
                          namespace: \( _credsNamespace )
                  {{ end }}
                  {{ if and $.observed.composite.resource.spec.parameters.apps.externalSecrets.awsAccessKeyIDKey $.observed.composite.resource.spec.parameters.apps.externalSecrets.awsSecretAccessKeyKey }}
                  aws:
                    service: SecretsManager
                    region: us-east-1
                    auth:
                      secretRef:
                        accessKeyIDSecretRef:
                          name: \( _credsName )
                          key: \( _awsAccessKeyIDKey )
                          namespace: \( _credsNamespace )
                        secretAccessKeySecretRef:
                          name: \( _credsName )
                          key: \( _awsSecretAccessKeyKey )
                          namespace: \( _credsNamespace )
                  {{ end }}
                  {{ if $.observed.composite.resource.spec.parameters.apps.externalSecrets.azureVaultUrl }}
                  azurekv:
                    authType: ManagedIdentity
                    vaultUrl: \( _azureVaultUrl )
                  {{ end }}
          providerConfigRef:
            name: \( _id )
        {{ end }}
        """
    }
}

#AppExternalSecretsSecret: {
    _name: string
    _id:   "{{ $.observed.composite.resource.spec.id }}"
    _fromSecret: "{{ .fromSecret }}"
    _toSecret: "{{ .toSecret }}"
    _toNamespace: "{{ .toNamespace }}"
    _template: {
        apiVersion: "kubernetes.crossplane.io/v1alpha2"
        kind: "Object"
        metadata: {
            name: _id + "-secret-" + _toSecret
            annotations: {
                "crossplane.io/external-name": _toSecret
                "gotemplating.fn.crossplane.io/composition-resource-name": _id + "-secret-" + _toSecret
            }
        }
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "external-secrets.io/v1beta1"
                    kind: "ExternalSecret"
                    metadata: {
                        name: _toSecret
                        namespace: _toNamespace
                    }
                    spec: {
                        refreshInterval: "1h"
                        secretStoreRef: {
                            kind: "ClusterSecretStore"
                            name: _name
                        }
                        target: {
                            name: _toSecret
                            creationPolicy: "Owner"
                        }
                        dataFrom: [{
                            extract: key: _fromSecret
                        }]
                    }
                }
            }
            providerConfigRef: name: _id
        }
    }
    #FunctionGoTemplating & {
        step: "secrets"
        input: inline: template: """
        {{ range .observed.composite.resource.spec.parameters.apps.externalSecrets.secrets }}
        ---
        \( yaml.Marshal(_template) )
        {{ end }}
        """
    }
}
