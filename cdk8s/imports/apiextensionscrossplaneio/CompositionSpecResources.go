package apiextensionscrossplaneio


// ComposedTemplate is used to provide information about how the composed resource should be processed.
type CompositionSpecResources struct {
	// Base is the target resource that the patches will be applied on.
	Base interface{} `field:"required" json:"base" yaml:"base"`
	// ConnectionDetails lists the propagation secret keys from this target resource to the composition instance connection secret.
	ConnectionDetails *[]*CompositionSpecResourcesConnectionDetails `field:"optional" json:"connectionDetails" yaml:"connectionDetails"`
	// A Name uniquely identifies this entry within its Composition's resources array.
	//
	// Names are optional but *strongly* recommended. When all entries in the resources array are named entries may added, deleted, and reordered as long as their names do not change. When entries are not named the length and order of the resources array should be treated as immutable. Either all or no entries must be named.
	Name *string `field:"optional" json:"name" yaml:"name"`
	// Patches will be applied as overlay to the base resource.
	Patches *[]*CompositionSpecResourcesPatches `field:"optional" json:"patches" yaml:"patches"`
	// ReadinessChecks allows users to define custom readiness checks.
	//
	// All checks have to return true in order for resource to be considered ready. The default readiness check is to have the "Ready" condition to be "True".
	ReadinessChecks *[]*CompositionSpecResourcesReadinessChecks `field:"optional" json:"readinessChecks" yaml:"readinessChecks"`
}

