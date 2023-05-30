package helmcrossplaneio


// A ReleaseSpec defines the desired state of a Release.
type ReleaseV1Beta1Spec struct {
	// ReleaseParameters are the configurable fields of a Release.
	ForProvider *ReleaseV1Beta1SpecForProvider `field:"required" json:"forProvider" yaml:"forProvider"`
	ConnectionDetails *[]*ReleaseV1Beta1SpecConnectionDetails `field:"optional" json:"connectionDetails" yaml:"connectionDetails"`
	// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
	DeletionPolicy ReleaseV1Beta1SpecDeletionPolicy `field:"optional" json:"deletionPolicy" yaml:"deletionPolicy"`
	// ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured.
	ProviderConfigRef *ReleaseV1Beta1SpecProviderConfigRef `field:"optional" json:"providerConfigRef" yaml:"providerConfigRef"`
	// ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource.
	//
	// Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`
	ProviderRef *ReleaseV1Beta1SpecProviderRef `field:"optional" json:"providerRef" yaml:"providerRef"`
	// PublishConnectionDetailsTo specifies the connection secret config which contains a name, metadata and a reference to secret store config to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
	PublishConnectionDetailsTo *ReleaseV1Beta1SpecPublishConnectionDetailsTo `field:"optional" json:"publishConnectionDetailsTo" yaml:"publishConnectionDetailsTo"`
	// RollbackRetriesLimit is max number of attempts to retry Helm deployment by rolling back the release.
	RollbackLimit *float64 `field:"optional" json:"rollbackLimit" yaml:"rollbackLimit"`
	// WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource. This field is planned to be replaced in a future release in favor of PublishConnectionDetailsTo. Currently, both could be set independently and connection details would be published to both without affecting each other.
	WriteConnectionSecretToRef *ReleaseV1Beta1SpecWriteConnectionSecretToRef `field:"optional" json:"writeConnectionSecretToRef" yaml:"writeConnectionSecretToRef"`
}

