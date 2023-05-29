package apiextensionscrossplaneio


// Combine is the patch configuration for a CombineFromComposite, CombineFromEnvironment, CombineToComposite or CombineToEnvironment patch.
type CompositionSpecResourcesPatchesCombine struct {
	// Strategy defines the strategy to use to combine the input variable values.
	//
	// Currently only string is supported.
	Strategy CompositionSpecResourcesPatchesCombineStrategy `field:"required" json:"strategy" yaml:"strategy"`
	// Variables are the list of variables whose values will be retrieved and combined.
	Variables *[]*CompositionSpecResourcesPatchesCombineVariables `field:"required" json:"variables" yaml:"variables"`
	// String declares that input variables should be combined into a single string, using the relevant settings for formatting purposes.
	String *CompositionSpecResourcesPatchesCombineString `field:"optional" json:"string" yaml:"string"`
}

