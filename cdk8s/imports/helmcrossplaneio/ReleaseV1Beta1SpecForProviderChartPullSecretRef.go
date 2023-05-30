package helmcrossplaneio


// PullSecretRef is reference to the secret containing credentials to helm repository.
type ReleaseV1Beta1SpecForProviderChartPullSecretRef struct {
	// Name of the secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Namespace of the secret.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
}

