package helmcrossplaneio


// PublishConnectionDetailsTo specifies the connection secret config which contains a name, metadata and a reference to secret store config to which any connection details for this managed resource should be written.
//
// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
type ReleaseV1Beta1SpecPublishConnectionDetailsTo struct {
	// Name is the name of the connection secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret.
	ConfigRef *ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRef `field:"optional" json:"configRef" yaml:"configRef"`
	// Metadata is the metadata for connection secret.
	Metadata *ReleaseV1Beta1SpecPublishConnectionDetailsToMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

