package helmcrossplaneio


// Source of the provider credentials.
type ProviderConfigSpecIdentitySource string

const (
	// None.
	ProviderConfigSpecIdentitySource_NONE ProviderConfigSpecIdentitySource = "NONE"
	// Secret.
	ProviderConfigSpecIdentitySource_SECRET ProviderConfigSpecIdentitySource = "SECRET"
	// InjectedIdentity.
	ProviderConfigSpecIdentitySource_INJECTED_IDENTITY ProviderConfigSpecIdentitySource = "INJECTED_IDENTITY"
	// Environment.
	ProviderConfigSpecIdentitySource_ENVIRONMENT ProviderConfigSpecIdentitySource = "ENVIRONMENT"
	// Filesystem.
	ProviderConfigSpecIdentitySource_FILESYSTEM ProviderConfigSpecIdentitySource = "FILESYSTEM"
)

