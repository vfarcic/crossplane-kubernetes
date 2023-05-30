package helmcrossplaneio


// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
type ReleaseV1Beta1SpecDeletionPolicy string

const (
	// Orphan.
	ReleaseV1Beta1SpecDeletionPolicy_ORPHAN ReleaseV1Beta1SpecDeletionPolicy = "ORPHAN"
	// Delete.
	ReleaseV1Beta1SpecDeletionPolicy_DELETE ReleaseV1Beta1SpecDeletionPolicy = "DELETE"
)

