package clustercivocrossplaneio


// A CivoKubernetesSpec defines the desired state of a CivoKubernetes.
type CivoKubernetesSpec struct {
	// CivoKubernetesConnectionDetails is the desired output secret to store connection information.
	ConnectionDetails *CivoKubernetesSpecConnectionDetails `field:"required" json:"connectionDetails" yaml:"connectionDetails"`
	Name *string `field:"required" json:"name" yaml:"name"`
	Pools *[]*CivoKubernetesSpecPools `field:"required" json:"pools" yaml:"pools"`
	// A list of applications to install from civo marketplace.
	Applications *[]*string `field:"optional" json:"applications" yaml:"applications"`
	// NOTE: This can only be set at creation time.
	//
	// Changing this value after creation will not update the CNI.
	Cni CivoKubernetesSpecCni `field:"optional" json:"cni" yaml:"cni"`
	// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
	//
	// The "Delete" policy is the default when no policy is specified.
	DeletionPolicy CivoKubernetesSpecDeletionPolicy `field:"optional" json:"deletionPolicy" yaml:"deletionPolicy"`
	// ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured.
	ProviderConfigRef *CivoKubernetesSpecProviderConfigRef `field:"optional" json:"providerConfigRef" yaml:"providerConfigRef"`
	// ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource.
	//
	// Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`
	ProviderRef *CivoKubernetesSpecProviderRef `field:"optional" json:"providerRef" yaml:"providerRef"`
	// If not set, the default kubernetes version(1.22.2-k31) will be used. If set, the value must be a valid kubernetes version, you can use the following command to get the valid versions: `civo k3s versions` Changing the version to a higher version will upgrade the cluster. Note that this may cause breaking changes to the Kubernetes API so please check kubernetes deprecations/mitigations before upgrading.
	Version *string `field:"optional" json:"version" yaml:"version"`
	// WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written.
	//
	// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
	WriteConnectionSecretToRef *CivoKubernetesSpecWriteConnectionSecretToRef `field:"optional" json:"writeConnectionSecretToRef" yaml:"writeConnectionSecretToRef"`
}

