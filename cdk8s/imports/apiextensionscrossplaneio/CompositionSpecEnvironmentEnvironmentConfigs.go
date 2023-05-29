package apiextensionscrossplaneio


// EnvironmentSource selects a EnvironmentConfig resource.
type CompositionSpecEnvironmentEnvironmentConfigs struct {
	// Ref is a named reference to a single EnvironmentConfig.
	//
	// Either Ref or Selector is required.
	Ref *CompositionSpecEnvironmentEnvironmentConfigsRef `field:"optional" json:"ref" yaml:"ref"`
	// Selector selects one EnvironmentConfig via labels.
	Selector *CompositionSpecEnvironmentEnvironmentConfigsSelector `field:"optional" json:"selector" yaml:"selector"`
	// Type specifies the way the EnvironmentConfig is selected.
	//
	// Default is `Reference`.
	Type CompositionSpecEnvironmentEnvironmentConfigsType `field:"optional" json:"type" yaml:"type"`
}

