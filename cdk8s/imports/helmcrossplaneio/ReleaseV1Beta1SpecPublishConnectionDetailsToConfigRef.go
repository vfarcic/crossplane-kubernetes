package helmcrossplaneio


// SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret.
type ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRef struct {
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Policies for referencing.
	Policy *ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicy `field:"optional" json:"policy" yaml:"policy"`
}

