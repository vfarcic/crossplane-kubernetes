oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda suffix: str -> any {
    {
        name = oxr.spec.id
        annotations = {
            "crossplane.io/external-name" = oxr.spec.id
            "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-" + suffix
        }
    }
}

_items = [{
    apiVersion = "azure.m.upbound.io/v1beta1"
    kind = "ResourceGroup"
    metadata = _metadata("resource-group")
    spec = {
        forProvider.location = "eastus"
        initProvider = {}
    }
}, {
    apiVersion = "containerservice.azure.m.upbound.io/v1beta1"
    kind = "KubernetesCluster"
    metadata = _metadata("cluster")
    spec = {
        forProvider: {
            resourceGroupName = oxr.spec.id
            if oxr.spec.parameters.version:
                kubernetesVersion = oxr.spec.parameters.version
            location = "eastus"
            dnsPrefix = "dot"
            defaultNodePool = {
                name = oxr.spec.id
                if oxr.spec.parameters.nodeSize == "small":
                    vmSize = "Standard_D2_v2"
                elif oxr.spec.parameters.nodeSize == "medium":
                    vmSize = "Standard_D3_v2"
                else:
                    vmSize = "Standard_D4_v2"
                minCount = oxr.spec.parameters.minNodeCount
                maxCount = 10
                autoScalingEnabled = True
            }
            identity = {type = "SystemAssigned"}
            networkProfile = {networkPlugin = "none"}
        }
        writeConnectionSecretToRef = {
            name = oxr.spec.id + "-cluster"
        }
    }
# TODO: Uncomment and fix
# }, {
#     **oxr
#     status.clusterName = oxr.spec.id
#     if oxr.spec.id + "-cluster" in ocds:
#         status.controlPlaneStatus = ocds[oxr.spec.id + "-cluster"].Resource.status.conditions[0].reason
#         status.nodePoolStatus = ocds[oxr.spec.id + "-cluster"].Resource.status.conditions[0].reason
}]

_gpu_node_size = oxr.spec.parameters?.gpu?.nodeSize or "small"

if oxr.spec.parameters?.gpu?.enabled:
    _items += [{
        apiVersion = "containerservice.azure.m.upbound.io/v1beta1"
        kind = "KubernetesClusterNodePool"
        metadata = {
            name = oxr.spec.id + "-gpu"
            annotations = {
                "crossplane.io/external-name" = oxr.spec.id + "-gpu"
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-gpu"
            }
        }
        spec = {
            forProvider = {
                kubernetesClusterIdSelector.matchControllerRef = True
                if _gpu_node_size == "small":
                    vmSize = "Standard_NC4as_T4_v3"
                elif _gpu_node_size == "medium":
                    vmSize = "Standard_NC8as_T4_v3"
                else:
                    vmSize = "Standard_NC24ads_A100_v4"
                autoScalingEnabled = True
                minCount = 1
                maxCount = 10
                nodeLabels = {
                    gpu = "true"
                }
                nodeTaints = [
                    "nvidia.com/gpu=true:NoSchedule"
                ]
            }
        }
    }]

items = _items
