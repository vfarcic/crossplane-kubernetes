package kubernetescrossplaneio

// DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either "Delete" or "Orphan" the external resource.
type ObjectSpecDeletionPolicy string

const (
	// Orphan.
	ObjectSpecDeletionPolicy_ORPHAN ObjectSpecDeletionPolicy = "ORPHAN"
	// Delete.
	ObjectSpecDeletionPolicy_DELETE ObjectSpecDeletionPolicy = "DELETE"
)
