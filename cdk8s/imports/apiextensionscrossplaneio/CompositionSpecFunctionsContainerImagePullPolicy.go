package apiextensionscrossplaneio


// ImagePullPolicy defines the pull policy for the function image.
type CompositionSpecFunctionsContainerImagePullPolicy string

const (
	// IfNotPresent.
	CompositionSpecFunctionsContainerImagePullPolicy_IF_NOT_PRESENT CompositionSpecFunctionsContainerImagePullPolicy = "IF_NOT_PRESENT"
	// Always.
	CompositionSpecFunctionsContainerImagePullPolicy_ALWAYS CompositionSpecFunctionsContainerImagePullPolicy = "ALWAYS"
	// Never.
	CompositionSpecFunctionsContainerImagePullPolicy_NEVER CompositionSpecFunctionsContainerImagePullPolicy = "NEVER"
)

