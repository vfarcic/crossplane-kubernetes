package apiextensionscrossplaneio


// Type of the transform to be run.
type CompositionSpecResourcesPatchesTransformsType string

const (
	// map.
	CompositionSpecResourcesPatchesTransformsType_MAP CompositionSpecResourcesPatchesTransformsType = "MAP"
	// match.
	CompositionSpecResourcesPatchesTransformsType_MATCH CompositionSpecResourcesPatchesTransformsType = "MATCH"
	// math.
	CompositionSpecResourcesPatchesTransformsType_MATH CompositionSpecResourcesPatchesTransformsType = "MATH"
	// string.
	CompositionSpecResourcesPatchesTransformsType_STRING CompositionSpecResourcesPatchesTransformsType = "STRING"
	// convert.
	CompositionSpecResourcesPatchesTransformsType_CONVERT CompositionSpecResourcesPatchesTransformsType = "CONVERT"
)

