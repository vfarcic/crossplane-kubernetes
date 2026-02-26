oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda suffix: str -> any {
    {
        name = oxr.metadata.name
        annotations = {
            "crossplane.io/external-name" = oxr.metadata.name
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-" + suffix
        }
    }
}

_items = [{
    apiVersion = "container.gcp.m.upbound.io/v1beta1"
    kind = "Cluster"
    metadata = _metadata("cluster")
    spec = {
        forProvider = {
            deletionProtection = False
            location = "us-east1"
            if oxr.spec.parameters.version:
                minMasterVersion = oxr.spec.parameters.version
            initialNodeCount = 1
            removeDefaultNodePool = True
            clusterAutoscaling.autoProvisioningDefaults.management = {
                autoRepair = True
                autoUpgrade = True
            }
        }
        writeConnectionSecretToRef = {
            name = oxr.metadata.name + "-cluster"
        }
    }
}, {
    apiVersion = "container.gcp.m.upbound.io/v1beta1"
    kind = "NodePool"
    metadata = _metadata("nodepool")
    spec.forProvider = {
        if oxr.spec.parameters.version:
            version = oxr.spec.parameters.version
        initialNodeCount = oxr.spec.parameters.minNodeCount
        nodeLocations = ["us-east1-b", "us-east1-c", "us-east1-d"]
        clusterSelector.matchControllerRef = True
        nodeConfig = {
            if oxr.spec.parameters.nodeSize == "small":
                machineType = "e2-standard-2"
            elif oxr.spec.parameters.nodeSize == "medium":
                machineType = "e2-standard-4"
            else:
                machineType = "e2-standard-16"
            oauthScopes = ["https://www.googleapis.com/auth/cloud-platform"]
            taint = [{
                key = "node.cilium.io/agent-not-ready"
                value = "true"
                effect = "NO_EXECUTE"
            }]
        }
        autoscaling = {
            minNodeCount = oxr.spec.parameters.minNodeCount
            maxNodeCount = 10
        }
        management = {
            autoRepair = True
            autoUpgrade = True
        }
    }
}, {
    apiVersion = "protection.crossplane.io/v1beta1"
    kind = "Usage"
    metadata = {
        name = oxr.metadata.name + "-cluster-helm-usage"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "crossplane.io/external-name" = oxr.metadata.name + "-cluster-helm-usage"
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-cluster-helm-usage"
        }
    }
    spec = {
        of = {
            apiVersion = "container.gcp.m.upbound.io/v1beta1"
            kind = "Cluster"
            resourceRef.name = oxr.metadata.name
        }
        by = {
            apiVersion = "helm.m.crossplane.io/v1beta1"
            kind = "ProviderConfig"
            resourceRef.name = oxr.metadata.name
        }
    }
}, {
    apiVersion = "protection.crossplane.io/v1beta1"
    kind = "Usage"
    metadata = {
        name = oxr.metadata.name + "-cluster-kubernetes-usage"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "crossplane.io/external-name" = oxr.metadata.name + "-cluster-kubernetes-usage"
            "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-cluster-kubernetes-usage"
        }
    }
    spec = {
        of = {
            apiVersion = "container.gcp.m.upbound.io/v1beta1"
            kind = "Cluster"
            resourceRef.name = oxr.metadata.name
        }
        by = {
            apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
            kind = "ProviderConfig"
            resourceRef.name = oxr.metadata.name
        }
    }
}, {
    **oxr
    status.clusterName = oxr.metadata.name
    if oxr.metadata.name + "-cluster" in ocds:
        status.controlPlaneStatus = ocds[oxr.metadata.name + "-cluster"].Resource.status.conditions[0].reason
        status.field1 = ocds[oxr.metadata.name + "-cluster"].Resource.status.atProvider.clusterIpv4Cidr
    if oxr.metadata.name + "-nodepool" in ocds:
        status.nodePoolStatus = ocds[oxr.metadata.name + "-nodepool"].Resource.status.conditions[0].reason
}]

_gpu_node_size = oxr.spec.parameters?.gpu?.nodeSize or "small"

if oxr.spec.parameters?.gpu?.enabled:
    _items += [{
        apiVersion = "container.gcp.m.upbound.io/v1beta1"
        kind = "NodePool"
        metadata = {
            name = oxr.metadata.name + "-gpu"
            annotations = {
                "crossplane.io/external-name" = oxr.metadata.name + "-gpu"
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-gpu"
            }
        }
        spec.forProvider = {
            if oxr.spec.parameters.version:
                version = oxr.spec.parameters.version
            clusterSelector.matchControllerRef = True
            nodeLocations = ["us-east1-c"]
            initialNodeCount = oxr.spec.parameters?.gpu?.minNodeCount or 1
            nodeConfig = {
                if _gpu_node_size == "small":
                    machineType = "n1-standard-4"
                    guestAccelerator = [{
                        type = "nvidia-tesla-t4"
                        count = 1
                    }]
                elif _gpu_node_size == "medium":
                    machineType = "a2-highgpu-4g"
                    guestAccelerator = [{
                        type = "nvidia-tesla-a100"
                        count = 4
                    }]
                else:
                    machineType = "a2-highgpu-8g"
                    guestAccelerator = [{
                        type = "nvidia-tesla-a100"
                        count = 8
                    }]
                oauthScopes = ["https://www.googleapis.com/auth/cloud-platform"]
                labels = {
                    gpu = "true"
                }
            }
            autoscaling = {
                minNodeCount = oxr.spec.parameters?.gpu?.minNodeCount or 1
                maxNodeCount = oxr.spec.parameters?.gpu?.maxNodeCount or 10
            }
            management = {
                autoRepair = True
                autoUpgrade = True
            }
        }
    }]

items = _items
