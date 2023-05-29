package kubernetescrossplaneio


// Source of the provider credentials.
type ProviderConfigSpecCredentialsSource string

const (
	// None.
	ProviderConfigSpecCredentialsSource_NONE ProviderConfigSpecCredentialsSource = "NONE"
	// Secret.
	ProviderConfigSpecCredentialsSource_SECRET ProviderConfigSpecCredentialsSource = "SECRET"
	// InjectedIdentity.
	ProviderConfigSpecCredentialsSource_INJECTED_IDENTITY ProviderConfigSpecCredentialsSource = "INJECTED_IDENTITY"
	// Environment.
	ProviderConfigSpecCredentialsSource_ENVIRONMENT ProviderConfigSpecCredentialsSource = "ENVIRONMENT"
	// Filesystem.
	ProviderConfigSpecCredentialsSource_FILESYSTEM ProviderConfigSpecCredentialsSource = "FILESYSTEM"
)

