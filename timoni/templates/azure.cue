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
			{ #AppDapr & { _version: _config.versions.dapr } },
			{ #AppTraefik & { _version: _config.versions.traefik } },
			{ #AppDynatrace & { _version: _config.versions.dynatrace } },
			{ #AppExternalSecrets & { _version: _config.versions.externalSecrets } },
			{ #AzureExternalSecretsStore },
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
		set: [
			{ name: "aksbyocni.enabled", value: "true" },
			{ name: "nodeinit.enabled", value: "true" },
        	{ name: "authentication.mutual.spire.enabled", value: "true" },
        	{ name: "authentication.mutual.spire.install.enabled", value: "true" },
		]
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

#AzureExternalSecretsStore: {
    _name:                  "azure"
    _id:                    "{{ $.observed.composite.resource.spec.id }}"
    _credsName:             "{{ $.observed.composite.resource.spec.parameters.creds.name }}"
    _azureVaultUrl:         "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.azureVaultUrl }}"
    _credsNamespace:        "{{ $.observed.composite.resource.spec.parameters.creds.namespace }}"
    #FunctionGoTemplating & {
        step: "secret-store"
        input: inline: template: """
        {{ if and .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled .observed.composite.resource.spec.parameters.apps.externalSecrets.store .observed.composite.resource.spec.parameters.apps.externalSecrets.azureVaultUrl }}
        ---
        apiVersion: kubernetes.crossplane.io/v1alpha2
        kind: Object
        metadata:
          name: \( _id )-secret-store
          annotations:
            crossplane.io/external-name: \( _name )
            gotemplating.fn.crossplane.io/composition-resource-name: \( _id )-secret-store
        spec:
          forProvider:
            manifest:
              apiVersion: external-secrets.io/v1beta1
              kind: ClusterSecretStore
              metadata:
                name: \( _name )
              spec:
                provider:
                  azurekv:
                    authType: ManagedIdentity
                    vaultUrl: \( _azureVaultUrl )
          providerConfigRef:
            name: \( _id )
        {{ end }}
        """
    }
}