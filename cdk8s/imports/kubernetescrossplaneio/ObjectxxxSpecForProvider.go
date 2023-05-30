package kubernetescrossplaneio

// ObjectParameters are the configurable fields of a Object.
type ObjectSpecForProvider struct {
	// Raw JSON representation of the kubernetes object to be created.
	Manifest interface{} `field:"required" json:"manifest" yaml:"manifest"`
}
