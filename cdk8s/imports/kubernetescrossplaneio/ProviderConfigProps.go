package kubernetescrossplaneio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A ProviderConfig configures a Template provider.
type ProviderConfigProps struct {
	// A ProviderConfigSpec defines the desired state of a ProviderConfig.
	Spec *ProviderConfigSpec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

