package templates

#FunctionReady: {
    step: "automatically-detect-ready-composed-resources"
    functionRef: name: "upbound-function-auto-ready"
}

#FunctionGoTemplating: {
    functionRef: name: "upbound-function-go-templating"
    step: string
    input: {
        apiVersion: "gotemplating.fn.crossplane.io/v1beta1"
        kind: "GoTemplate"
        source: "Inline"
        inline: template: string
    }
}
