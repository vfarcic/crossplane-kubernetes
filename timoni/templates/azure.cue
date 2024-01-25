package templates

import (
	crossplane "apiextensions.crossplane.io/composition/v1"
)

#Azure: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-azure"
		labels: {
			"cluster": "aks"
			"provider": "azure"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		mode: "Pipeline"
		pipeline: [
			{
				step: "patch-and-transform"
				functionRef: {
					name: "crossplane-contrib-function-patch-and-transform"
				}
				input: {
					apiVersion: "pt.fn.crossplane.io/v1beta1"
					kind: "Resources"
					resources: [
						#AzureResourceGroup,
						#AzureKubernetesCluster,
						#ProviderConfigHelmLocal,
						#AzureCilium & { base: spec: forProvider: chart: version: _config.versions.cilium },
						#ProviderConfigKubernetesLocal,
						// #ProviderConfig & { _composeConfig: name: "azure" },
					]
				}
			},
			{ #AppCrossplane & { _version: _config.versions.crossplane } },
			{ #AppOpenFunction & { _url: _config.charts.openFunction } },
			{ #AppExternalSecrets & { _version: _config.versions.externalSecrets } },
			{ #AppExternalSecretsStore & { _name: "azure" } },
			{ #AppExternalSecretsSecret & { _name: "azure" } },
			{ #ProviderKubernetesNamespaces },
			{ #Creds },
			{ #FunctionReady },
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#AzureCilium: #AppHelm & { _composeConfig:
	name: "cilium"
	base: spec: forProvider: {
		chart: {
			repository: "https://helm.cilium.io"
			version: string
		}
		set: [{
			name: "aksbyocni.enabled"
			value: "true"
		}, {
			name: "nodeinit.enabled"
			value: "true"
		}]
	}
}

#AzureResourceGroup: {
  	name: "resourcegroup"
    base: {
		apiVersion: "azure.upbound.io/v1beta1"
      	kind: "ResourceGroup"
      	spec: forProvider: location: "eastus"
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath: "metadata.name"
	}]
}

#AzureKubernetesCluster: {
	name: "aks"
    base: {
		apiVersion: "containerservice.azure.upbound.io/v1beta1"
		kind: 		"KubernetesCluster"
      	spec: {
			forProvider: {
				location:          "eastus"
				dnsPrefix: 		   "dot"
				defaultNodePool: [{
					maxCount:          10
					enableAutoScaling: true
					vmSize:            "Standard_D2_v2"
				}]
				identity: [{
					type: "SystemAssigned"
				}]
				networkProfile: [{
					networkPlugin: "none"
				}]
			}
		}
	}
    patches: [{
    	fromFieldPath: "spec.id"
      	toFieldPath:   "metadata.name"
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath:   "spec.writeConnectionSecretToRef.name"
      	transforms: [{
      		type: "string"
        	string: {
				fmt: "%s-cluster"
				type: "Format"
			}
		}]
	}, {
    	fromFieldPath: "spec.claimRef.namespace"
      	toFieldPath:   "spec.writeConnectionSecretToRef.namespace"
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath:   "spec.forProvider.defaultNodePool[0].name"
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath:   "spec.forProvider.resourceGroupName"
	}, {
    	fromFieldPath: "spec.parameters.version"
      	toFieldPath:   "spec.forProvider.kubernetesVersion"
	}, {
    	fromFieldPath: "spec.parameters.minNodeCount"
      	toFieldPath:   "spec.forProvider.defaultNodePool[0].minCount"
	}, {
    	fromFieldPath: "spec.parameters.nodeSize"
      	toFieldPath:   "spec.forProvider.defaultNodePool[0].vmSize"
      	transforms: [{
      		type: "map"
        	map: {
          		small:  "Standard_D2_v2"
          		medium: "Standard_D3_v2"
          		large:  "Standard_D4_v2"
			}
		}]
	}, {
    	type:          "ToCompositeFieldPath"
      	fromFieldPath: "metadata.name"
      	toFieldPath:   "status.clusterName"
	}, {
    	type:          "ToCompositeFieldPath"
      	fromFieldPath: "status.conditions[0].reason"
      	toFieldPath:   "status.controlPlaneStatus"
	}, {
    	type:          "ToCompositeFieldPath"
      	fromFieldPath: "status.conditions[0].reason"
      	toFieldPath:   "status.nodePoolStatus"
	}]
    connectionDetails: [{
		type:                    "FromConnectionSecretKey"
    	fromConnectionSecretKey: "kubeconfig"
		name:                    "kubeconfig"
	}, {
		type:                    "FromConnectionSecretKey"
    	fromConnectionSecretKey: "kubeconfig"
      	name:                    "value"
	}]
}
