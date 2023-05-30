package helmcrossplaneio


// SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret.
type ReleaseSpecPublishConnectionDetailsToConfigRef struct {
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Policies for referencing.
	Policy *ReleaseSpecPublishConnectionDetailsToConfigRefPolicy `field:"optional" json:"policy" yaml:"policy"`
}

