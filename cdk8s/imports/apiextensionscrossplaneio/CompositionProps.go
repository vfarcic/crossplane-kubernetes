package apiextensionscrossplaneio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A Composition specifies how a composite resource should be composed.
type CompositionProps struct {
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
	// CompositionSpec specifies desired state of a composition.
	Spec *CompositionSpec `field:"optional" json:"spec" yaml:"spec"`
}

