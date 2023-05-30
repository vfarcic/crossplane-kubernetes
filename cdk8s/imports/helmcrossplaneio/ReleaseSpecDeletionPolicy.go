package helmcrossplaneio


// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
type ReleaseSpecDeletionPolicy string

const (
	// Orphan.
	ReleaseSpecDeletionPolicy_ORPHAN ReleaseSpecDeletionPolicy = "ORPHAN"
	// Delete.
	ReleaseSpecDeletionPolicy_DELETE ReleaseSpecDeletionPolicy = "DELETE"
)

