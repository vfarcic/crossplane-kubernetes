package templates

import (
	crossplane "github.com/crossplane/crossplane/apis/apiextensions/v1"
)

#Civo: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-civo"
		labels: {
			"cluster": "ck"
			"provider": "civo"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		patchSets: _config.patchSets
		resources: [
			#CivoClusterResource,
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#CivoPort: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-civo-port"
		labels: {
			"cluster": "ck-port"
			"provider": "civo"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		patchSets: _config.patchSets
		resources: [
			#CivoClusterResource,
			#ProviderConfigKubernetesLocal,
			#ProviderConfigHelmLocal,
			#ProviderKubernetesSA,
			#ProviderKubernetesCRB,
			#ProviderKubernetesCC,
			#ProviderHelmCC,
			#AppTraefik & {base: spec: forProvider: chart: version: _config.versions.traefik},
			#AppCrossplane & {base: spec: forProvider: chart: version: _config.versions.crossplane},
			#AppCrossplaneProviderKubernetes & {
				base: spec: forProvider: manifest: spec: package: _config.packages.providerKubernetes
			},
			#AppCrossplaneProviderHelm & {
				base: spec: forProvider: manifest: spec: package: _config.packages.providerHelm
			},
			#AppCrossplaneConfigApp & {
				base: spec: forProvider: manifest: spec: package: _config.packages.configApp
			},
			#AppCrossplaneConfigSql & {
				base: spec: forProvider: manifest: spec: package: _config.packages.configSql
			},
			#AppSchemaHeroNs,
			#AppSchemaHeroCr,
			#AppSchemaHeroCrb,
			#AppSchemaHeroService,
			#AppSchemaHeroSecret,
			#AppSchemaHeroSts,
			#AppSchemaHeroCrdDb,
			#AppSchemaHeroCrdTable,
			#AppSchemaHeroCrdMigration,
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#CivoClusterResource: {
	name: "civocluster"
	base: {
		apiVersion: "cluster.civo.crossplane.io/v1alpha1"
		kind: "CivoKubernetes"
		spec: {
			applications: [
				"civo-cluster-autoscaler"
			]
			connectionDetails: {
				connectionSecretNamePrefix: "cluster-civo"
				connectionSecretNamespace: "crossplane-system"
			}
			name: "civocluster"
			pools: [{
				count: 1
				id: "8382e422-dcdd-461f-afb4-2ab67f171c3e"
				size: "g3.k3s.small"
			}]
			providerConfigRef: {
				name: "crossplane-provider-civo"
			}
		}
	}
	connectionDetails: [{
		fromConnectionSecretKey: "kubeconfig"
	}, {
		fromConnectionSecretKey: "kubeconfig"
		value: "value"
	}]
	patches: [{
		fromFieldPath: "spec.id"
		toFieldPath:   "metadata.name"
	}, {
		fromFieldPath: "spec.id"
		toFieldPath: "spec.name"
	}, {
		fromFieldPath: "spec.id"
		toFieldPath: "spec.writeConnectionSecretToRef.name"
		transforms: [{
			string: {
				fmt: "%s-cluster"
			}
			type: "string"
		}]
	}, {
		fromFieldPath: "spec.claimRef.namespace"
		toFieldPath: "spec.writeConnectionSecretToRef.namespace"
	}, {
		fromFieldPath: "spec.parameters.minNodeCount"
		toFieldPath: "spec.pools[0].count"
	}, {
		fromFieldPath: "spec.parameters.nodeSize"
		toFieldPath: "spec.pools[0].size"
		transforms: [{
			map: {
				large: "g3.k3s.xlarge"
				medium: "g3.k3s.medium"
				small: "g3.k3s.small"
			}
			type: "map"
		}]
	}, {
		fromFieldPath: "metadata.name"
		toFieldPath: "status.clusterName"
		type: "ToCompositeFieldPath"
	}, {
		fromFieldPath: "status.message"
		toFieldPath: "status.controlPlaneStatus"
		type: "ToCompositeFieldPath"
	}, {
		fromFieldPath: "status.message"
		toFieldPath: "status.nodePoolStatus"
		type: "ToCompositeFieldPath"
	}]
}