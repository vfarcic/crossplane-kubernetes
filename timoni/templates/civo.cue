package templates

import (
	crossplane "apiextensions.crossplane.io/composition/v1"
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
		mode: "Pipeline"
		pipeline: [{
			step: "patch-and-transform"
			functionRef: {
				name: "crossplane-contrib-function-patch-and-transform"
			}
			input: {
				apiVersion: "pt.fn.crossplane.io/v1beta1"
				kind: "Resources"
				resources: [
					#CivoClusterResource,
				]
			}
		}]
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
		type: "FromConnectionSecretKey"
		fromConnectionSecretKey: "kubeconfig"
		name: "kubeconfig"
	}, {
		type: "FromConnectionSecretKey"
		fromConnectionSecretKey: "kubeconfig"
		name: "value"
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
				type: "Format"
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