package apiextensionscrossplaneio


// CompositionSpec specifies desired state of a composition.
type CompositionSpec struct {
	// CompositeTypeRef specifies the type of composite resource that this composition is compatible with.
	CompositeTypeRef *CompositionSpecCompositeTypeRef `field:"required" json:"compositeTypeRef" yaml:"compositeTypeRef"`
	// Environment configures the environment in which resources are rendered.
	//
	// THIS IS AN ALPHA FIELD. Do not use it in production. It is not honored unless the relevant Crossplane feature flag is enabled, and may be changed or removed without notice.
	Environment *CompositionSpecEnvironment `field:"optional" json:"environment" yaml:"environment"`
	// Functions is list of Composition Functions that will be used when a composite resource referring to this composition is created.
	//
	// At least one of resources and functions must be specified. If both are specified the resources will be rendered first, then passed to the functions for further processing.
	// THIS IS AN ALPHA FIELD. Do not use it in production. It is not honored unless the relevant Crossplane feature flag is enabled, and may be changed or removed without notice.
	Functions *[]*CompositionSpecFunctions `field:"optional" json:"functions" yaml:"functions"`
	// PatchSets define a named set of patches that may be included by any resource in this Composition.
	//
	// PatchSets cannot themselves refer to other PatchSets.
	PatchSets *[]*CompositionSpecPatchSets `field:"optional" json:"patchSets" yaml:"patchSets"`
	// PublishConnectionDetailsWithStoreConfig specifies the secret store config with which the connection details of composite resources dynamically provisioned using this composition will be published.
	//
	// THIS IS AN ALPHA FIELD. Do not use it in production. It is not honored unless the relevant Crossplane feature flag is enabled, and may be changed or removed without notice.
	PublishConnectionDetailsWithStoreConfigRef *CompositionSpecPublishConnectionDetailsWithStoreConfigRef `field:"optional" json:"publishConnectionDetailsWithStoreConfigRef" yaml:"publishConnectionDetailsWithStoreConfigRef"`
	// Resources is a list of resource templates that will be used when a composite resource referring to this composition is created.
	//
	// At least one of resources and functions must be specififed. If both are specified the resources will be rendered first, then passed to the functions for further processing.
	Resources *[]*CompositionSpecResources `field:"optional" json:"resources" yaml:"resources"`
	// WriteConnectionSecretsToNamespace specifies the namespace in which the connection secrets of composite resource dynamically provisioned using this composition will be created.
	//
	// This field is planned to be replaced in a future release in favor of PublishConnectionDetailsWithStoreConfigRef. Currently, both could be set independently and connection details would be published to both without affecting each other as long as related fields at MR level specified.
	WriteConnectionSecretsToNamespace *string `field:"optional" json:"writeConnectionSecretsToNamespace" yaml:"writeConnectionSecretsToNamespace"`
}

