package main

import (
	composition "example.com/cdk8s/imports/apiextensionscrossplaneio"
	config "example.com/cdk8s/imports/kubernetescrossplaneio"
	"github.com/aws/jsii-runtime-go"
)

func getProviderConfigKubernetes() *composition.CompositionSpecResources {
	return &composition.CompositionSpecResources{
		Name: jsii.String("kubernetes"),
		Base: config.ProviderConfig_Manifest(&config.ProviderConfigProps{
			Spec: &config.ProviderConfigSpec{
				Credentials: &config.ProviderConfigSpecCredentials{
					Source: config.ProviderConfigSpecCredentialsSource_SECRET,
					SecretRef: &config.ProviderConfigSpecCredentialsSecretRef{
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
	}
}
