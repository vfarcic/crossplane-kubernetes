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
        {{ if .observed.composite.resource.spec.parameters.apps.crossplane }}
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

// TODO: Add OpenFunction
// TODO: Add Secret with container registry creadentials