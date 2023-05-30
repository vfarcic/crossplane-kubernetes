package kubernetescrossplaneio

// A ManagementPolicy determines what should happen to the underlying external resource when a managed resource is created, updated, deleted, or observed.
type ObjectSpecManagementPolicy string

const (
	// Default.
	ObjectSpecManagementPolicy_DEFAULT ObjectSpecManagementPolicy = "DEFAULT"
	// ObserveCreateUpdate.
	ObjectSpecManagementPolicy_OBSERVE_CREATE_UPDATE ObjectSpecManagementPolicy = "OBSERVE_CREATE_UPDATE"
	// ObserveDelete.
	ObjectSpecManagementPolicy_OBSERVE_DELETE ObjectSpecManagementPolicy = "OBSERVE_DELETE"
	// Observe.
	ObjectSpecManagementPolicy_OBSERVE ObjectSpecManagementPolicy = "OBSERVE"
)
