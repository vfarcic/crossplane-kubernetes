package apiextensionscrossplaneio


// Type sets the patching behaviour to be used.
//
// Each patch type may require its own fields to be set on the Patch object.
type CompositionSpecEnvironmentPatchesType string

const (
	// FromCompositeFieldPath.
	CompositionSpecEnvironmentPatchesType_FROM_COMPOSITE_FIELD_PATH CompositionSpecEnvironmentPatchesType = "FROM_COMPOSITE_FIELD_PATH"
	// FromEnvironmentFieldPath.
	CompositionSpecEnvironmentPatchesType_FROM_ENVIRONMENT_FIELD_PATH CompositionSpecEnvironmentPatchesType = "FROM_ENVIRONMENT_FIELD_PATH"
	// ToCompositeFieldPath.
	CompositionSpecEnvironmentPatchesType_TO_COMPOSITE_FIELD_PATH CompositionSpecEnvironmentPatchesType = "TO_COMPOSITE_FIELD_PATH"
	// CombineFromComposite.
	CompositionSpecEnvironmentPatchesType_COMBINE_FROM_COMPOSITE CompositionSpecEnvironmentPatchesType = "COMBINE_FROM_COMPOSITE"
	// CombineToComposite.
	CompositionSpecEnvironmentPatchesType_COMBINE_TO_COMPOSITE CompositionSpecEnvironmentPatchesType = "COMBINE_TO_COMPOSITE"
)

