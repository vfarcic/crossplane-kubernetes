package kubernetescrossplaneio

// Reference refers to an Object or arbitrary Kubernetes resource and optionally patch values from that resource to the current Object.
type ObjectSpecReferences struct {
	// DependsOn is used to declare dependency on other Object or arbitrary Kubernetes resource.
	DependsOn *ObjectSpecReferencesDependsOn `field:"optional" json:"dependsOn" yaml:"dependsOn"`
	// PatchesFrom is used to declare dependency on other Object or arbitrary Kubernetes resource, and also patch fields from this object.
	PatchesFrom *ObjectSpecReferencesPatchesFrom `field:"optional" json:"patchesFrom" yaml:"patchesFrom"`
	// ToFieldPath is the path of the field on the resource whose value will be changed with the result of transforms.
	//
	// Leave empty if you'd like to propagate to the same path as patchesFrom.fieldPath.
	ToFieldPath *string `field:"optional" json:"toFieldPath" yaml:"toFieldPath"`
}
