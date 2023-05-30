package kubernetescrossplaneio

// Resolve specifies when this reference should be resolved.
//
// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
type ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve string

const (
	// Always.
	ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve = "ALWAYS"
	// IfNotPresent.
	ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve = "IF_NOT_PRESENT"
)
