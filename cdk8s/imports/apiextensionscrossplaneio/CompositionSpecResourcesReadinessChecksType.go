package apiextensionscrossplaneio


// Type indicates the type of probe you'd like to use.
type CompositionSpecResourcesReadinessChecksType string

const (
	// MatchString.
	CompositionSpecResourcesReadinessChecksType_MATCH_STRING CompositionSpecResourcesReadinessChecksType = "MATCH_STRING"
	// MatchInteger.
	CompositionSpecResourcesReadinessChecksType_MATCH_INTEGER CompositionSpecResourcesReadinessChecksType = "MATCH_INTEGER"
	// NonEmpty.
	CompositionSpecResourcesReadinessChecksType_NON_EMPTY CompositionSpecResourcesReadinessChecksType = "NON_EMPTY"
	// None.
	CompositionSpecResourcesReadinessChecksType_NONE CompositionSpecResourcesReadinessChecksType = "NONE"
)

