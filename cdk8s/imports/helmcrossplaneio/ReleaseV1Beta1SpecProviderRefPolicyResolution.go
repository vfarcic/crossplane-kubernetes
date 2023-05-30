package helmcrossplaneio


// Resolution specifies whether resolution of this reference is required.
//
// The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved.
type ReleaseV1Beta1SpecProviderRefPolicyResolution string

const (
	// Required.
	ReleaseV1Beta1SpecProviderRefPolicyResolution_REQUIRED ReleaseV1Beta1SpecProviderRefPolicyResolution = "REQUIRED"
	// Optional.
	ReleaseV1Beta1SpecProviderRefPolicyResolution_OPTIONAL ReleaseV1Beta1SpecProviderRefPolicyResolution = "OPTIONAL"
)

