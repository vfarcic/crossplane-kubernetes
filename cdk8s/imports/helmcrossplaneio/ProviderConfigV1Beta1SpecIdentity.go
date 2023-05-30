package helmcrossplaneio


// Identity used to authenticate to the Kubernetes API.
//
// The identity credentials can be used to supplement kubeconfig 'credentials', for example by configuring a bearer token source such as OAuth.
type ProviderConfigV1Beta1SpecIdentity struct {
	// Source of the provider credentials.
	Source ProviderConfigV1Beta1SpecIdentitySource `field:"required" json:"source" yaml:"source"`
	// Type of identity.
	Type ProviderConfigV1Beta1SpecIdentityType `field:"required" json:"type" yaml:"type"`
	// Env is a reference to an environment variable that contains credentials that must be used to connect to the provider.
	Env *ProviderConfigV1Beta1SpecIdentityEnv `field:"optional" json:"env" yaml:"env"`
	// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
	Fs *ProviderConfigV1Beta1SpecIdentityFs `field:"optional" json:"fs" yaml:"fs"`
	// A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider.
	SecretRef *ProviderConfigV1Beta1SpecIdentitySecretRef `field:"optional" json:"secretRef" yaml:"secretRef"`
}

