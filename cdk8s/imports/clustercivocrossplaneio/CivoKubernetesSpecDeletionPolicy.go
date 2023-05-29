package clustercivocrossplaneio


// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
//
// The "Delete" policy is the default when no policy is specified.
type CivoKubernetesSpecDeletionPolicy string

const (
	// Orphan.
	CivoKubernetesSpecDeletionPolicy_ORPHAN CivoKubernetesSpecDeletionPolicy = "ORPHAN"
	// Delete.
	CivoKubernetesSpecDeletionPolicy_DELETE CivoKubernetesSpecDeletionPolicy = "DELETE"
)

