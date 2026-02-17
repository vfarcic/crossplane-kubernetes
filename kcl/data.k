root = {
    type = "object"
    description = "Parameters used to customize the cluster"
    properties = {
        version = {
            description = "The Kubernetes version for the cluster."
            type = "string"
        }
        nodeSize = {
            description = "The size of the nodes; small, medium, large."
            type = "string"
            enum = ["small", "medium", "large"]
            default = "small"
        }
        minNodeCount = {
            description = "The minimum number of nodes."
            type = "integer"
            default = 1
        }
        namespaces = {
            description = "List of Namespaces that should be created in the cluster"
            type = "array"
            itemsType = "string"
            defaultArray = "dev,production"
        }
    }
    required = ["nodeSize"]
}


appCrossplane = {
    type = "object"
    description = "Install Crossplane"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}

appArgocd = {
    type = "object"
    description = "Install Argo CD"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
        host = {
            type = "string"
            default = "acme.com"
        }
        repoURL = {
            type = "string"
            default = "https://github.com/vfarcic/SOMETHING"
        }
        destinationNamespace = {
            type = "string"
            default = "argo-cd"
        }
        sourcePath = {
            type = "string"
            default = "."
        }
    }
    required = []
}

appOpenfunction = {
    type = "object"
    description = "Install OpenFunction"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}

appDapr = {
    type = "object"
    description = "Install Dapr. Do not enable it if OpenFunction is enabled since it comes with Dapr."
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}

appTraefik = {
    type = "object"
    description = "Install Traefik."
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}


appExternalSecrets = {
    type = "object"
    description = "Install External Secrets Operator (ESO)"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
        store = {
            type = "boolean"
            description = "Whether to create secret store. If `true`, `creds` field needs to be set as well."
        }
        googleCredentialsKey = {
            type = "string"
            description = "The key with Google credentials in the secret. Works only with clusters in Google Cloud."
        }
        awsAccessKeyIDKey = {
            type = "string"
            default = "accessKeyID"
            description = "The key with Access Key ID in the secret. Works only with clusters in AWS."
        }
        awsSecretAccessKeyKey = {
            type = "string"
            default = "secretAccessKey"
            description = "The key with Secret Access Key in the secret. Works only with clusters in AWS."
        }
        azureVaultUrl = {
            type = "string"
            description = "The URL of Azure Vault. Works only with clusters in Azure."
        }
    }
    required = []
}

appExternalSecretsSecrets = {
    type = "array"
    description = "List of secrets to be created from the secret store. The `store` parameter must be set to `true` for this feature to work."
    properties = {
        fromSecret = {
            type = "string"
            description = "The name or the key of secret in the external secret store"
        }
        toSecret = {
            type = "string"
            description = "The name of the secret"
        }
        toNamespace = {
            type = "string"
            description = "The namespace of the secret"
        }
        type = {
            type = "string"
            description = "The type of the secret"
            default = "Opaque"
        }
    }
    required = ["fromSecret", "toSecret", "toNamespace"]
}

gpu = {
    type = "object"
    description = "GPU node pool configuration for AI/ML workloads"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
        nodeSize = {
            description = "The size of the GPU nodes; small, medium, large."
            type = "string"
            enum = ["small", "medium", "large"]
            default = "small"
        }
    }
    required = []
}

appNvidia = {
    type = "object"
    description = "Install NVIDIA GPU Operator for GPU driver and device plugin management. Required for AWS (EKS) and Azure (AKS). Optional for Google (GKE) where drivers and device plugin are pre-installed."
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}

appVllm = {
    type = "object"
    description = "Install vLLM Production Stack for LLM inference serving"
    properties = {
        enabled = {
            type = "boolean"
            default = False
        }
    }
    required = []
}

creds = {
    type = "object"
    description = "The secret with hyperscaler credentials."
    properties = {
        name = {
            type = "string"
            description = "The name of the secret"
        }
        namespace = {
            type = "string"
            description = "The namespace of the secret"
            default = "crossplane-system"
        }
        keys = {
            description = "The keys in the secret"
            type = "array"
            itemsType = "string"
        }
    }
    required = ["name", "namespace", "keys"]
}