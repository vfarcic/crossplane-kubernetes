package kubernetescrossplaneio


// A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider.
type ProviderConfigSpecIdentitySecretRef struct {
	// The key to select.
	Key *string `field:"required" json:"key" yaml:"key"`
	// Name of the secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Namespace of the secret.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
}

