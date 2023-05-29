package clustercivocrossplaneio


// KubernetesClusterPoolConfig is used to create a new cluster pool.
type CivoKubernetesSpecPools struct {
	Count *float64 `field:"optional" json:"count" yaml:"count"`
	Id *string `field:"optional" json:"id" yaml:"id"`
	Size *string `field:"optional" json:"size" yaml:"size"`
}

