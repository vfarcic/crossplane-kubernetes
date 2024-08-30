import .data

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
                            parameters = {
                                description = data.root.description
                                type = data.root.type
                                properties = _properties(data.root.properties)
                                properties.usage = {
                                    description = data.usage.description
                                    type = data.usage.type
                                    properties = _properties(data.usage.properties)
                                }
                                properties.apps = {
                                    type = "object"
                                    description = "List of apps that should be installed in the cluster"
                                    properties = {
                                        crossplane = {
                                            description = data.appCrossplane.description
                                            type = data.appCrossplane.type
                                            properties = _properties(data.appCrossplane.properties)
                                        }
                                        argocd = {
                                            description = data.appArgocd.description
                                            type = data.appArgocd.type
                                            properties = _properties(data.appArgocd.properties)
                                        }
                                        openfunction = {
                                            description = data.appOpenfunction.description
                                            type = data.appOpenfunction.type
                                            properties = _properties(data.appOpenfunction.properties)
                                        }
                                        dapr = {
                                            description = data.appDapr.description
                                            type = data.appDapr.type
                                            properties = _properties(data.appDapr.properties)
                                        }
                                        traefik = {
                                            description = data.appTraefik.description
                                            type = data.appTraefik.type
                                            properties = _properties(data.appTraefik.properties)
                                        }
                                        dynatrace = {
                                            description = data.appDynatrace.description
                                            type = data.appDynatrace.type
                                            properties = _properties(data.appDynatrace.properties)
                                        }
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
                                                    required = ["fromSecret", "toSecret", "toNamespace"]
                                                }
                                            }
                                        }
                                    }

                                }
                                properties.creds = {
                                    description = data.creds.description
                                    type = data.creds.type
                                    properties = _properties(data.creds.properties)
                                    required = ["name", "namespace", "keys"]
                                }
                                required = ["nodeSize"]
                            }
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
