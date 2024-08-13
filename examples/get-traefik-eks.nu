#!/usr/bin/env nu

mut ingress_hostname = ""; loop {
    let value = (
        kubectl --kubeconfig kubeconfig.yaml --namespace traefik
            get service traefik --output json
    )   | from json
        | get status.loadBalancer.ingress.0.hostname
    if $value != "" {
        $ingress_hostname = $value
        break
    }
    print "Waiting for Ingress Service host..."
    sleep 10sec
}

mut ingress_ip = ""; loop {
    let value = dig +short $ingress_hostname | head -n 1
    if $value != "" {
        $ingress_ip = $value
        break
    }
    print "Waiting for Ingress Service IP..."
    sleep 10sec
}

open examples/aws-eks-full.yaml
    | upsert spec.parameters.apps.argocd.host $"argocd.($ingress_ip).nip.io"
    | save examples/aws-eks-full.yaml --force
    
print $ingress_ip