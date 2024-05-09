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

items = [{
    apiVersion = "container.gcp.upbound.io/v1beta1"
    kind = "Cluster"
    metadata = _metadata("cluster")
    spec = {
        forProvider = {
            deletionProtection = False
            location = "us-east1"
            minMasterVersion = oxr.spec.parameters.version
            initialNodeCount = 1
            removeDefaultNodePool = True
            clusterAutoscaling = [{
                autoProvisioningDefaults = [{
                    management = [{
                        autoRepair = True
                        autoUpgrade = True
                    }]
                }]
            }]
        }
        writeConnectionSecretToRef = {
            name = oxr.spec.id + "-cluster"
            namespace = oxr.spec.claimRef.namespace
        }
    }
}, {
    apiVersion = "container.gcp.upbound.io/v1beta1"
    kind = "NodePool"
    metadata = _metadata("nodepool")
    spec.forProvider = {
        version = oxr.spec.parameters.version
        initialNodeCount = oxr.spec.parameters.minNodeCount
        nodeLocations = ["us-east1-b", "us-east1-c", "us-east1-d"]
        clusterSelector.matchControllerRef = True
        nodeConfig = [{
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
        }]
        autoscaling = [{
            minNodeCount = oxr.spec.parameters.minNodeCount
            maxNodeCount = 10
        }]
        management = [{ autoRepair = True, autoUpgrade = True }]
    }
}, {
    **oxr
    status.clusterName = oxr.spec.id
    if oxr.spec.id + "-cluster" in ocds:
        status.controlPlaneStatus = ocds[oxr.spec.id + "-cluster"].Resource.status.conditions[0].reason
        status.field1 = ocds[oxr.spec.id + "-cluster"].Resource.status.atProvider.clusterIpv4Cidr
    if oxr.spec.id + "-nodepool" in ocds:
        status.nodePoolStatus = ocds[oxr.spec.id + "-nodepool"].Resource.status.conditions[0].reason
}]
