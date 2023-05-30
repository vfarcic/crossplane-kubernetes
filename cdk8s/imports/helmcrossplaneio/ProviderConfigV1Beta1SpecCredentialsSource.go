package helmcrossplaneio


// Source of the provider credentials.
type ProviderConfigV1Beta1SpecCredentialsSource string

const (
	// None.
	ProviderConfigV1Beta1SpecCredentialsSource_NONE ProviderConfigV1Beta1SpecCredentialsSource = "NONE"
	// Secret.
	ProviderConfigV1Beta1SpecCredentialsSource_SECRET ProviderConfigV1Beta1SpecCredentialsSource = "SECRET"
	// InjectedIdentity.
	ProviderConfigV1Beta1SpecCredentialsSource_INJECTED_IDENTITY ProviderConfigV1Beta1SpecCredentialsSource = "INJECTED_IDENTITY"
	// Environment.
	ProviderConfigV1Beta1SpecCredentialsSource_ENVIRONMENT ProviderConfigV1Beta1SpecCredentialsSource = "ENVIRONMENT"
	// Filesystem.
	ProviderConfigV1Beta1SpecCredentialsSource_FILESYSTEM ProviderConfigV1Beta1SpecCredentialsSource = "FILESYSTEM"
)

