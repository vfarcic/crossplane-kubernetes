package helmcrossplaneio


// ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured.
type ReleaseV1Beta1SpecProviderConfigRef struct {
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Policies for referencing.
	Policy *ReleaseV1Beta1SpecProviderConfigRefPolicy `field:"optional" json:"policy" yaml:"policy"`
}

