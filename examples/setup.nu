#!/usr/bin/env nu

touch examples/.env

kind create cluster

let hyperscaler = [aws]
    | input list $"(ansi green_bold)Which Hyperscaler do you want to use?(ansi yellow_bold)"
open examples/settings.yaml
    | upsert hyperscaler $hyperscaler
    | save examples/settings.yaml --force

ansi reset

(
    helm upgrade --install crossplane crossplane
        --repo https://charts.crossplane.io/stable
        --set args='{"--enable-usages"}'
        --namespace crossplane-system --create-namespace --wait
)

kubectl apply --filename config.yaml

(
    kubectl apply
        --filename providers/provider-kubernetes-incluster.yaml
)

(
    kubectl apply
        --filename providers/provider-helm-incluster.yaml
)

print $"(ansi yellow_bold)Waiting for Crossplane providers to be deployed...(ansi reset)"

sleep 60sec

(
    kubectl wait
        --for=condition=healthy provider.pkg.crossplane.io --all
        --timeout 5m
)

if AWS_ACCESS_KEY_ID not-in $env {
    let value = input $"(ansi green_bold)Enter AWS Access Key ID: (ansi reset)"
    $env.AWS_ACCESS_KEY_ID = $value
}
$"export AWS_ACCESS_KEY_ID=($env.AWS_ACCESS_KEY_ID)\n"
    | save --append examples/.env

if AWS_SECRET_ACCESS_KEY not-in $env {
    let value = input $"(ansi green_bold)Enter AWS Secret Access Key: (ansi reset)"
    $env.AWS_SECRET_ACCESS_KEY = $value
}
$"export AWS_SECRET_ACCESS_KEY=($env.AWS_SECRET_ACCESS_KEY)\n"
    | save --append examples/.env

$"[default]
aws_access_key_id = ($env.AWS_ACCESS_KEY_ID)
aws_secret_access_key = ($env.AWS_SECRET_ACCESS_KEY)
" | save examples/aws-creds.conf --force

(
    kubectl --namespace crossplane-system
        create secret generic aws-creds
        --from-file creds=./examples/aws-creds.conf
)

(
    kubectl apply
        --filename $"providers/provider-config-($hyperscaler).yaml"
)

kubectl create namespace a-team

mut github_user = ""
if GITHUB_USER in $env {
    $github_user = $env.GITHUB_USER
} else {
    let value = input (
        $"(ansi green_bold)Enter GitHub username or organization: (ansi reset)"
    )
    $github_user = $value
}
open examples/settings.yaml
    | upsert github.user $github_user
    | save examples/settings.yaml --force

(
    gh repo create $"($github_user)/crossplane-kubernetes-gitops"
        --public
)

open examples/aws-eks-full.yaml
    | upsert spec.parameters.apps.argocd.repoURL $"https://github.com/($github_user)/crossplane-kubernetes-gitops"
    | save examples/aws-eks-full.yaml --force
