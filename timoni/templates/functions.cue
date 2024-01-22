package templates

#FunctionReady: {
    step: "automatically-detect-ready-composed-resources"
    functionRef: name: "crossplane-contrib-function-auto-ready"
}

#FunctionGoTemplating: {
    functionRef: name: "crossplane-contrib-function-go-templating"
    step: string
    input: {
        apiVersion: "gotemplating.fn.crossplane.io/v1beta1"
        kind: "GoTemplate"
        source: "Inline"
        inline: template: string
    }
}
