package kubernetescrossplaneio


// A ProviderConfigSpec defines the desired state of a ProviderConfig.
type ProviderConfigSpec struct {
	// Credentials used to connect to the Kubernetes API.
	//
	// Typically a kubeconfig file. Use InjectedIdentity for in-cluster config.
	Credentials *ProviderConfigSpecCredentials `field:"required" json:"credentials" yaml:"credentials"`
	// Identity used to authenticate to the Kubernetes API.
	//
	// The identity credentials can be used to supplement kubeconfig 'credentials', for example by configuring a bearer token source such as OAuth.
	Identity *ProviderConfigSpecIdentity `field:"optional" json:"identity" yaml:"identity"`
}

