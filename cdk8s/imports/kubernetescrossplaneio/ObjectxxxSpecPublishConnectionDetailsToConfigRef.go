package kubernetescrossplaneio

// SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret.
type ObjectSpecPublishConnectionDetailsToConfigRef struct {
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Policies for referencing.
	Policy *ObjectSpecPublishConnectionDetailsToConfigRefPolicy `field:"optional" json:"policy" yaml:"policy"`
}
