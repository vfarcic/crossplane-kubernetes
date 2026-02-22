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
    apiVersion = "network.m.upcloud.com/v1alpha1"
    kind = "Network"
    metadata = _metadata("network")
    spec.forProvider = {
        name = oxr.metadata.name
        zone = "de-fra1"
        ipNetwork = [{
            address = "172.16.1.0/24"
            dhcp = True
            family = "IPv4"
        }]
    }
}, {
    apiVersion = "uks.m.upcloud.com/v1alpha1"
    kind = "KubernetesCluster"
    metadata = _metadata("cluster")
    spec = {
        forProvider = {
            name = oxr.metadata.name
            zone = "de-fra1"
            if oxr.spec.parameters.nodeSize == "small":
                plan = "dev-md"
            else:
                plan = "prod-md"
            if oxr.spec.parameters.version:
                version = oxr.spec.parameters.version
            controlPlaneIpFilter = ["0.0.0.0/0"]
            labels = {}
            networkSelector.matchControllerRef = True
            privateNodeGroups = True
        }
        writeConnectionSecretToRef = {
            name = oxr.metadata.name + "-cluster"
        }
    }
}, {
    apiVersion = "uks.m.upcloud.com/v1alpha1"
    kind = "KubernetesNodeGroup"
    metadata = _metadata("nodegroup")
    spec.forProvider = {
        clusterSelector.matchControllerRef = True
        nodeCount = oxr.spec.parameters.minNodeCount
        if oxr.spec.parameters.nodeSize == "small":
            plan = "2xCPU-4GB"
        elif oxr.spec.parameters.nodeSize == "medium":
            plan = "4xCPU-8GB"
        else:
            plan = "8xCPU-32GB"
    }
}, {
    **oxr
    status.clusterName = oxr.metadata.name
    if oxr.metadata.name + "-cluster" in ocds and ocds[oxr.metadata.name + "-cluster"].Resource?.status?.conditions:
        status.controlPlaneStatus = ocds[oxr.metadata.name + "-cluster"].Resource.status.conditions[0].reason
    if oxr.metadata.name + "-nodegroup" in ocds and ocds[oxr.metadata.name + "-nodegroup"].Resource?.status?.conditions:
        status.nodePoolStatus = ocds[oxr.metadata.name + "-nodegroup"].Resource.status.conditions[0].reason
}]

_gpu_node_size = oxr.spec.parameters?.gpu?.nodeSize or "small"

if oxr.spec.parameters?.gpu?.enabled:
    _items += [{
        apiVersion = "uks.m.upcloud.com/v1alpha1"
        kind = "KubernetesNodeGroup"
        metadata = {
            name = oxr.metadata.name + "-gpu"
            annotations = {
                "crossplane.io/external-name" = oxr.metadata.name + "-gpu"
                "krm.kcl.dev/composition-resource-name" = oxr.metadata.name + "-gpu"
            }
        }
        spec.forProvider = {
            clusterSelector.matchControllerRef = True
            nodeCount = oxr.spec.parameters?.gpu?.minNodeCount or 1
            if _gpu_node_size == "small":
                plan = "GPU-8xCPU-64GB-1xL40S"
            labels = {
                gpu = "true"
            }
            taint = [{
                key = "nvidia.com/gpu"
                value = "true"
                effect = "NoSchedule"
            }]
        }
    }]

items = _items
