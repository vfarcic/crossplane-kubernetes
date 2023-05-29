package clustercivocrossplaneio


// CivoKubernetesConnectionDetails is the desired output secret to store connection information.
type CivoKubernetesSpecConnectionDetails struct {
	ConnectionSecretNamePrefix *string `field:"required" json:"connectionSecretNamePrefix" yaml:"connectionSecretNamePrefix"`
	ConnectionSecretNamespace *string `field:"required" json:"connectionSecretNamespace" yaml:"connectionSecretNamespace"`
}

