package main

import (
	composition "example.com/cdk8s/imports/apiextensionscrossplaneio"
	release "example.com/cdk8s/imports/helmcrossplaneio"
	"github.com/aws/jsii-runtime-go"
)

func getAppCrossplane() *composition.CompositionSpecResources {
	return &composition.CompositionSpecResources{
		Name: jsii.String("crossplane"),
		Base: release.Release_Manifest(&release.ReleaseProps{
			Spec: &release.ReleaseSpec{
				RollbackLimit: jsii.Number(3),
				ForProvider: &release.ReleaseSpecForProvider{
					Namespace: jsii.String("crossplane-system"),
					Chart: &release.ReleaseSpecForProviderChart{
						Name:       jsii.String("crossplane"),
						Repository: jsii.String("https://charts.crossplane.io/stable"),
						Version:    jsii.String("1.12.1"),
					},
				},
			},
		}),
		Patches: &[]*composition.CompositionSpecResourcesPatches{
			getPatchFromToTransformString("spec.id", "metadata.name", "%s-crossplane"),
			getPatchFromTo("spec.id", "spec.providerConfigRef.name"),
		},
	}
}

// func getAppCrossplanKubernetesProviderSA() *composition.CompositionSpecResources {
// 	return &composition.CompositionSpecResources{
// 		Name: jsii.String("crossplane"),
// 		Base: kc.Object_Manifest(&kc.ObjectProps{
// 			Spec: &kc.ObjectSpec{
// 				ForProvider: &kc.ObjectSpecForProvider{
// 					Manifest: "TODO:",
// 				},
// 			},
// 		}),
// 		Patches: &[]*composition.CompositionSpecResourcesPatches{
// 			getPatchFromToTransformString("spec.id", "metadata.name", "%s-crossplane"),
// 			getPatchFromTo("spec.id", "spec.providerConfigRef.name"),
// 		},
// 	}
// }
