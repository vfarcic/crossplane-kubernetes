package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
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
		patchSets: _config.patchSets
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
			#AppCrossplane,
			#ProviderConfigKubernetesLocal,
			#AppNsProduction,
			#AppNsDev,
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
			#AppCrossplaneConfig & { _composeConfig:
				name: "config-app"
				base: spec: forProvider: manifest: spec: package: _config.packages.configApp
			},
			#AppCrossplaneConfig & { _composeConfig:
				name: "config-sql"
				base: spec: forProvider: manifest: spec: package: _config.packages.configSql
			},
			#ProviderConfig & { _composeConfig:
				name: "aws"
			},
		]
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
			string: fmt: "%s-controlplane"
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
            string: fmt: "%s-cluster"
		}]
	}, {
      	fromFieldPath: "spec.claimRef.namespace"
        toFieldPath: "spec.writeConnectionSecretToRef.namespace"
	}]
    connectionDetails: [{
      	fromConnectionSecretKey: "kubeconfig"
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
        	string: fmt: "%s-nodegroup"
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

#AwsIam: crossplane.#ComposedTemplate & {
    _config:    crossplane.#ComposedTemplate
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
        	string: fmt: "%s-" + _config.name
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.labels.role"
      	transforms: [{
      		type: "string"
        	string: fmt: "%s-" + _config.name
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

#AwsIamAttachmentControlPlaneRole: crossplane.#ComposedTemplate & {
	_config:    crossplane.#ComposedTemplate
	name: "iamattachment-" + _config.name
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
        	string: fmt: "%s-" + _config.name
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.roleSelector.matchLabels.role"
      	transforms: [{
      		type: "string"
        	string: fmt: "%s-controlplane"
		}]
	}]
}

#AwsIamAttachmentNodeGroup: crossplane.#ComposedTemplate & {
	_config:    crossplane.#ComposedTemplate
	name: "iamattachment-" + _config.name
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
        	string: fmt: "%s-" + _config.name
		}]
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.roleSelector.matchLabels.role"
      	transforms: [{
      		type: "string"
        	string: fmt: "%s-nodegroup"
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
      	toFieldPath: "spec.forProvider.groupName"
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

#AwsSubnet: crossplane.#ComposedTemplate & {
	_config:    crossplane.#ComposedTemplate
  	name: "subnet-nodepool-" + _config.name
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
			string: fmt: "%s-" + _config.name
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

#AwsRouteTableAssociation: crossplane.#ComposedTemplate & {
	_config:    crossplane.#ComposedTemplate
	name: "routeTableAssociation" + _config.name
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
        	string: fmt: "%s-" + _config.name
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
        	string: fmt: "%s-ebs"
		}]
	}]
}

#ProviderConfigAws: crossplane.#ComposedTemplate & {
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
            }
        }]
    }, {
        fromFieldPath: "spec.id"
        toFieldPath: "spec.providerConfigRef.name"
    }]
}