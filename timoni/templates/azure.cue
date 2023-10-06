package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
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
		patchSets: _config.patchSets
		resources: [
			#AzureResourceGroup,
			#AzureKubernetesCluster,
			#ProviderConfigHelmLocal,
			#AppCrossplane,
			#AzureCilium,
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
				name: "azure"
			},
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
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
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath: "spec.forProvider.name"
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
      	toFieldPath:   "spec.forProvider.name"
	}, {
    	fromFieldPath: "spec.id"
      	toFieldPath:   "spec.writeConnectionSecretToRef.name"
      	transforms: [{
      		type: "string"
        	string: fmt: "%s-cluster"
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
    	fromConnectionSecretKey: "kubeconfig"
	}, {
    	fromConnectionSecretKey: "kubeconfig"
      	name:                    "value"
	}]
}

#AzureCilium: #AppHelm & { _config:
    name: "cilium"
    base: spec: forProvider: {
        chart: {
            repository: "https://helm.cilium.io"
            version: "1.14.2"
        }
        set: [{
            name: "aksbyocni.enabled"
            value: "true"
        }, {
            name: "nodeinit.enabled"
            value: "true"
        }]
        namespace: "kube-system"
    }
}