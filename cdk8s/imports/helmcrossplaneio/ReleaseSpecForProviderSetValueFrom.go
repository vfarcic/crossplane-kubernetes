package helmcrossplaneio


// ValueFromSource represents source of a value.
type ReleaseSpecForProviderSetValueFrom struct {
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	ConfigMapKeyRef *ReleaseSpecForProviderSetValueFromConfigMapKeyRef `field:"optional" json:"configMapKeyRef" yaml:"configMapKeyRef"`
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	SecretKeyRef *ReleaseSpecForProviderSetValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
}

