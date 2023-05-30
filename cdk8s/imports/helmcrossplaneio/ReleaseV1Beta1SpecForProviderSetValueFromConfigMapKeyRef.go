package helmcrossplaneio


// DataKeySelector defines required spec to access a key of a configmap or secret.
type ReleaseV1Beta1SpecForProviderSetValueFromConfigMapKeyRef struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Namespace *string `field:"required" json:"namespace" yaml:"namespace"`
	Key *string `field:"optional" json:"key" yaml:"key"`
	Optional *bool `field:"optional" json:"optional" yaml:"optional"`
}

