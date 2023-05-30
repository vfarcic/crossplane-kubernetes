package helmcrossplaneio


// A SecretReference is a reference to a secret in an arbitrary namespace.
type ReleaseSpecForProviderChartPullSecretRef struct {
	// Name of the secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Namespace of the secret.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
}

