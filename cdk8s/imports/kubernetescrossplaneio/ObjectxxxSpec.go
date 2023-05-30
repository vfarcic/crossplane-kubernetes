package kubernetescrossplaneio

// A ObjectSpec defines the desired state of a Object.
type ObjectSpec struct {
	// ObjectParameters are the configurable fields of a Object.
	ForProvider *ObjectSpecForProvider `field:"required" json:"forProvider" yaml:"forProvider"`
	// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
	DeletionPolicy ObjectSpecDeletionPolicy `field:"optional" json:"deletionPolicy" yaml:"deletionPolicy"`
	// A ManagementPolicy determines what should happen to the underlying external resource when a managed resource is created, updated, deleted, or observed.
	ManagementPolicy ObjectSpecManagementPolicy `field:"optional" json:"managementPolicy" yaml:"managementPolicy"`
	// ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured.
	ProviderConfigRef *ObjectSpecProviderConfigRef `field:"optional" json:"providerConfigRef" yaml:"providerConfigRef"`
	// ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource.
	//
	// Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`
	ProviderRef *ObjectSpecProviderRef `field:"optional" json:"providerRef" yaml:"providerRef"`
	// PublishConnectionDetailsTo specifies the connection secret config which contains a name, metadata and a reference to secret store config to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
	PublishConnectionDetailsTo *ObjectSpecPublishConnectionDetailsTo `field:"optional" json:"publishConnectionDetailsTo" yaml:"publishConnectionDetailsTo"`
	References                 *[]*ObjectSpecReferences              `field:"optional" json:"references" yaml:"references"`
	// WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource. This field is planned to be replaced in a future release in favor of PublishConnectionDetailsTo. Currently, both could be set independently and connection details would be published to both without affecting each other.
	WriteConnectionSecretToRef *ObjectSpecWriteConnectionSecretToRef `field:"optional" json:"writeConnectionSecretToRef" yaml:"writeConnectionSecretToRef"`
}
