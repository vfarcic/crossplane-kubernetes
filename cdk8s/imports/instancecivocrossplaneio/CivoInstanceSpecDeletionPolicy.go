package instancecivocrossplaneio


// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
//
// The "Delete" policy is the default when no policy is specified.
type CivoInstanceSpecDeletionPolicy string

const (
	// Orphan.
	CivoInstanceSpecDeletionPolicy_ORPHAN CivoInstanceSpecDeletionPolicy = "ORPHAN"
	// Delete.
	CivoInstanceSpecDeletionPolicy_DELETE CivoInstanceSpecDeletionPolicy = "DELETE"
)

