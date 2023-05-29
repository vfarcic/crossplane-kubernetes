package instancecivocrossplaneio


// CivoInstanceSpec holds the instanceConfig.
type CivoInstanceSpec struct {
	// CivoInstanceConfig specs for the CivoInstance.
	InstanceConfig *CivoInstanceSpecInstanceConfig `field:"required" json:"instanceConfig" yaml:"instanceConfig"`
	// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
	//
	// The "Delete" policy is the default when no policy is specified.
	DeletionPolicy CivoInstanceSpecDeletionPolicy `field:"optional" json:"deletionPolicy" yaml:"deletionPolicy"`
	// ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured.
	ProviderConfigRef *CivoInstanceSpecProviderConfigRef `field:"optional" json:"providerConfigRef" yaml:"providerConfigRef"`
	// ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource.
	//
	// Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`
	ProviderRef *CivoInstanceSpecProviderRef `field:"optional" json:"providerRef" yaml:"providerRef"`
	// WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
	WriteConnectionSecretToRef *CivoInstanceSpecWriteConnectionSecretToRef `field:"optional" json:"writeConnectionSecretToRef" yaml:"writeConnectionSecretToRef"`
}

