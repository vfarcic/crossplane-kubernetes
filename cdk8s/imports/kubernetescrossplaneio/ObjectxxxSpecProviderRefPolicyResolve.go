package kubernetescrossplaneio

// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ObjectSpecProviderRefPolicyResolve string

const (
	// Always.
	ObjectSpecProviderRefPolicyResolve_ALWAYS ObjectSpecProviderRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ObjectSpecProviderRefPolicyResolve_IF_NOT_PRESENT ObjectSpecProviderRefPolicyResolve = "IF_NOT_PRESENT"
)
