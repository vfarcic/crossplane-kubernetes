package kubernetescrossplaneio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A Object is an provider Kubernetes API type.
type ObjectProps struct {
	// A ObjectSpec defines the desired state of a Object.
	Spec     *ObjectSpec              `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}
