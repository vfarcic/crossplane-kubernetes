package apiextensionscrossplaneio


// Type specifies the way the EnvironmentConfig is selected.
//
// Default is `Reference`.
type CompositionSpecEnvironmentEnvironmentConfigsType string

const (
	// Reference.
	CompositionSpecEnvironmentEnvironmentConfigsType_REFERENCE CompositionSpecEnvironmentEnvironmentConfigsType = "REFERENCE"
	// Selector.
	CompositionSpecEnvironmentEnvironmentConfigsType_SELECTOR CompositionSpecEnvironmentEnvironmentConfigsType = "SELECTOR"
)

