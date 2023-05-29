package clustercivocrossplaneio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A CivoKubernetes is an example API type.
//
// Please replace `PROVIDER-NAME` with your actual provider name, like `aws`, `azure`, `gcp`, `alibaba`.
type CivoKubernetesProps struct {
	// A CivoKubernetesSpec defines the desired state of a CivoKubernetes.
	Spec *CivoKubernetesSpec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

