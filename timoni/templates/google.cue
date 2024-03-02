package templates

import (
	crossplane "apiextensions.crossplane.io/composition/v1"
)

#Google: crossplane.#Composition & {
    _config:    #Config
    apiVersion: #Config.apiVersion
	kind:       "Composition"
	metadata: {
		name: "cluster-google"
		labels: {
			"cluster": "gke"
			"provider": "google"
		}
	}
    spec: {
		compositeTypeRef: _config.compositeTypeRef
		mode: "Pipeline"
		pipeline: [
			{
				step: "patch-and-transform"
				functionRef: name: "crossplane-contrib-function-patch-and-transform"
				input: {
					apiVersion: "pt.fn.crossplane.io/v1beta1"
					kind: "Resources"
					resources: [
						#GoogleCluster,
						#GoogleNodePool,
						#GoogleProviderConfigHelmLocal,
						#GoogleCilium & { base: spec: forProvider: chart: version: _config.versions.cilium },
						#GoogleProviderConfigKubernetesLocal,
					]
				}
			},
			{ #AppCrossplane & { _version: _config.versions.crossplane } },
			{ #AppOpenFunction & { _url: _config.charts.openFunction } },
			{ #AppDapr & { _version: _config.versions.dapr } },
			{ #AppTraefik & { _version: _config.versions.traefik } },
			{ #AppDynatrace & { _version: _config.versions.dynatrace } },
			{ #AppExternalSecrets & { _version: _config.versions.externalSecrets } },
			{ #GoogleExternalSecretsStore },
			{ #AppExternalSecretsSecret & { _name: "google" } },
			{ #ProviderKubernetesNamespaces },
			{ #Creds },
			{ #FunctionReady }
		]
		writeConnectionSecretsToNamespace: "crossplane-system"
    }
}

#GoogleCilium: #AppHelm & { _composeConfig:
	name: "cilium"
	base: spec: forProvider: {
		chart: { repository: "https://helm.cilium.io", version: string }
		set: [
			{ name: "nodeinit.enabled", value: "true"},
			{ name: "nodeinit.reconfigureKubelet", value: "true" },
			{ name: "nodeinit.removeCbrBridge", value: "true" },
			{ name: "cni.binPath", value: "/home/kubernetes/bin" },
			{ name: "gke.enabled", value: "true" },
			{ name: "ipam.mode", value: "kubernetes" },
			{ name: "ipv4NativeRoutingCIDR" },
        	{ name: "authentication.mutual.spire.enabled", value: "true" },
        	{ name: "authentication.mutual.spire.install.enabled", value: "true" },
		]
	}
	patches: [{
		fromFieldPath: "spec.id"
		toFieldPath: "metadata.name"
		transforms: [{
			type: "string"
			string: { fmt: "%s-" + _composeConfig.name, type: "Format" }
		}]},
		{ fromFieldPath: "spec.id", toFieldPath: "spec.providerConfigRef.name" },
		{ fromFieldPath: "status.field1", toFieldPath: "spec.forProvider.set[6].value", type: "FromCompositeFieldPath" }
	]
}

#GoogleCluster: {
	name: "gkecluster"
	base: {
		apiVersion: "container.gcp.upbound.io/v1beta1"
		kind: "Cluster"
		spec: {
			forProvider: {
				location: "us-east1"
				initialNodeCount: 1
				removeDefaultNodePool: true
				clusterAutoscaling: [{
					autoProvisioningDefaults: [{
						management: [{ autoRepair: true, autoUpgrade: true }]
					}]
				}]
			}
		}
	}
	patches: [
		{ fromFieldPath: "spec.id", toFieldPath: "metadata.name" },
		{
			fromFieldPath: "spec.id"
			toFieldPath: "spec.writeConnectionSecretToRef.name"
			transforms: [{
				type: "string"
				string: {
					fmt:  "%s-cluster"
					type: "Format"
				}
			}]
		},
		{ fromFieldPath: "spec.claimRef.namespace", toFieldPath: "spec.writeConnectionSecretToRef.namespace" },
		{ fromFieldPath: "spec.parameters.version", toFieldPath: "spec.forProvider.minMasterVersion" },
		{ type: "ToCompositeFieldPath", fromFieldPath: "metadata.name", toFieldPath: "status.clusterName" },
		{ type: "ToCompositeFieldPath", fromFieldPath: "status.message", toFieldPath: "status.controlPlaneStatus" },
		{ type: "ToCompositeFieldPath", fromFieldPath: "status.atProvider.clusterIpv4Cidr", toFieldPath: "status.field1" }
	]
	connectionDetails: [
		{ type: "FromConnectionSecretKey", fromConnectionSecretKey: "kubeconfig", name: "kubeconfig" },
		{ type: "FromConnectionSecretKey", fromConnectionSecretKey: "kubeconfig", name: "value" }
	]
}

#GoogleNodePool: {
	name: "nodepool"
    base: {
		apiVersion: "container.gcp.upbound.io/v1beta1"
      	kind: "NodePool"
      	spec: {
			forProvider: {
				nodeLocations: [{ "us-east1-b" }, { "us-east1-c" }, { "us-east1-d" }]
				clusterSelector: { matchControllerRef: true }
				nodeConfig: [{
					oauthScopes: [{ "https://www.googleapis.com/auth/cloud-platform" }]
					taint: [{ key: "node.cilium.io/agent-not-ready", value: "true", effect: "NO_EXECUTE" }]
				}]
				autoscaling: [{ maxNodeCount: 3 }]
				management: [{ autoRepair: true, autoUpgrade: true }]
			}
		}
	}
    patches: [
		{ fromFieldPath: "spec.id", toFieldPath: "metadata.name" },
		{ fromFieldPath: "spec.parameters.version", toFieldPath: "spec.forProvider.version" }, 
		{ fromFieldPath: "spec.parameters.minNodeCount", toFieldPath: "spec.forProvider.initialNodeCount" },
		{ fromFieldPath: "spec.parameters.minNodeCount", toFieldPath: "spec.forProvider.autoscaling[0].minNodeCount" }, 
		{
			fromFieldPath: "spec.parameters.nodeSize"
			toFieldPath: "spec.forProvider.nodeConfig[0].machineType"
			transforms: [{
				type: "map"
				map: { small: "e2-standard-2", medium: "e2-standard-4", large: "e2-standard-16" }
			}]},
		{ type: "ToCompositeFieldPath", fromFieldPath: "status.message", toFieldPath: "status.nodePoolStatus" }
	]
}

#GoogleProviderConfigLocal: {
	name: string
    base: {
        apiVersion: string
        kind:       "ProviderConfig"
        spec: {
            credentials: {
                secretRef: { key: "kubeconfig", name: "kubeconfig", namespace: "crossplane-system" }
                source: "Secret"
            }
			identity: {
				type: "GoogleApplicationCredentials"
				source: "Secret"
				secretRef: { name: "gcp-creds", namespace: "crossplane-system", key: "creds" }
			}
        }
    }
    patches: [
		{ fromFieldPath: "spec.id", toFieldPath:   "metadata.name" },
		{ fromFieldPath: "spec.claimRef.namespace", toFieldPath:   "spec.credentials.secretRef.namespace" }, 
		{
			fromFieldPath: "spec.id"
			toFieldPath:   "spec.credentials.secretRef.name"
			transforms: [{
				string: { fmt: "%s-cluster", type: "Format" }
				type: "string"
			}]
    }]
    readinessChecks: [{ type: "None" }]
}

#GoogleProviderConfigHelmLocal: {
    #GoogleProviderConfigLocal & {
        name: "helm"
        base: apiVersion: "helm.crossplane.io/v1beta1"
    }
}

#GoogleProviderConfigKubernetesLocal: {
    #GoogleProviderConfigLocal & {
        name: "kubernetes"
        base: apiVersion: "kubernetes.crossplane.io/v1alpha1"
    }
}

#GoogleExternalSecretsStore: {
    _name:                  "google"
    _id:                    "{{ $.observed.composite.resource.spec.id }}"
    _credsName:             "{{ $.observed.composite.resource.spec.parameters.creds.name }}"
    _googleCredsKey:        "{{ $.observed.composite.resource.spec.parameters.apps.externalSecrets.googleCredentialsKey }}"
    _credsNamespace:        "{{ $.observed.composite.resource.spec.parameters.creds.namespace }}"
    #FunctionGoTemplating & {
        step: "secret-store"
        input: inline: template: """
        {{ if and .observed.composite.resource.spec.parameters.apps.externalSecrets.enabled .observed.composite.resource.spec.parameters.apps.externalSecrets.store .observed.composite.resource.spec.parameters.apps.externalSecrets.googleCredentialsKey }}
        ---
        apiVersion: kubernetes.crossplane.io/v1alpha2
        kind: Object
        metadata:
          name: \( _id )-secret-store
          annotations:
            crossplane.io/external-name: \( _name )
            gotemplating.fn.crossplane.io/composition-resource-name: \( _id )-secret-store
        spec:
          references:
            - patchesFrom:
                apiVersion: gcp.upbound.io/v1beta1
                kind: ProviderConfig
                name: default
                fieldPath: spec.projectID
              toFieldPath: spec.provider.gcpsm.projectID
          forProvider:
            manifest:
              apiVersion: external-secrets.io/v1beta1
              kind: ClusterSecretStore
              metadata:
                name: \( _name )
              spec:
                provider:
                  gcpsm:
                    auth:
                      secretRef:
                        secretAccessKeySecretRef:
                          name: \( _credsName )
                          key: \( _googleCredsKey )
                          namespace: \( _credsNamespace )
          providerConfigRef:
            name: \( _id )
        {{ end }}
        """
    }
}