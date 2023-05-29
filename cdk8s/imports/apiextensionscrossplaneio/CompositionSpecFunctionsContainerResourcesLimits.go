package apiextensionscrossplaneio


// Limits specify the maximum compute resources that may be used by the Composition Function.
type CompositionSpecFunctionsContainerResourcesLimits struct {
	// CPU, in cores.
	//
	// (500m = .5 cores)
	Cpu CompositionSpecFunctionsContainerResourcesLimitsCpu `field:"optional" json:"cpu" yaml:"cpu"`
	// Memory, in bytes.
	//
	// (500Gi = 500GiB = 500 * 1024 * 1024 * 1024).
	Memory CompositionSpecFunctionsContainerResourcesLimitsMemory `field:"optional" json:"memory" yaml:"memory"`
}

