package helmcrossplaneio


// Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider.
type ProviderConfigV1Beta1SpecCredentialsFs struct {
	// Path is a filesystem path.
	Path *string `field:"required" json:"path" yaml:"path"`
}

