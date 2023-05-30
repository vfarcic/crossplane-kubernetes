package helmcrossplaneio


// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ReleaseSpecProviderConfigRefPolicyResolve string

const (
	// Always.
	ReleaseSpecProviderConfigRefPolicyResolve_ALWAYS ReleaseSpecProviderConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ReleaseSpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT ReleaseSpecProviderConfigRefPolicyResolve = "IF_NOT_PRESENT"
)

