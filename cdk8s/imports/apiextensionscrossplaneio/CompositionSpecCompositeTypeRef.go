package apiextensionscrossplaneio


// CompositeTypeRef specifies the type of composite resource that this composition is compatible with.
type CompositionSpecCompositeTypeRef struct {
	// APIVersion of the type.
	ApiVersion *string `field:"required" json:"apiVersion" yaml:"apiVersion"`
	// Kind of the type.
	Kind *string `field:"required" json:"kind" yaml:"kind"`
}

