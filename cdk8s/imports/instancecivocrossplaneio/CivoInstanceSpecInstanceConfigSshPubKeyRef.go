package instancecivocrossplaneio


// SecretReference location of the SSH Public Key Secret.
type CivoInstanceSpecInstanceConfigSshPubKeyRef struct {
	// Key whose value will be used.
	Key *string `field:"required" json:"key" yaml:"key"`
	// Name of the secret.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Namespace of the secret.
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
}

