package apiextensionscrossplaneio


// Type of the string transform to be run.
type CompositionSpecEnvironmentPatchesTransformsStringType string

const (
	// Format.
	CompositionSpecEnvironmentPatchesTransformsStringType_FORMAT CompositionSpecEnvironmentPatchesTransformsStringType = "FORMAT"
	// Convert.
	CompositionSpecEnvironmentPatchesTransformsStringType_CONVERT CompositionSpecEnvironmentPatchesTransformsStringType = "CONVERT"
	// TrimPrefix.
	CompositionSpecEnvironmentPatchesTransformsStringType_TRIM_PREFIX CompositionSpecEnvironmentPatchesTransformsStringType = "TRIM_PREFIX"
	// TrimSuffix.
	CompositionSpecEnvironmentPatchesTransformsStringType_TRIM_SUFFIX CompositionSpecEnvironmentPatchesTransformsStringType = "TRIM_SUFFIX"
	// Regexp.
	CompositionSpecEnvironmentPatchesTransformsStringType_REGEXP CompositionSpecEnvironmentPatchesTransformsStringType = "REGEXP"
)

