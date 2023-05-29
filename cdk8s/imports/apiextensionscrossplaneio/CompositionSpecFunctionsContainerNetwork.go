package apiextensionscrossplaneio


// Network configuration for the Composition Function.
type CompositionSpecFunctionsContainerNetwork struct {
	// Policy specifies the network policy under which the Composition Function will run.
	//
	// Defaults to 'Isolated' - i.e. no network access. Specify 'Runner' to allow the function the same network access as its runner.
	Policy CompositionSpecFunctionsContainerNetworkPolicy `field:"optional" json:"policy" yaml:"policy"`
}

