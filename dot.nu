#!/usr/bin/env nu

source  scripts/common.nu
source  scripts/kubernetes.nu
source  scripts/crossplane.nu

def main [] {}

def "main setup-demo" [] {

    let provider = main get provider --providers [aws, azure, google]

    main create kubernetes kind --name dot-cp

    main apply crossplane --provider $provider --kubernetes-config true --app-config true

    kubectl create namespace a-team

    main print source

}

def "main destroy-demo" [] {

    main delete crossplane --kind apps.devopstoolkit.live --name silly-demo --namespace a-team

    main delete crossplane --kind clusters.devopstoolkit.ai --name a-team --namespace a-team

    main destroy kubernetes kind --name dot-cp

}