package helmcrossplaneio


// ReleaseParameters are the configurable fields of a Release.
type ReleaseSpecForProvider struct {
	// A ChartSpec defines the chart spec for a Release.
	Chart *ReleaseSpecForProviderChart `field:"required" json:"chart" yaml:"chart"`
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
	PatchesFrom *[]*ReleaseSpecForProviderPatchesFrom `field:"optional" json:"patchesFrom" yaml:"patchesFrom"`
	Set *[]*ReleaseSpecForProviderSet `field:"optional" json:"set" yaml:"set"`
	Values interface{} `field:"optional" json:"values" yaml:"values"`
	ValuesFrom *[]*ReleaseSpecForProviderValuesFrom `field:"optional" json:"valuesFrom" yaml:"valuesFrom"`
	Wait *bool `field:"optional" json:"wait" yaml:"wait"`
}

