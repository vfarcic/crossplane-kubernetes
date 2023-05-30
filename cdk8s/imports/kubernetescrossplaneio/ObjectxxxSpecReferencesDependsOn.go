package kubernetescrossplaneio

// DependsOn is used to declare dependency on other Object or arbitrary Kubernetes resource.
type ObjectSpecReferencesDependsOn struct {
	// Name of the referenced object.
	Name *string `field:"required" json:"name" yaml:"name"`
	// APIVersion of the referenced object.
	ApiVersion *string `field:"optional" json:"apiVersion" yaml:"apiVersion"`
	// Kind of the referenced object.
	Kind *string `field:"optional" json:"kind" yaml:"kind"`
	// Namespace of the referenced object.
	Namespace *string `field:"optional" json:"namespace" yaml:"namespace"`
}
