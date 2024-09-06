import .data

_data = lambda _data: any -> any {
    {
        description = _data.description
        type = _data.type
        properties = _properties(_data.properties)
        required = _data.required
    }
}

_properties = lambda properties: any -> any {
    {
        key = {
            description = value["description"]
            type = value["type"]
            if "defaultArray" in value:
                default = value["defaultArray"].rsplit(",", -1)
            else:
                default = value["default"]
            if "itemsType" in value:
                items.type = value["itemsType"]
        } for key, value in properties
    }
}

apiVersion = "apiextensions.crossplane.io/v1"
kind = "CompositeResourceDefinition"
metadata = {
    name = "compositeclusters.devopstoolkitseries.com"
    labels.idp = "true"
}
spec = {
    connectionSecretKeys = ["kubeconfig", "value"]
    defaultCompositionRef = {name = "cluster-aws"}
    group = "devopstoolkitseries.com"
    names = {kind = "CompositeCluster", plural = "compositeclusters"}
    claimNames = {kind = "ClusterClaim", plural = "clusterclaims"}
    versions = [{
        name = "v1alpha1"
        served = True
        referenceable = True
        $schema = {
            openAPIV3Schema = {
                type = "object"
                properties = {
                    spec = {
                        type = "object"
                        properties = {
                            id = {
                                type = "string"
                                description = "ID of this Cluster that other objects can refer."
                            }
                            parameters = _data(data.root)
                            parameters.properties.usage = _data(data.usage)
                            parameters.properties.apps = {
                                type = "object"
                                description = "List of apps that should be installed in the cluster"
                                properties = {
                                    crossplane = _data(data.appCrossplane)
                                    argocd = _data(data.appArgocd)
                                    openfunction = _data(data.appOpenfunction)
                                    dapr = _data(data.appDapr)
                                    traefik = _data(data.appTraefik)
                                    dynatrace = _data(data.appDynatrace)
                                    externalSecrets = {
                                        description = data.appExternalSecrets.description
                                        type = data.appExternalSecrets.type
                                        properties = _properties(data.appExternalSecrets.properties)
                                        properties.secrets = {
                                            description = data.appExternalSecretsSecrets.description
                                            type = data.appExternalSecretsSecrets.type
                                            items = {
                                                type = "object"
                                                properties = _properties(data.appExternalSecretsSecrets.properties)
                                                required = data.appExternalSecretsSecrets.required
                                            }
                                        }
                                    }
                                }

                            }
                            parameters.properties.creds = _data(data.creds)
                        }
                        required = ["id", "parameters"]
                    }
                    status = {
                        type = "object"
                        properties = {
                            clusterName = {
                                description = "The name of the cluster."
                                type = "string"
                            }
                            controlPlaneStatus = {
                                description = "The status of the control plane."
                                type = "string"
                            }
                            nodePoolStatus = {
                                description = "The status of the node pool."
                                type = "string"
                            }
                            field1 = {
                                description = "A placeholder"
                                type = "string"
                            }
                        }
                    }
                }
            }
        }
        additionalPrinterColumns = [{
            name = "clusterName"
            type = "string"
            jsonPath = ".status.clusterName"
        }, {
            name = "controlPlane"
            type = "string"
            jsonPath = ".status.controlPlaneStatus"
        }, {
            name = "nodePool"
            type = "string"
            jsonPath = ".status.nodePoolStatus"
        }]
    }]
}
