package main

import (
	composition "example.com/cdk8s/imports/apiextensionscrossplaneio"
	civo "example.com/cdk8s/imports/clustercivocrossplaneio"
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

func NewCivoCk(scope constructs.Construct, id string, props *MyChartProps) cdk8s.Chart {
	var cprops cdk8s.ChartProps
	if props != nil {
		cprops = props.ChartProps
	}
	chart := cdk8s.NewChart(scope, jsii.String(id), &cprops)

	composition.NewComposition(chart, jsii.String("composition"), &composition.CompositionProps{
		Metadata: &cdk8s.ApiObjectMetadata{
			Name: jsii.String("cluster-civo"),
			Labels: &map[string]*string{
				"provider": jsii.String("civo"),
				"cluster":  jsii.String("ck"),
			},
		},
		Spec: getCompositionSpec(&[]*composition.CompositionSpecResources{
			getCivoCluster(),
		}, true),
	})
	return chart
}

func NewCivoCkAll(scope constructs.Construct, id string, props *MyChartProps) cdk8s.Chart {
	var cprops cdk8s.ChartProps
	if props != nil {
		cprops = props.ChartProps
	}
	chart := cdk8s.NewChart(scope, jsii.String(id), &cprops)

	composition.NewComposition(chart, jsii.String("composition"), &composition.CompositionProps{
		Metadata: &cdk8s.ApiObjectMetadata{
			Name: jsii.String("cluster-civo-all"),
			Labels: &map[string]*string{
				"provider": jsii.String("civo"),
				"cluster":  jsii.String("ck-all"),
			},
		},
		Spec: getCompositionSpec(&[]*composition.CompositionSpecResources{
			getCivoCluster(),
			getProviderConfigKubernetes(),
			getProviderConfigHelm(),
			getAppCrossplane(),
			// getAppCrossplanKubernetesProviderSA(),
		}, false),
	})
	return chart
}

func getCivoCluster() *composition.CompositionSpecResources {
	return &composition.CompositionSpecResources{
		Name: jsii.String("civocluster"),
		Base: civo.CivoKubernetes_Manifest(&civo.CivoKubernetesProps{
			Spec: &civo.CivoKubernetesSpec{
				Name: jsii.String("civocluster"),
				Pools: &[]*civo.CivoKubernetesSpecPools{
					{
						Id:    jsii.String("8382e422-dcdd-461f-afb4-2ab67f171c3e"),
						Count: jsii.Number(1),
						Size:  jsii.String("g3.k3s.small"),
					},
				},
				Applications: &[]*string{
					jsii.String("civo-cluster-autoscaler"),
				},
				ConnectionDetails: &civo.CivoKubernetesSpecConnectionDetails{
					ConnectionSecretNamePrefix: jsii.String("cluster-civo"),
					ConnectionSecretNamespace:  jsii.String("crossplane-system"),
				},
				ProviderConfigRef: &civo.CivoKubernetesSpecProviderConfigRef{
					Name: jsii.String("crossplane-provider-civo"),
				},
			},
		}),
		Patches: &[]*composition.CompositionSpecResourcesPatches{
			getPatchFromTo("spec.id", "metadata.name"),
			getPatchFromTo("spec.id", "spec.name"),
			getPatchFromToTransformString("spec.id", "spec.writeConnectionSecretToRef.name", "%s-cluster"),
			getPatchFromTo("spec.claimRef.namespace", "spec.writeConnectionSecretToRef.namespace"),
			getPatchFromTo("spec.parameters.minNodeCount", "spec.pools[0].count"),
			getPatchFromToTransformMap("spec.parameters.nodeSize", "spec.pools[0].size", &map[string]interface{}{
				"small":  jsii.String("g3.k3s.small"),
				"medium": jsii.String("g3.k3s.medium"),
				"large":  jsii.String("g3.k3s.xlarge"),
			}),
			getPatchToCompositeFieldPath("metadata.name", "status.clusterName"),
			getPatchToCompositeFieldPath("status.message", "status.controlPlaneStatus"),
			getPatchToCompositeFieldPath("status.message", "status.nodePoolStatus"),
		},
		ConnectionDetails: &[]*composition.CompositionSpecResourcesConnectionDetails{
			{
				FromConnectionSecretKey: jsii.String("kubeconfig"),
			}, {
				FromConnectionSecretKey: jsii.String("kubeconfig"),
				Value:                   jsii.String("value"),
			},
		},
	}
}
