package helmcrossplaneio


// Credentials used to connect to the Kubernetes API.
//
// Typically a kubeconfig file. Use InjectedIdentity for in-cluster config.
type ProviderConfigSpecCredentials struct {
	// Source of the provider credentials.
	Source ProviderConfigSpecCredentialsSource `field:"required" json:"source" yaml:"source"`
	// Env is a reference to an environment variable that contains credentials that must be used to connect to the provider.
	Env *ProviderConfigSpecCredentialsEnv `field:"optional" json:"env" yaml:"env"`
	// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
	Fs *ProviderConfigSpecCredentialsFs `field:"optional" json:"fs" yaml:"fs"`
	// A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider.
	SecretRef *ProviderConfigSpecCredentialsSecretRef `field:"optional" json:"secretRef" yaml:"secretRef"`
}

