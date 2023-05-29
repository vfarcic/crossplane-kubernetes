package apiextensionscrossplaneio


// Type sets the connection detail fetching behaviour to be used.
//
// Each connection detail type may require its own fields to be set on the ConnectionDetail object. If the type is omitted Crossplane will attempt to infer it based on which other fields were specified. If multiple fields are specified the order of precedence is: 1. FromValue 2. FromConnectionSecretKey 3. FromFieldPath
type CompositionSpecResourcesConnectionDetailsType string

const (
	// FromConnectionSecretKey.
	CompositionSpecResourcesConnectionDetailsType_FROM_CONNECTION_SECRET_KEY CompositionSpecResourcesConnectionDetailsType = "FROM_CONNECTION_SECRET_KEY"
	// FromFieldPath.
	CompositionSpecResourcesConnectionDetailsType_FROM_FIELD_PATH CompositionSpecResourcesConnectionDetailsType = "FROM_FIELD_PATH"
	// FromValue.
	CompositionSpecResourcesConnectionDetailsType_FROM_VALUE CompositionSpecResourcesConnectionDetailsType = "FROM_VALUE"
)

