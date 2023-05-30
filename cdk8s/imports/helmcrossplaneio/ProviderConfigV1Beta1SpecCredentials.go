package helmcrossplaneio


// Credentials used to connect to the Kubernetes API.
//
// Typically a kubeconfig file. Use InjectedIdentity for in-cluster config.
type ProviderConfigV1Beta1SpecCredentials struct {
	// Source of the provider credentials.
	Source ProviderConfigV1Beta1SpecCredentialsSource `field:"required" json:"source" yaml:"source"`
	// Env is a reference to an environment variable that contains credentials that must be used to connect to the provider.
	Env *ProviderConfigV1Beta1SpecCredentialsEnv `field:"optional" json:"env" yaml:"env"`
	// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
	Fs *ProviderConfigV1Beta1SpecCredentialsFs `field:"optional" json:"fs" yaml:"fs"`
	// A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider.
	SecretRef *ProviderConfigV1Beta1SpecCredentialsSecretRef `field:"optional" json:"secretRef" yaml:"secretRef"`
}

