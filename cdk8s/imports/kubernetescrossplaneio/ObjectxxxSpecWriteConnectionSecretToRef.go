package kubernetescrossplaneio

// WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written.
//
// Connection details frequently include the endpoint, username, and password required to connect to the managed resource. This field is planned to be replaced in a future release in favor of PublishConnectionDetailsTo. Currently, both could be set independently and connection details would be published to both without affecting each other.
type ObjectSpecWriteConnectionSecretToRef struct {
	// Name of the secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Namespace of the secret.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
}
