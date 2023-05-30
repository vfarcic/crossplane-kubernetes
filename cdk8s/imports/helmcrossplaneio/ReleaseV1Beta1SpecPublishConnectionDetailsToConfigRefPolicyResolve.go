package helmcrossplaneio


// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve string

const (
	// Always.
	ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve = "IF_NOT_PRESENT"
)

