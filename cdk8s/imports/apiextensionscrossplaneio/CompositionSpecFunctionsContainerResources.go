package apiextensionscrossplaneio


// Resources that may be used by the Composition Function.
type CompositionSpecFunctionsContainerResources struct {
	// Limits specify the maximum compute resources that may be used by the Composition Function.
	Limits *CompositionSpecFunctionsContainerResourcesLimits `field:"optional" json:"limits" yaml:"limits"`
}

