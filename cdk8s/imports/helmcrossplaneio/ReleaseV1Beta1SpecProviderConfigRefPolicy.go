package helmcrossplaneio


// Policies for referencing.
type ReleaseV1Beta1SpecProviderConfigRefPolicy struct {
	// Resolution specifies whether resolution of this reference is required.
	//
	// The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved.
	Resolution ReleaseV1Beta1SpecProviderConfigRefPolicyResolution `field:"optional" json:"resolution" yaml:"resolution"`
	// Resolve specifies when this reference should be resolved.
	//
	// The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile.
	Resolve ReleaseV1Beta1SpecProviderConfigRefPolicyResolve `field:"optional" json:"resolve" yaml:"resolve"`
}

