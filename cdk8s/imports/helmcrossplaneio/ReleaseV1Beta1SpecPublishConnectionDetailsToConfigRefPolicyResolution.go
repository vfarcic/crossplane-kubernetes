package helmcrossplaneio


// Resolution specifies whether resolution of this reference is required.
//
// The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved.
type ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution string

const (
	// Required.
	ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution_REQUIRED ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution = "REQUIRED"
	// Optional.
	ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution_OPTIONAL ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution = "OPTIONAL"
)

