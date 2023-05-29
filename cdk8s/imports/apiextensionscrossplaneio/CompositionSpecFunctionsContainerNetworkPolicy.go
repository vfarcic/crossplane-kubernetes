package apiextensionscrossplaneio


// Policy specifies the network policy under which the Composition Function will run.
//
// Defaults to 'Isolated' - i.e. no network access. Specify 'Runner' to allow the function the same network access as its runner.
type CompositionSpecFunctionsContainerNetworkPolicy string

const (
	// Isolated.
	CompositionSpecFunctionsContainerNetworkPolicy_ISOLATED CompositionSpecFunctionsContainerNetworkPolicy = "ISOLATED"
	// Runner.
	CompositionSpecFunctionsContainerNetworkPolicy_RUNNER CompositionSpecFunctionsContainerNetworkPolicy = "RUNNER"
)

