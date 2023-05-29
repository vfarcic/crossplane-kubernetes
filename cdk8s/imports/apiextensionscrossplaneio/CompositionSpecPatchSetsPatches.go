package apiextensionscrossplaneio


// Patch objects are applied between composite and composed resources.
//
// Their behaviour depends on the Type selected. The default Type, FromCompositeFieldPath, copies a value from the composite resource to the composed resource, applying any defined transformers.
type CompositionSpecPatchSetsPatches struct {
	// Combine is the patch configuration for a CombineFromComposite, CombineFromEnvironment, CombineToComposite or CombineToEnvironment patch.
	Combine *CompositionSpecPatchSetsPatchesCombine `field:"optional" json:"combine" yaml:"combine"`
	// FromFieldPath is the path of the field on the resource whose value is to be used as input.
	//
	// Required when type is FromCompositeFieldPath, FromEnvironmentFieldPath, ToCompositeFieldPath, ToEnvironmentFieldPath.
	FromFieldPath *string `field:"optional" json:"fromFieldPath" yaml:"fromFieldPath"`
	// PatchSetName to include patches from.
	//
	// Required when type is PatchSet.
	PatchSetName *string `field:"optional" json:"patchSetName" yaml:"patchSetName"`
	// Policy configures the specifics of patching behaviour.
	Policy *CompositionSpecPatchSetsPatchesPolicy `field:"optional" json:"policy" yaml:"policy"`
	// ToFieldPath is the path of the field on the resource whose value will be changed with the result of transforms.
	//
	// Leave empty if you'd like to propagate to the same path as fromFieldPath.
	ToFieldPath *string `field:"optional" json:"toFieldPath" yaml:"toFieldPath"`
	// Transforms are the list of functions that are used as a FIFO pipe for the input to be transformed.
	Transforms *[]*CompositionSpecPatchSetsPatchesTransforms `field:"optional" json:"transforms" yaml:"transforms"`
	// Type sets the patching behaviour to be used.
	//
	// Each patch type may require its own fields to be set on the Patch object.
	Type CompositionSpecPatchSetsPatchesType `field:"optional" json:"type" yaml:"type"`
}

