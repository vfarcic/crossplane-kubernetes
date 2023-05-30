package helmcrossplaneio


// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ReleaseSpecProviderRefPolicyResolve string

const (
	// Always.
	ReleaseSpecProviderRefPolicyResolve_ALWAYS ReleaseSpecProviderRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ReleaseSpecProviderRefPolicyResolve_IF_NOT_PRESENT ReleaseSpecProviderRefPolicyResolve = "IF_NOT_PRESENT"
)

