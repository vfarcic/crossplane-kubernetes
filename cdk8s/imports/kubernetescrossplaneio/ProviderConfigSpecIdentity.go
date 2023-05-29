package kubernetescrossplaneio


// Identity used to authenticate to the Kubernetes API.
//
// The identity credentials can be used to supplement kubeconfig 'credentials', for example by configuring a bearer token source such as OAuth.
type ProviderConfigSpecIdentity struct {
	// Source of the provider credentials.
	Source ProviderConfigSpecIdentitySource `field:"required" json:"source" yaml:"source"`
	// Type of identity.
	Type ProviderConfigSpecIdentityType `field:"required" json:"type" yaml:"type"`
	// Env is a reference to an environment variable that contains credentials that must be used to connect to the provider.
	Env *ProviderConfigSpecIdentityEnv `field:"optional" json:"env" yaml:"env"`
	// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
	Fs *ProviderConfigSpecIdentityFs `field:"optional" json:"fs" yaml:"fs"`
	// A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider.
	SecretRef *ProviderConfigSpecIdentitySecretRef `field:"optional" json:"secretRef" yaml:"secretRef"`
}

