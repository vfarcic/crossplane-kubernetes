package apiextensionscrossplaneio


// Type sets the patching behaviour to be used.
//
// Each patch type may require its own fields to be set on the Patch object.
type CompositionSpecPatchSetsPatchesType string

const (
	// FromCompositeFieldPath.
	CompositionSpecPatchSetsPatchesType_FROM_COMPOSITE_FIELD_PATH CompositionSpecPatchSetsPatchesType = "FROM_COMPOSITE_FIELD_PATH"
	// FromEnvironmentFieldPath.
	CompositionSpecPatchSetsPatchesType_FROM_ENVIRONMENT_FIELD_PATH CompositionSpecPatchSetsPatchesType = "FROM_ENVIRONMENT_FIELD_PATH"
	// PatchSet.
	CompositionSpecPatchSetsPatchesType_PATCH_SET CompositionSpecPatchSetsPatchesType = "PATCH_SET"
	// ToCompositeFieldPath.
	CompositionSpecPatchSetsPatchesType_TO_COMPOSITE_FIELD_PATH CompositionSpecPatchSetsPatchesType = "TO_COMPOSITE_FIELD_PATH"
	// ToEnvironmentFieldPath.
	CompositionSpecPatchSetsPatchesType_TO_ENVIRONMENT_FIELD_PATH CompositionSpecPatchSetsPatchesType = "TO_ENVIRONMENT_FIELD_PATH"
	// CombineFromEnvironment.
	CompositionSpecPatchSetsPatchesType_COMBINE_FROM_ENVIRONMENT CompositionSpecPatchSetsPatchesType = "COMBINE_FROM_ENVIRONMENT"
	// CombineFromComposite.
	CompositionSpecPatchSetsPatchesType_COMBINE_FROM_COMPOSITE CompositionSpecPatchSetsPatchesType = "COMBINE_FROM_COMPOSITE"
	// CombineToComposite.
	CompositionSpecPatchSetsPatchesType_COMBINE_TO_COMPOSITE CompositionSpecPatchSetsPatchesType = "COMBINE_TO_COMPOSITE"
	// CombineToEnvironment.
	CompositionSpecPatchSetsPatchesType_COMBINE_TO_ENVIRONMENT CompositionSpecPatchSetsPatchesType = "COMBINE_TO_ENVIRONMENT"
)

