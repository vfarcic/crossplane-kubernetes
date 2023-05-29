package apiextensionscrossplaneio


// Environment configures the environment in which resources are rendered.
//
// THIS IS AN ALPHA FIELD. Do not use it in production. It is not honored unless the relevant Crossplane feature flag is enabled, and may be changed or removed without notice.
type CompositionSpecEnvironment struct {
	// EnvironmentConfigs selects a list of `EnvironmentConfig`s.
	//
	// The resolved resources are stored in the composite resource at `spec.environmentConfigRefs` and is only updated if it is null.
	// The list of references is used to compute an in-memory environment at compose time. The data of all object is merged in the order they are listed, meaning the values of EnvironmentConfigs with a larger index take priority over ones with smaller indices.
	// The computed environment can be accessed in a composition using `FromEnvironmentFieldPath` and `CombineFromEnvironment` patches.
	EnvironmentConfigs *[]*CompositionSpecEnvironmentEnvironmentConfigs `field:"optional" json:"environmentConfigs" yaml:"environmentConfigs"`
	// Patches is a list of environment patches that are executed before a composition's resources are composed.
	Patches *[]*CompositionSpecEnvironmentPatches `field:"optional" json:"patches" yaml:"patches"`
}

