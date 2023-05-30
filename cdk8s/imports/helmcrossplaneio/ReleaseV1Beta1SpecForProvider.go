package helmcrossplaneio


// ReleaseParameters are the configurable fields of a Release.
type ReleaseV1Beta1SpecForProvider struct {
	// A ChartSpec defines the chart spec for a Release.
	Chart *ReleaseV1Beta1SpecForProviderChart `field:"required" json:"chart" yaml:"chart"`
	// Namespace to install the release into.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
	// InsecureSkipTLSVerify skips tls certificate checks for the chart download.
	InsecureSkipTlsVerify *bool `field:"optional" json:"insecureSkipTlsVerify" yaml:"insecureSkipTlsVerify"`
	// PatchesFrom describe patches to be applied to the rendered manifests.
	PatchesFrom *[]*ReleaseV1Beta1SpecForProviderPatchesFrom `field:"optional" json:"patchesFrom" yaml:"patchesFrom"`
	Set *[]*ReleaseV1Beta1SpecForProviderSet `field:"optional" json:"set" yaml:"set"`
	// SkipCRDs skips installation of CRDs for the release.
	SkipCrDs *bool `field:"optional" json:"skipCrDs" yaml:"skipCrDs"`
	// SkipCreateNamespace won't create the namespace for the release.
	//
	// This requires the namespace to already exist.
	SkipCreateNamespace *bool `field:"optional" json:"skipCreateNamespace" yaml:"skipCreateNamespace"`
	Values interface{} `field:"optional" json:"values" yaml:"values"`
	ValuesFrom *[]*ReleaseV1Beta1SpecForProviderValuesFrom `field:"optional" json:"valuesFrom" yaml:"valuesFrom"`
	// Wait for the release to become ready.
	Wait *bool `field:"optional" json:"wait" yaml:"wait"`
	// WaitTimeout is the duration Helm will wait for the release to become ready.
	//
	// Only applies if wait is also set. Defaults to 5m.
	WaitTimeout *string `field:"optional" json:"waitTimeout" yaml:"waitTimeout"`
}

