package helmcrossplaneio


// A ChartSpec defines the chart spec for a Release.
type ReleaseV1Beta1SpecForProviderChart struct {
	// Name of Helm chart, required if ChartSpec.URL not set.
	Name *string `field:"optional" json:"name" yaml:"name"`
	// PullSecretRef is reference to the secret containing credentials to helm repository.
	PullSecretRef *ReleaseV1Beta1SpecForProviderChartPullSecretRef `field:"optional" json:"pullSecretRef" yaml:"pullSecretRef"`
	// Repository: Helm repository URL, required if ChartSpec.URL not set.
	Repository *string `field:"optional" json:"repository" yaml:"repository"`
	// URL to chart package (typically .tgz), optional and overrides others fields in the spec.
	Url *string `field:"optional" json:"url" yaml:"url"`
	// Version of Helm chart, late initialized with latest version if not set.
	Version *string `field:"optional" json:"version" yaml:"version"`
}

