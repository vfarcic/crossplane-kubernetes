package apiextensionscrossplaneio


// A Function represents a Composition Function.
type CompositionSpecFunctions struct {
	// Name of this function.
	//
	// Must be unique within its Composition.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Type of this function.
	Type CompositionSpecFunctionsType `field:"required" json:"type" yaml:"type"`
	// Config is an optional, arbitrary Kubernetes resource (i.e. a resource with an apiVersion and kind) that will be passed to the Composition Function as the 'config' block of its FunctionIO.
	Config interface{} `field:"optional" json:"config" yaml:"config"`
	// Container configuration of this function.
	Container *CompositionSpecFunctionsContainer `field:"optional" json:"container" yaml:"container"`
}

