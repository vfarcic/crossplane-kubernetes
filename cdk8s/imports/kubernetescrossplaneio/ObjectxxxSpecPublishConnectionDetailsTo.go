package kubernetescrossplaneio

// PublishConnectionDetailsTo specifies the connection secret config which contains a name, metadata and a reference to secret store config to which any connection details for this managed resource should be written.
//
// Connection details frequently include the endpoint, username, and password required to connect to the managed resource.
type ObjectSpecPublishConnectionDetailsTo struct {
	// Name is the name of the connection secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret.
	ConfigRef *ObjectSpecPublishConnectionDetailsToConfigRef `field:"optional" json:"configRef" yaml:"configRef"`
	// Metadata is the metadata for connection secret.
	Metadata *ObjectSpecPublishConnectionDetailsToMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}
