package templates

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
    _composeConfig: {...}
    #FunctionGoTemplating & {
        step: "app-crossplane"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.crossplane.enabled }}
        ---
        apiVersion: helm.crossplane.io/v1beta1
        kind: Release
        metadata:
          name: {{ $.observed.composite.resource.spec.id }}-app-crossplane
          annotations:
            crossplane.io/external-name: crossplane
            gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-app-crossplane
        spec:
          forProvider:
            chart:
              name: crossplane
              repository: https://charts.crossplane.io/stable
              version: \( _composeConfig.version )
            namespace: crossplane-system
          rollbackLimit: 3
          providerConfigRef:
            name: {{ $.observed.composite.resource.spec.id }}
        {{ end }}
        """
    }
}

#AppOpenFunction: {
    _composeConfig: {...}
    #FunctionGoTemplating & {
        step: "app-openfunction"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.openfunction.enabled }}
        ---
        apiVersion: helm.crossplane.io/v1beta1
        kind: Release
        metadata:
          name: {{ $.observed.composite.resource.spec.id }}-app-openfunction
          annotations:
            crossplane.io/external-name: openfunction
            gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-app-openfunction
        spec:
          forProvider:
            chart:
              name: openfunction
              repository: https://openfunction.github.io/charts
              version: \( _composeConfig.version )
            set:
            - name: revisionController.enable
              value: "true"
            namespace: openfunction
          rollbackLimit: 3
          providerConfigRef:
            name: {{ $.observed.composite.resource.spec.id }}
        {{ end }}
        """
    }
}

#AppExternalSecrets: {
    _composeConfig: {...}
    #FunctionGoTemplating & {
        step: "app-external-secrets"
        input: inline: template: """
        {{ if .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled }}
        ---
        apiVersion: helm.crossplane.io/v1beta1
        kind: Release
        metadata:
          name: {{ $.observed.composite.resource.spec.id }}-app-external-secrets
          annotations:
            crossplane.io/external-name: external-secrets
            gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-app-external-secrets
        spec:
          forProvider:
            chart:
              name: external-secrets
              repository: https://charts.external-secrets.io
              version: \( _composeConfig.version )
            set:
            - name: installCRDs
              value: "true"
            namespace: external-secrets
          rollbackLimit: 3
          providerConfigRef:
            name: {{ $.observed.composite.resource.spec.id }}
        {{ end }}
        """
    }
}
