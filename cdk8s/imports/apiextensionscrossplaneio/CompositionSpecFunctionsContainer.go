package apiextensionscrossplaneio


// Container configuration of this function.
type CompositionSpecFunctionsContainer struct {
	// Image specifies the OCI image in which the function is packaged.
	//
	// The image should include an entrypoint that reads a FunctionIO from stdin and emits it, optionally mutated, to stdout.
	Image *string `field:"required" json:"image" yaml:"image"`
	// ImagePullPolicy defines the pull policy for the function image.
	ImagePullPolicy CompositionSpecFunctionsContainerImagePullPolicy `field:"optional" json:"imagePullPolicy" yaml:"imagePullPolicy"`
	// Network configuration for the Composition Function.
	Network *CompositionSpecFunctionsContainerNetwork `field:"optional" json:"network" yaml:"network"`
	// Resources that may be used by the Composition Function.
	Resources *CompositionSpecFunctionsContainerResources `field:"optional" json:"resources" yaml:"resources"`
	// Runner configuration for the Composition Function.
	Runner *CompositionSpecFunctionsContainerRunner `field:"optional" json:"runner" yaml:"runner"`
	// Timeout after which the Composition Function will be killed.
	Timeout *string `field:"optional" json:"timeout" yaml:"timeout"`
}

