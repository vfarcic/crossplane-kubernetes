package apiextensionscrossplaneio


// EnvironmentPatch is a patch for a Composition environment.
type CompositionSpecEnvironmentPatches struct {
	// Combine is the patch configuration for a CombineFromComposite or CombineToComposite patch.
	Combine *CompositionSpecEnvironmentPatchesCombine `field:"optional" json:"combine" yaml:"combine"`
	// FromFieldPath is the path of the field on the resource whose value is to be used as input.
	//
	// Required when type is FromCompositeFieldPath or ToCompositeFieldPath.
	FromFieldPath *string `field:"optional" json:"fromFieldPath" yaml:"fromFieldPath"`
	// Policy configures the specifics of patching behaviour.
	Policy *CompositionSpecEnvironmentPatchesPolicy `field:"optional" json:"policy" yaml:"policy"`
	// ToFieldPath is the path of the field on the resource whose value will be changed with the result of transforms.
	//
	// Leave empty if you'd like to propagate to the same path as fromFieldPath.
	ToFieldPath *string `field:"optional" json:"toFieldPath" yaml:"toFieldPath"`
	// Transforms are the list of functions that are used as a FIFO pipe for the input to be transformed.
	Transforms *[]*CompositionSpecEnvironmentPatchesTransforms `field:"optional" json:"transforms" yaml:"transforms"`
	// Type sets the patching behaviour to be used.
	//
	// Each patch type may require its own fields to be set on the Patch object.
	Type CompositionSpecEnvironmentPatchesType `field:"optional" json:"type" yaml:"type"`
}

