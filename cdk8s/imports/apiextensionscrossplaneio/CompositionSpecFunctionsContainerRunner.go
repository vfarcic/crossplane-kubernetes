package apiextensionscrossplaneio


// Runner configuration for the Composition Function.
type CompositionSpecFunctionsContainerRunner struct {
	// Endpoint specifies how and where Crossplane should reach the runner it uses to invoke containerized Composition Functions.
	Endpoint *string `field:"optional" json:"endpoint" yaml:"endpoint"`
}

