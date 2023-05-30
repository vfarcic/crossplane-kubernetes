package kubernetescrossplaneio

// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ObjectSpecProviderConfigRefPolicyResolve string

const (
	// Always.
	ObjectSpecProviderConfigRefPolicyResolve_ALWAYS ObjectSpecProviderConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ObjectSpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT ObjectSpecProviderConfigRefPolicyResolve = "IF_NOT_PRESENT"
)
