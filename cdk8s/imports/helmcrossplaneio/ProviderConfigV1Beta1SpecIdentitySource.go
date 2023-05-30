package helmcrossplaneio


// Source of the provider credentials.
type ProviderConfigV1Beta1SpecIdentitySource string

const (
	// None.
	ProviderConfigV1Beta1SpecIdentitySource_NONE ProviderConfigV1Beta1SpecIdentitySource = "NONE"
	// Secret.
	ProviderConfigV1Beta1SpecIdentitySource_SECRET ProviderConfigV1Beta1SpecIdentitySource = "SECRET"
	// InjectedIdentity.
	ProviderConfigV1Beta1SpecIdentitySource_INJECTED_IDENTITY ProviderConfigV1Beta1SpecIdentitySource = "INJECTED_IDENTITY"
	// Environment.
	ProviderConfigV1Beta1SpecIdentitySource_ENVIRONMENT ProviderConfigV1Beta1SpecIdentitySource = "ENVIRONMENT"
	// Filesystem.
	ProviderConfigV1Beta1SpecIdentitySource_FILESYSTEM ProviderConfigV1Beta1SpecIdentitySource = "FILESYSTEM"
)

