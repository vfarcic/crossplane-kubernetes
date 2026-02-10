apiVersion = "meta.pkg.crossplane.io/v1"
kind = "Configuration"
metadata = {
    name = "dot-kubernetes"
    annotations = {
        "meta.crossplane.io/maintainer" = "Viktor Farcic (@vfarcic)"
        "meta.crossplane.io/source" = "github.com/vfarcic/crossplane-kubernetes"
        "meta.crossplane.io/license" = "MIT"
        "meta.crossplane.io/description" = "Fully operational Kubernetes clusters in AWS (EKS), Google Cloud Platform (GKE), and Azure (AKS)"
        "meta.crossplane.io/readme" = "A Configuration package that defines a Cluster type that can be used to create and provision fully operational Kubernetes clusters in AWS (EKS), Google Cloud Platform (GKE), and Azure (AKS)."
    }
}
spec = {
    crossplane.version = ">=v2.3.0"
    dependsOn = [{
        provider = "xpkg.crossplane.io/crossplane-contrib/provider-aws-eks"
        version = ">=v2.3.0"
    }, {
        provider = "xpkg.crossplane.io/crossplane-contrib/provider-aws-iam"
        version = ">=v2.3.0"
    }, {
        provider = "xpkg.crossplane.io/crossplane-contrib/provider-aws-ec2"
        version = ">=v2.3.0"
    }, {
        provider = "xpkg.crossplane.io/crossplane-contrib/provider-azure-containerservice"
        version = ">=v2.3.0"
    }, {
        provider = "xpkg.crossplane.io/crossplane-contrib/provider-gcp-container"
        version = ">=v2.3.0"
    }, {
        function = "xpkg.crossplane.io/crossplane-contrib/function-auto-ready"
        version = ">=v0.2.1"
    }, {
        function = "xpkg.crossplane.io/crossplane-contrib/function-kcl"
        version = ">=v0.10.3"
    # }, {
    #     function = "xpkg.crossplane.io/crossplane-contrib/provider-helm"
    #     version = ">=v0.14.0"
    # }, {
    #     function = "xpkg.crossplane.io/crossplane-contrib/provider-kubernetes"
    #     version = ">=v0.11.0"
    }]
}
