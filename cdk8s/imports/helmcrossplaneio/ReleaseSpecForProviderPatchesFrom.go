package helmcrossplaneio


// ValueFromSource represents source of a value.
type ReleaseSpecForProviderPatchesFrom struct {
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	ConfigMapKeyRef *ReleaseSpecForProviderPatchesFromConfigMapKeyRef `field:"optional" json:"configMapKeyRef" yaml:"configMapKeyRef"`
	// DataKeySelector defines required spec to access a key of a configmap or secret.
	SecretKeyRef *ReleaseSpecForProviderPatchesFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
}

