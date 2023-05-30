package helmcrossplaneio


// Metadata is the metadata for connection secret.
type ReleaseV1Beta1SpecPublishConnectionDetailsToMetadata struct {
	// Annotations are the annotations to be added to connection secret.
	//
	// - For Kubernetes secrets, this will be used as "metadata.annotations". - It is up to Secret Store implementation for others store types.
	Annotations *map[string]*string `field:"optional" json:"annotations" yaml:"annotations"`
	// Labels are the labels/tags to be added to connection secret.
	//
	// - For Kubernetes secrets, this will be used as "metadata.labels". - It is up to Secret Store implementation for others store types.
	Labels *map[string]*string `field:"optional" json:"labels" yaml:"labels"`
	// Type is the SecretType for the connection secret.
	//
	// - Only valid for Kubernetes Secret Stores.
	Type *string `field:"optional" json:"type" yaml:"type"`
}

