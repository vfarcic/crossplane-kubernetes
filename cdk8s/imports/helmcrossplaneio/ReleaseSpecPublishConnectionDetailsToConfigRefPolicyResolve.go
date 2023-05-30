package helmcrossplaneio


// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve string

const (
	// Always.
	ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve = "IF_NOT_PRESENT"
)

