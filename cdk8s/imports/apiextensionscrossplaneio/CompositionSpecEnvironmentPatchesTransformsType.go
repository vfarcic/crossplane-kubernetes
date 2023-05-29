package apiextensionscrossplaneio


// Type of the transform to be run.
type CompositionSpecEnvironmentPatchesTransformsType string

const (
	// map.
	CompositionSpecEnvironmentPatchesTransformsType_MAP CompositionSpecEnvironmentPatchesTransformsType = "MAP"
	// match.
	CompositionSpecEnvironmentPatchesTransformsType_MATCH CompositionSpecEnvironmentPatchesTransformsType = "MATCH"
	// math.
	CompositionSpecEnvironmentPatchesTransformsType_MATH CompositionSpecEnvironmentPatchesTransformsType = "MATH"
	// string.
	CompositionSpecEnvironmentPatchesTransformsType_STRING CompositionSpecEnvironmentPatchesTransformsType = "STRING"
	// convert.
	CompositionSpecEnvironmentPatchesTransformsType_CONVERT CompositionSpecEnvironmentPatchesTransformsType = "CONVERT"
)

