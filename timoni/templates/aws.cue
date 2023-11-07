package templates

import (
	crossplane "apiextensions.crossplane.io/composition/v1"
)

#Aws: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-aws-official"
		labels: {
			"cluster": "eks"
			"provider": "aws-official"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		mode: "Pipeline"
		pipeline: [{
			step: "patch-and-transform"
			functionRef: {
				name: "function-patch-and-transform"
			}
			input: {
				apiVersion: "pt.fn.crossplane.io/v1beta1"
				kind: "Resources"
				resources: [
					#AwsCluster,
					#AwsClusterAuth,
					#AwsNodeGroup,
					#AwsIamControlPlane,
					#AwsIamNodeGroup,
					#AwsIamAttachmentControlPlane,
					#AwsIamAttachmentService,
					#AwsIamAttachmentWorker,
					#AwsIamAttachmentCni,
					#AwsIamAttachmentRegistry,
					#AwsVpc,
					#AwsSecurityGroup,
					#AwsSecurityGroupRule,
					#AwsSubnet1a,
					#AwsSubnet1b,
					#AwsSubnet1c,
					#AwsGateway,
					#AwsRouteTable,
					#AwsRoute,
					#AwsMainRouteAssociation,
					#AwsRouteTableAssociation1a,
					#AwsRouteTableAssociation1b,
					#AwsRouteTableAssociation1c,
					#AwsAddonEbs,
					#ProviderConfigHelmLocal,
					#AppCrossplane & { base: spec: forProvider: chart: version: _config.versions.crossplane },
					// TODO: kubectl -n kube-system patch daemonset aws-node --type='strategic' -p='{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'
					// TODO: Uncomment
					// #AppHelm & { _config:
					// 	name: "cilium"
					// 	base: spec: forProvider: {
					// 		chart: {
					// 			repository: "https://helm.cilium.io"
					// 			// TODO: Switch to variable
					// 			version: "1.14.2"
					// 		}
					// 		set: [{
					// 			name: "nodeinit.enabled"
					// 			value: "true"
					// 		}, {
					// 			name: "nodeinit.reconfigureKubelet"
					// 			value: "true"
					// 		}, {
					// 			name: "nodeinit.removeCbrBridge"
					// 			value: "true"
					// 		}, {
					// 			name: "cni.binPath"
					// 			value: "/home/kubernetes/bin"
					// 		}, {
					// 			name: "gke.enabled"
					// 			value: "true"
					// 		}, {
					// 			name: "ipam.mode"
					// 			value: "kubernetes"
					// 		}, {
					// 			name: "ipv4NativeRoutingCIDR"
					// 		}]
					// 	}
					// },
					#ProviderConfigKubernetesLocal,
					#ProviderKubernetesSa,
					#ProviderKubernetesCrb,
					#ProviderKubernetesCc,
					#AppCrossplaneProvider & { _composeConfig:
						name: "kubernetes-provider"
						base: spec: forProvider: manifest: spec: package: _config.packages.providerKubernetes
					},
					#AppCrossplaneProvider & { _composeConfig:
						name: "helm-provider"
						base: spec: forProvider: manifest: spec: package: _config.packages.providerHelm
					},
					// #AppCrossplaneConfig & { _composeConfig:
					// 	name: "config-app"
					// 	base: spec: forProvider: manifest: spec: package: _config.packages.configApp
					// },
					#AppCrossplaneConfig & { _composeConfig:
						name: "config-sql"
						base: spec: forProvider: manifest: spec: package: _config.packages.configSql
					},
					#ProviderConfig & { _composeConfig:
						name: "aws"
					},
				]
			}
		} , {
			step: "namespaces"
			functionRef: name: "loop"
			input: {
				apiVersion: "pt.fn.crossplane.io/v1beta1"
				kind: "Resources"
				valuesXrPath: "spec.parameters.namespaces"
				namePrefix: "ns-"
				paths: [
					{"spec.forProvider.manifest.metadata.name"},
					{"spec.providerConfigRef.name = spec.id"}]
				resources: [{
					base: {
						apiVersion: "kubernetes.crossplane.io/v1alpha1"
						kind: "Object"
						spec: forProvider: manifest: {
							apiVersion: "v1"
							kind: "Namespace"
						}
					}
				}]
			}
		}]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#AwsCluster: {
	name: "ekscluster"
	base: {
		apiVersion: "eks.aws.upbound.io/v1beta1"
		kind: "Cluster"
		spec: {
			forProvider: {
				region: "us-east-1"
				version: "1.27"
				roleArnSelector: matchControllerRef: true
				vpcConfig: [{
					endpointPrivateAccess: true
					endpointPublicAccess: true
					subnetIdSelector: matchControllerRef: true
				}]
			}
		}
	}
	patches: [{
		fromFieldPath: "spec.id"
		toFieldPath:   "metadata.name"
	}, {
		fromFieldPath: "spec.parameters.version"
		toFieldPath: "spec.forProvider.version"
	}, {
		fromFieldPath: "spec.id"
		toFieldPath: "spec.forProvider.roleArnSelector.matchLabels.role"
		transforms: [{
			type: "string"
			string: {
				fmt: "%s-controlplane"
				type: "Format"
			}
		}]
	}, {
		type: "ToCompositeFieldPath"
		fromFieldPath: "metadata.name"
		toFieldPath: "status.clusterName"
	}, {
		type: "ToCompositeFieldPath"
		fromFieldPath: "status.conditions[0].reason"
		toFieldPath: "status.controlPlaneStatus"
	}]
}

#AwsClusterAuth: {
  	name: "clusterAuth"
    base: {
		apiVersion: "eks.aws.upbound.io/v1beta1"
		kind: "ClusterAuth"
		spec: {
			forProvider: {
				region: "us-east-1"
				clusterNameSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
      	fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
	}, {
    	fromFieldPath: "spec.id"
        toFieldPath: "spec.writeConnectionSecretToRef.name"
        transforms: [{
          	type: "string"
            string: {
				fmt: "%s-cluster"
				type: "Format"
			}
		}]
	}, {
      	fromFieldPath: "spec.claimRef.namespace"
        toFieldPath: "spec.writeConnectionSecretToRef.namespace"
	}]
    connectionDetails: [{
		type: "FromConnectionSecretKey"
      	fromConnectionSecretKey: "kubeconfig"
		name: "kubeconfig"
	}]
}

#AwsNodeGroup: {
  	name: "eksnodegroup"
    base: {
		apiVersion: "eks.aws.upbound.io/v1beta1"
		kind: "NodeGroup"
		spec: {
			forProvider: {
				region: "us-east-1"
				clusterNameSelector: matchControllerRef: true
				nodeRoleArnSelector: matchControllerRef: true
				subnetIdSelector: matchControllerRef: true
				scalingConfig: [{
					minSize: 1
					maxSize: 10
					desiredSize: 1
				}]
				instanceTypes: [{
					"t3.small"
				}]
				// TODO: Uncomment
				// taint: [{
				// 	key: "node.cilium.io/agent-not-ready"
				// 	value: "true"
				// 	effect: "NO_EXECUTE"
				// }]
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}, {
    	fromFieldPath: "spec.parameters.nodeSize"
      	toFieldPath: "spec.forProvider.instanceTypes[0]"
      	transforms: [{
      		type: "map"
        	map: {
				small: "t3.small"
				medium: "t3.medium"
				large: "t3.large"
			}
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.nodeRoleArnSelector.matchLabels.role"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-nodegroup"
				type: "Format"
			}
		}]
	}, {
    	fromFieldPath: "spec.parameters.minNodeCount"
      	toFieldPath: "spec.forProvider.scalingConfig[0].minSize"
	}, {
    	fromFieldPath: "spec.parameters.minNodeCount"
      	toFieldPath: "spec.forProvider.scalingConfig[0].desiredSize"
	}, {
    	type: "ToCompositeFieldPath"
      	fromFieldPath: "status.conditions[0].reason"
      	toFieldPath: "status.nodePoolStatus"
	}]
}

#AwsIam: {
    _config: {...}
    name: "iamrole-" + _config.name
    base: {
        apiVersion: "iam.aws.upbound.io/v1beta1"
        kind: "Role"
        spec: forProvider: assumeRolePolicy: string
    }
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.labels.role"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
    }]
}

#AwsIamControlPlane: #AwsIam & { _config:
	name: "controlplane"
	base: spec: forProvider: assumeRolePolicy: """
		{
		  "Version": "2012-10-17",
		  "Statement": [{
		    "Effect": "Allow",
		    "Principal": {"Service": ["eks.amazonaws.com"]},
		    "Action": ["sts:AssumeRole"]
		  }]
		}
		"""

}

#AwsIamNodeGroup: #AwsIam & { _config:
	name: "nodegroup"
	base: spec: forProvider: assumeRolePolicy: """
		{
		  "Version": "2012-10-17",
		  "Statement": [{
		    "Effect": "Allow",
		    "Principal": {"Service": ["ec2.amazonaws.com"]},
		    "Action": ["sts:AssumeRole"]
		  }]
		}
		"""
}

#AwsIamAttachmentControlPlaneRole: {
	_config: {...}
	name:    "iamattachment-" + _config.name
    base: {
      	apiVersion: "iam.aws.upbound.io/v1beta1"
      	kind:       "RolePolicyAttachment"
      	spec: {
        	forProvider: {
          		policyArn: string
          		roleSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath:   "metadata.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.roleSelector.matchLabels.role"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-controlplane"
				type: "Format"
			}
		}]
	}]
}

#AwsIamAttachmentNodeGroup: {
	_config: {...}
	name:    "iamattachment-" + _config.name
    base: {
      	apiVersion: "iam.aws.upbound.io/v1beta1"
      	kind: "RolePolicyAttachment"
      	spec: {
        	forProvider: {
          		policyArn: string
          		roleSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.roleSelector.matchLabels.role"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-nodegroup"
				type: "Format"
			}
		}]
	}]
}

#AwsIamAttachmentControlPlane: #AwsIamAttachmentControlPlaneRole & { _config:
	name: "controlplane"
	base: spec: forProvider: policyArn: "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#AwsIamAttachmentService: #AwsIamAttachmentControlPlaneRole & { _config:
	name: "service"
	base: spec: forProvider: policyArn: "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

#AwsIamAttachmentWorker: #AwsIamAttachmentNodeGroup & { _config:
	name: "worker"
	base: spec: forProvider: policyArn: "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

#AwsIamAttachmentCni: #AwsIamAttachmentNodeGroup & { _config:
	name: "cni"
	base: spec: forProvider: policyArn: "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#AwsIamAttachmentRegistry: #AwsIamAttachmentNodeGroup & { _config:
	name: "registry"
	base: spec: forProvider: policyArn: "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#AwsVpc: {
  	name: "vpc-nodepool"
    base: {
    	apiVersion: "ec2.aws.upbound.io/v1beta1"
    	kind: "VPC"
    	spec: {
    	  	forProvider: {
    	    	region: "us-east-1"
    	    	cidrBlock: "10.0.0.0/16"
    	    	enableDnsSupport: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsSecurityGroup: {
	name: "sg-nodepool"
    base: {
    	apiVersion: "ec2.aws.upbound.io/v1beta1"
    	kind: "SecurityGroup"
    	spec: {
    		forProvider: {
    		  	description: "Cluster communication with worker nodes"
    		  	region: "us-east-1"
    		  	vpcIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.name"
	}]
    readinessChecks: [{
    	type: "None"
	}]
}

#AwsSecurityGroupRule: {
  	name: "securityGroupRule"
    base: {
    	apiVersion: "ec2.aws.upbound.io/v1beta1"
    	kind: "SecurityGroupRule"
    	spec: {
    		forProvider: {
    			description: "I am too lazy to write descriptions"
    			region: "us-east-1"
    			type: "egress"
    			fromPort: 0
    			toPort: 0
    			protocol: "-1"
    			cidrBlocks: [{"0.0.0.0/0"}]
    			securityGroupIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsSubnet: {
	_config: {...}
  	name:    "subnet-nodepool-" + _config.name
    base: {
    	apiVersion: "ec2.aws.upbound.io/v1beta1"
    	kind: "Subnet"
    	metadata: {
    	  	labels: {
    	    	zone: "us-east-" + _config.name
    	    	access: "public"
			}
		}
    	spec: {
    		forProvider: {
    			region: "us-east-1"
    			availabilityZone: "us-east-" + _config.name
    			cidrBlock: string
    			vpcIdSelector: matchControllerRef: true
    			mapPublicIpOnLaunch: true
    			tags: "kubernetes.io/role/elb": "1"
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
      	transforms: [{
      		type: "string"
			string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
	}]
}

#AwsSubnet1a: #AwsSubnet & { _config:
	name: "1a"
	base: spec: forProvider: cidrBlock: "10.0.0.0/24"
}

#AwsSubnet1b: #AwsSubnet & { _config:
	name: "1b"
	base: spec: forProvider: cidrBlock: "10.0.1.0/24"
}

#AwsSubnet1c: #AwsSubnet & { _config:
	name: "1c"
	base: spec: forProvider: cidrBlock: "10.0.2.0/24"
}

#AwsGateway: {
  	name: "gateway"
    base: {
    	apiVersion: "ec2.aws.upbound.io/v1beta1"
    	kind: "InternetGateway"
    	spec: {
    		forProvider: {
    			region: "us-east-1"
    			vpcIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsRouteTable: {
  	name: "routeTable"
    base: {
      	apiVersion: "ec2.aws.upbound.io/v1beta1"
      	kind: "RouteTable"
      	spec: {
        	forProvider: {
          		region: "us-east-1"
          		vpcIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsRoute: {
  	name: "route"
    base: {
      	apiVersion: "ec2.aws.upbound.io/v1beta1"
      	kind: "Route"
      	spec: {
        	forProvider: {
          		region: "us-east-1"
          		routeTableIdSelector: matchControllerRef: true
          		destinationCidrBlock: "0.0.0.0/0"
          		gatewayIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsMainRouteAssociation: {
  	name: "mainRouteTableAssociation"
    base: {
      	apiVersion: "ec2.aws.upbound.io/v1beta1"
      	kind: "MainRouteTableAssociation"
      	spec: {
        	forProvider: {
          		region: "us-east-1"
          		routeTableIdSelector: matchControllerRef: true
          		vpcIdSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AwsRouteTableAssociation: {
	_config: {...}
	name:    "routeTableAssociation" + _config.name
    base: {
      	apiVersion: "ec2.aws.upbound.io/v1beta1"
      	kind: "RouteTableAssociation"
      	spec: {
        	forProvider: {
          		region: "us-east-1"
          		routeTableIdSelector: matchControllerRef: true
          		subnetIdSelector: {
					matchControllerRef: true
            		matchLabels: {
              			zone: "us-east-" + _config.name
              			access: "public"
					}
				}
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-" + _config.name
				type: "Format"
			}
		}]
	}]
}

#AwsRouteTableAssociation1a: #AwsRouteTableAssociation & { _config:
	name: "1a"
}

#AwsRouteTableAssociation1b: #AwsRouteTableAssociation & { _config:
	name: "1b"
}

#AwsRouteTableAssociation1c: #AwsRouteTableAssociation & { _config:
	name: "1c"
}

#AwsAddonEbs: {
  	name: "addonEbs"
    base: {
      	apiVersion: "eks.aws.upbound.io/v1beta1"
      	kind: "Addon"
      	metadata: name: "aws-ebs-csi-driver"
      	spec: {
        	forProvider: {
          		addonName: "aws-ebs-csi-driver"
          		region: "us-east-1"
          		clusterNameSelector: matchControllerRef: true
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-ebs"
				type: "Format"
			}
		}]
	}]
}

#ProviderConfigAws: {
    name: "aws-pc"
    base: {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "Object"
        spec: {
            forProvider: {
                manifest: {
                    apiVersion: "aws.upbound.io/v1beta1"
                    kind: "ProviderConfig"
                    metadata: name: "default"
                    spec: {
						credentials: {
                			source: "Secret"
                			secretRef: {
                  				namespace: "crossplane-system"
                  				name: "aws-creds"
                  				key: "creds"
							}
						}
                    }
                }
            }
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
        transforms: [{
            type: "string"
            string: {
                fmt: "%s-aws-pc"
				type: "Format"
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}
