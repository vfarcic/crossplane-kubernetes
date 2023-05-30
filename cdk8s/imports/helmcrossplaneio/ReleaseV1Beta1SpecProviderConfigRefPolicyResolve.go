package helmcrossplaneio


// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ReleaseV1Beta1SpecProviderConfigRefPolicyResolve string

const (
	// Always.
	ReleaseV1Beta1SpecProviderConfigRefPolicyResolve_ALWAYS ReleaseV1Beta1SpecProviderConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ReleaseV1Beta1SpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT ReleaseV1Beta1SpecProviderConfigRefPolicyResolve = "IF_NOT_PRESENT"
)

