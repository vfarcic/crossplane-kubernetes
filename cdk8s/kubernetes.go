package main

import (
	composition "example.com/cdk8s/imports/apiextensionscrossplaneio"
	configHelm "example.com/cdk8s/imports/helmcrossplaneio"
	configKubernetes "example.com/cdk8s/imports/kubernetescrossplaneio"
	"github.com/aws/jsii-runtime-go"
)

func getProviderConfigKubernetes() *composition.CompositionSpecResources {
	return &composition.CompositionSpecResources{
		Name: jsii.String("kubernetes"),
		Base: configKubernetes.ProviderConfig_Manifest(&configKubernetes.ProviderConfigProps{
			Spec: &configKubernetes.ProviderConfigSpec{
				Credentials: &configKubernetes.ProviderConfigSpecCredentials{
					Source: configKubernetes.ProviderConfigSpecCredentialsSource_SECRET,
					SecretRef: &configKubernetes.ProviderConfigSpecCredentialsSecretRef{
						Key:       jsii.String("kubeconfig"),
						Name:      jsii.String("civo-kubeconfig"),
						Namespace: jsii.String("crossplane-system"),
					},
				},
			},
		}),
		Patches: &[]*composition.CompositionSpecResourcesPatches{
			getPatchFromTo("spec.id", "metadata.name"),
			getPatchFromTo("spec.claimRef.namespace", "spec.credentials.secretRef.namespace"),
			getPatchFromToTransformString("spec.id", "spec.credentials.secretRef.name", "%s-cluster"),
		},
		ReadinessChecks: &[]*composition.CompositionSpecResourcesReadinessChecks{
			{
				Type: composition.CompositionSpecResourcesReadinessChecksType_NONE,
			},
		},
	}
}

func getProviderConfigHelm() *composition.CompositionSpecResources {
	return &composition.CompositionSpecResources{
		Name: jsii.String("helm"),
		Base: configHelm.ProviderConfig_Manifest(&configHelm.ProviderConfigProps{
			Spec: &configHelm.ProviderConfigSpec{
				Credentials: &configHelm.ProviderConfigSpecCredentials{
					Source: configHelm.ProviderConfigSpecCredentialsSource_SECRET,
					SecretRef: &configHelm.ProviderConfigSpecCredentialsSecretRef{
						Key:       jsii.String("kubeconfig"),
						Name:      jsii.String("civo-kubeconfig"),
						Namespace: jsii.String("crossplane-system"),
					},
				},
			},
		}),
		Patches: &[]*composition.CompositionSpecResourcesPatches{
			getPatchFromTo("spec.id", "metadata.name"),
			getPatchFromTo("spec.claimRef.namespace", "spec.credentials.secretRef.namespace"),
			getPatchFromToTransformString("spec.id", "spec.credentials.secretRef.name", "%s-cluster"),
		},
		ReadinessChecks: &[]*composition.CompositionSpecResourcesReadinessChecks{
			{
				Type: composition.CompositionSpecResourcesReadinessChecksType_NONE,
			},
		},
	}
}
