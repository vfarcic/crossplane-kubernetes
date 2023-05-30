package helmcrossplaneio


// A ChartSpec defines the chart spec for a Release.
type ReleaseSpecForProviderChart struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Repository *string `field:"required" json:"repository" yaml:"repository"`
	Version *string `field:"required" json:"version" yaml:"version"`
	// A SecretReference is a reference to a secret in an arbitrary namespace.
	PullSecretRef *ReleaseSpecForProviderChartPullSecretRef `field:"optional" json:"pullSecretRef" yaml:"pullSecretRef"`
}

