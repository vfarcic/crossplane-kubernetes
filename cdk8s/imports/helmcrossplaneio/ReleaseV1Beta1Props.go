package helmcrossplaneio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A Release is an example API type.
type ReleaseV1Beta1Props struct {
	// A ReleaseSpec defines the desired state of a Release.
	Spec *ReleaseV1Beta1Spec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

