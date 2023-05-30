package helmcrossplaneio


// ValueFromSource represents source of a value.
type ReleaseV1Beta1SpecForProviderSetValueFrom struct {
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	ConfigMapKeyRef *ReleaseV1Beta1SpecForProviderSetValueFromConfigMapKeyRef `field:"optional" json:"configMapKeyRef" yaml:"configMapKeyRef"`
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	SecretKeyRef *ReleaseV1Beta1SpecForProviderSetValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
}

