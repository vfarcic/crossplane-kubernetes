package instancecivocrossplaneio


// CivoInstanceConfig specs for the CivoInstance.
type CivoInstanceSpecInstanceConfig struct {
	DiskImage *string `field:"optional" json:"diskImage" yaml:"diskImage"`
	Hostname *string `field:"optional" json:"hostname" yaml:"hostname"`
	InitialUser *string `field:"optional" json:"initialUser" yaml:"initialUser"`
	Notes *string `field:"optional" json:"notes" yaml:"notes"`
	PublicIpRequired *string `field:"optional" json:"publicIpRequired" yaml:"publicIpRequired"`
	Region *string `field:"optional" json:"region" yaml:"region"`
	Script *string `field:"optional" json:"script" yaml:"script"`
	Size *string `field:"optional" json:"size" yaml:"size"`
	// SecretReference location of the SSH Public Key Secret.
	SshPubKeyRef *CivoInstanceSpecInstanceConfigSshPubKeyRef `field:"optional" json:"sshPubKeyRef" yaml:"sshPubKeyRef"`
	Tags *[]*string `field:"optional" json:"tags" yaml:"tags"`
}

