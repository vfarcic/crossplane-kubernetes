package kubernetescrossplaneio

// PatchesFrom is used to declare dependency on other Object or arbitrary Kubernetes resource, and also patch fields from this object.
type ObjectSpecReferencesPatchesFrom struct {
	// FieldPath is the path of the field on the resource whose value is to be used as input.
	FieldPath *string `field:"required" json:"fieldPath" yaml:"fieldPath"`
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// APIVersion of the referenced object.
	ApiVersion *string `field:"optional" json:"apiVersion" yaml:"apiVersion"`
	// Kind of the referenced object.
	Kind *string `field:"optional" json:"kind" yaml:"kind"`
	// Namespace of the referenced object.
	Namespace *string `field:"optional" json:"namespace" yaml:"namespace"`
}
