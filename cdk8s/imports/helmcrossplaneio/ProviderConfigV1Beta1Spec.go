package helmcrossplaneio


// A ProviderConfigSpec defines the desired state of a Provider.
type ProviderConfigV1Beta1Spec struct {
	// Credentials used to connect to the Kubernetes API.
	//
	// Typically a kubeconfig file. Use InjectedIdentity for in-cluster config.
	Credentials *ProviderConfigV1Beta1SpecCredentials `field:"required" json:"credentials" yaml:"credentials"`
	// Identity used to authenticate to the Kubernetes API.
	//
	// The identity credentials can be used to supplement kubeconfig 'credentials', for example by configuring a bearer token source such as OAuth.
	Identity *ProviderConfigV1Beta1SpecIdentity `field:"optional" json:"identity" yaml:"identity"`
}

