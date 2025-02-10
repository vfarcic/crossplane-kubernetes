#!/usr/bin/env nu

do --ignore-errors {

    kubectl --namespace a-team delete --filename examples/aws-eks.yaml

    kubectl delete release a-team-app-traefik

}

mut counter = 999; loop {
    $counter = ( kubectl get managed | detect columns | length )
    if $counter == 0 {
        break
    }
    print $"Waiting for ($counter) resources to be deleted..."
    sleep 10sec
}

kind delete cluster

do --ignore-errors {

    let github_user = open settings.yaml
        | get github.user

    # start $"https://github.com/($github_user)/crossplane-kubernetes-gitops"

#     print $"
#     (ansi green_bold)Delete the repository and press the enter key to continue.(ansi reset)
# "
#     input
    
}
