package clustercivocrossplaneio


// NOTE: This can only be set at creation time.
//
// Changing this value after creation will not update the CNI.
type CivoKubernetesSpecCni string

const (
	// flannel.
	CivoKubernetesSpecCni_FLANNEL CivoKubernetesSpecCni = "FLANNEL"
	// cilium.
	CivoKubernetesSpecCni_CILIUM CivoKubernetesSpecCni = "CILIUM"
)

