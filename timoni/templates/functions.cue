package templates

#FunctionReady: {
    step: "automatically-detect-ready-composed-resources"
    functionRef: name: "upbound-function-auto-ready"
}

#FunctionLoopNamespaces: {
    step: "namespaces"
    functionRef: name: "vfarcic-crossplane-function-loop"
    input: {
        apiVersion: "pt.fn.crossplane.io/v1beta1"
        kind: "Resources"
        valuesXrPath: "spec.parameters.namespaces"
        namePrefix: "ns-"
        paths: [
            {"spec.forProvider.manifest.metadata.name"},
            {"spec.providerConfigRef.name = spec.id"}]
        resources: [{
            base: {
                apiVersion: "kubernetes.crossplane.io/v1alpha1"
                kind: "Object"
                spec: forProvider: manifest: {
                    apiVersion: "v1"
                    kind: "Namespace"
                }
            }
        }]
    }
}
