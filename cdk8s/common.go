package main

import (
	composition "example.com/cdk8s/imports/apiextensionscrossplaneio"
	"github.com/aws/jsii-runtime-go"
)

func getPatchSets() *[]*composition.CompositionSpecPatchSets {
	return &[]*composition.CompositionSpecPatchSets{
		{
			Name: jsii.String("metadata"),
			Patches: &[]*composition.CompositionSpecPatchSetsPatches{
				{
					FromFieldPath: jsii.String("metadata.labels"),
				},
			},
		},
	}
}

func getCompositionSpec(resources *[]*composition.CompositionSpecResources, writeConnectionSecretsToNamespace bool) *composition.CompositionSpec {
	spec := &composition.CompositionSpec{
		CompositeTypeRef: &composition.CompositionSpecCompositeTypeRef{
			ApiVersion: jsii.String("devopstoolkitseries.com/v1alpha1"),
			Kind:       jsii.String("CompositeCluster"),
		},
		PatchSets: getPatchSets(),
		Resources: resources,
	}
	if writeConnectionSecretsToNamespace {
		spec.WriteConnectionSecretsToNamespace = jsii.String("crossplane-system")
	}
	return spec
}

func getPatchFromTo(from, to string) *composition.CompositionSpecResourcesPatches {
	return &composition.CompositionSpecResourcesPatches{
		FromFieldPath: jsii.String(from),
		ToFieldPath:   jsii.String(to),
	}
}

func getPatchFromToTransformString(from, to, transform string) *composition.CompositionSpecResourcesPatches {
	return &composition.CompositionSpecResourcesPatches{
		FromFieldPath: jsii.String(from),
		ToFieldPath:   jsii.String(to),
		Transforms: &[]*composition.CompositionSpecResourcesPatchesTransforms{
			{
				Type: composition.CompositionSpecResourcesPatchesTransformsType(composition.CompositionSpecResourcesPatchesTransformsType_STRING),
				String: &composition.CompositionSpecResourcesPatchesTransformsString{
					Fmt: jsii.String(transform),
				},
			},
		},
	}
}

func getPatchFromToTransformMap(from, to string, items *map[string]interface{}) *composition.CompositionSpecResourcesPatches {
	return &composition.CompositionSpecResourcesPatches{
		FromFieldPath: jsii.String(from),
		ToFieldPath:   jsii.String(to),
		Transforms: &[]*composition.CompositionSpecResourcesPatchesTransforms{
			{
				Type: composition.CompositionSpecResourcesPatchesTransformsType(composition.CompositionSpecResourcesPatchesTransformsType_MAP),
				Map:  items,
			},
		},
	}
}

func getPatchToCompositeFieldPath(from, to string) *composition.CompositionSpecResourcesPatches {
	return &composition.CompositionSpecResourcesPatches{
		Type:          composition.CompositionSpecResourcesPatchesType(composition.CompositionSpecResourcesPatchesType_TO_COMPOSITE_FIELD_PATH),
		FromFieldPath: jsii.String(from),
		ToFieldPath:   jsii.String(to),
	}
}
