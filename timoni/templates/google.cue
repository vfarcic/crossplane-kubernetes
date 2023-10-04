package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
)

#Google: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-google-official"
		labels: {
			"cluster": "gke"
			"provider": "google-official"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		patchSets: _config.patchSets
		resources: [
			#GoogleCluster,
			#GoogleNodePool,
			#GoogleProviderConfigHelmLocal,
			#AppCrossplane,
			#AppCilium,
			#GoogleProviderConfigKubernetesLocal,
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
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#GoogleCluster: {
	name: "gkecluster"
	base: {
		apiVersion: "container.gcp.upbound.io/v1beta1"
		kind: "Cluster"
		spec: {
			forProvider: {
				location: "us-east1"
				initialClusterVersion: "latest"
				initialNodeCount: 1
				removeDefaultNodePool: true
				management: [{
					autoRepair: true
					autoUpgrade: true
				}]
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
	}, {
		fromFieldPath: "spec.parameters.version"
		toFieldPath: "spec.forProvider.minMasterVersion"
	}, {
		type: "ToCompositeFieldPath"
		fromFieldPath: "metadata.name"
		toFieldPath: "status.clusterName"
	}, {
		type: "ToCompositeFieldPath"
		fromFieldPath: "status.message"
		toFieldPath: "status.controlPlaneStatus"
	}, {
		type: "ToCompositeFieldPath"
		fromFieldPath: "status.atProvider.clusterIpv4Cidr"
		toFieldPath: "status.field1"
	}]
	connectionDetails: [{
		fromConnectionSecretKey: "kubeconfig"
	}, {
		fromConnectionSecretKey: "kubeconfig"
		name: "value"
	}]
}

#GoogleNodePool: {
	name: "nodepool"
    base: {
		apiVersion: "container.gcp.upbound.io/v1beta1"
      	kind: "NodePool"
      	spec: {
			forProvider: {
				locations: [{
					"us-east1-b"
				}, {
					"us-east1-c"
				}, {
					"us-east1-d"
				}]
				clusterSelector: {
					matchControllerRef: true
				}
				nodeConfig: [{
					oauthScopes: [{
						"https://www.googleapis.com/auth/cloud-platform"
					}]
					taint: [{
						key: "node.cilium.io/agent-not-ready"
						value: "true"
						effect: "NO_EXECUTE"
					}]
				}]
				autoscaling: [{
					enabled: true
					maxNodeCount: 3
				}]
				management: [{
					autoRepair: true
					autoUpgrade: true
				}]
			}
		}
	}
    patches: [{
		fromFieldPath: "spec.id"
        toFieldPath: "metadata.name"
	}, {
      	fromFieldPath: "spec.writeConnectionSecretToRef.namespace"
        toFieldPath: "spec.credentials.secretRef.namespace"
	}, {
      	fromFieldPath: "spec.parameters.version"
        toFieldPath: "spec.forProvider.version"
	}, {
      	fromFieldPath: "spec.parameters.minNodeCount"
        toFieldPath: "spec.forProvider.initialNodeCount"
	}, {
      	fromFieldPath: "spec.parameters.minNodeCount"
        toFieldPath: "spec.forProvider.autoscaling[0].minNodeCount"
	}, {
      	fromFieldPath: "spec.parameters.nodeSize"
        toFieldPath: "spec.forProvider.nodeConfig[0].machineType"
        transforms: [{
          	type: "map"
            map: {
				small: "e2-standard-2"
				medium: "e2-standard-4"
				large: "e2-standard-16"
			}
		}]
	}, {
      	type: "ToCompositeFieldPath"
        fromFieldPath: "status.message"
        toFieldPath: "status.nodePoolStatus"
	}]
}

#GoogleProviderConfigLocal: crossplane.#ComposedTemplate & {
	name: string
    base: {
        apiVersion: string
        kind:       "ProviderConfig"
        spec: {
            credentials: {
                secretRef: {
                    key:       "kubeconfig"
                    name:      "kubeconfig"
                    namespace: "crossplane-system"
                }
                source: "Secret"
            }
			identity: {
				type: "GoogleApplicationCredentials"
				source: "Secret"
				secretRef: {
					name:      "gcp-creds"
					namespace: "crossplane-system"
					key:       "creds"
				}
			}
        }
    }
    patches: [{
        fromFieldPath: "spec.id"
        toFieldPath:   "metadata.name"
    }, {
        fromFieldPath: "spec.claimRef.namespace"
        toFieldPath:   "spec.credentials.secretRef.namespace"
    }, {
        fromFieldPath: "spec.id"
        toFieldPath:   "spec.credentials.secretRef.name"
        transforms: [{
            string: fmt: "%s-cluster"
            type: "string"
        }]
    }]
    readinessChecks: [{
        type: "None"
    }]
}

#GoogleProviderConfigHelmLocal: crossplane.#ComposedTemplate & {
    #GoogleProviderConfigLocal & {
        name: "helm"
        base: apiVersion: "helm.crossplane.io/v1beta1"
    }
}

#GoogleProviderConfigKubernetesLocal: crossplane.#ComposedTemplate & {
    #GoogleProviderConfigLocal & {
        name: "kubernetes"
        base: apiVersion: "kubernetes.crossplane.io/v1alpha1"
    }
}