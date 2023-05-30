package helmcrossplaneio


// Resolution specifies whether resolution of this reference is required.
//
// The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved.
type ReleaseSpecProviderRefPolicyResolution string

const (
	// Required.
	ReleaseSpecProviderRefPolicyResolution_REQUIRED ReleaseSpecProviderRefPolicyResolution = "REQUIRED"
	// Optional.
	ReleaseSpecProviderRefPolicyResolution_OPTIONAL ReleaseSpecProviderRefPolicyResolution = "OPTIONAL"
)

