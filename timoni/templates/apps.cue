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
    _name:           string
    _id:             "{{ $.observed.composite.resource.spec.id }}"
    _credsName:      "{{ $.observed.composite.resource.spec.parameters.creds.name }}"
    _credsKey:       "{{ $.observed.composite.resource.spec.parameters.creds.key }}"
    _credsNamespace: "{{ $.observed.composite.resource.spec.parameters.creds.namespace }}"
    _template: {
          apiVersion: "kubernetes.crossplane.io/v1alpha2"
          kind: "Object"
          metadata: {
              name: _id + "-secret-store"
              annotations: {
                  "crossplane.io/external-name": _name
                  "gotemplating.fn.crossplane.io/composition-resource-name": _id + "-secret-store"
              }
          }
          spec: {
              references: [{
                patchesFrom: {
                    apiVersion: "gcp.upbound.io/v1beta1"
                    kind:       "ProviderConfig"
                    name:       "default"
                    fieldPath:  "spec.projectID"
                }
                toFieldPath:    "spec.provider.gcpsm.projectID"
              }]
              forProvider: {
                  manifest: {
                      apiVersion: "external-secrets.io/v1beta1"
                      kind:       "ClusterSecretStore"
                      metadata: name: _name
                      spec: provider: gcpsm: auth: secretRef: secretAccessKeySecretRef: {
                          name:      _credsName
                          key:       _credsKey
                          namespace: _credsNamespace
                      }
                  }
              }
              providerConfigRef: name: _id
        }
    }
    #FunctionGoTemplating & {
        step: "secret-store"
        input: inline: template: """
        {{ if and .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled .observed.composite.resource.spec.parameters.apps.externalSecrets.store }}
        ---
        \( yaml.Marshal(_template) )
        {{ end }}
        """
    }
}

