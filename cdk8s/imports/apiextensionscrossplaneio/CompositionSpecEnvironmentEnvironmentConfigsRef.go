package apiextensionscrossplaneio


// Ref is a named reference to a single EnvironmentConfig.
//
// Either Ref or Selector is required.
type CompositionSpecEnvironmentEnvironmentConfigsRef struct {
	// The name of the object.
	Name *string `field:"required" json:"name" yaml:"name"`
}

