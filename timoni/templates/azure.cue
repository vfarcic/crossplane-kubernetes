package templates

import (
	crossplane "apiextensions.crossplane.io/composition/v1"
)

#Azure: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-azure-official"
		labels: {
			"cluster": "aks"
			"provider": "azure-official"
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
					#AzureResourceGroup,
					#AzureKubernetesCluster,
					#ProviderConfigHelmLocal,
					#AppCrossplane & { base: spec: forProvider: chart: version: _config.versions.crossplane },
					#AzureCilium & { base: spec: forProvider: chart: version: _config.versions.cilium },
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
						name: "azure"
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
