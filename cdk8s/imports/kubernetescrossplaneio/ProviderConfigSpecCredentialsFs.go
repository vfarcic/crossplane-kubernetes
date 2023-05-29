package kubernetescrossplaneio


// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
type ProviderConfigSpecCredentialsFs struct {
	// Path is a filesystem path.
	Path *string `field:"required" json:"path" yaml:"path"`
}

