// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane-runtime/apis/common/v1

package v1

// A ManagementPolicy determines how should Crossplane controllers manage an
// external resource.
// +kubebuilder:validation:Enum=FullControl;ObserveOnly;OrphanOnDelete
#ManagementPolicy: string // #enumManagementPolicy

#enumManagementPolicy:
	#ManagementFullControl |
	#ManagementObserveOnly |
	#ManagementOrphanOnDelete

// ManagementFullControl means the external resource is fully controlled
// by Crossplane controllers, including its deletion.
#ManagementFullControl: #ManagementPolicy & "FullControl"

// ManagementObserveOnly means the external resource will only be observed
// by Crossplane controllers, but not modified or deleted.
#ManagementObserveOnly: #ManagementPolicy & "ObserveOnly"

// ManagementOrphanOnDelete means the external resource will be orphaned
// when its managed resource is deleted.
#ManagementOrphanOnDelete: #ManagementPolicy & "OrphanOnDelete"

// A DeletionPolicy determines what should happen to the underlying external
// resource when a managed resource is deleted.
// +kubebuilder:validation:Enum=Orphan;Delete
#DeletionPolicy: string // #enumDeletionPolicy

#enumDeletionPolicy:
	#DeletionOrphan |
	#DeletionDelete

// DeletionOrphan means the external resource will be orphaned when its
// managed resource is deleted.
#DeletionOrphan: #DeletionPolicy & "Orphan"

// DeletionDelete means both the  external resource will be deleted when its
// managed resource is deleted.
#DeletionDelete: #DeletionPolicy & "Delete"

// A CompositeDeletePolicy determines how the composite resource should be deleted
// when the corresponding claim is deleted.
// +kubebuilder:validation:Enum=Background;Foreground
#CompositeDeletePolicy: string // #enumCompositeDeletePolicy

#enumCompositeDeletePolicy:
	#CompositeDeleteBackground |
	#CompositeDeleteForeground

// CompositeDeleteBackground means the composite resource will be deleted using
// the Background Propagation Policy when the claim is deleted.
#CompositeDeleteBackground: #CompositeDeletePolicy & "Background"

// CompositeDeleteForeground means the composite resource will be deleted using
// the Foreground Propagation Policy when the claim is deleted.
#CompositeDeleteForeground: #CompositeDeletePolicy & "Foreground"

// An UpdatePolicy determines how something should be updated - either
// automatically (without human intervention) or manually.
// +kubebuilder:validation:Enum=Automatic;Manual
#UpdatePolicy: string // #enumUpdatePolicy

#enumUpdatePolicy:
	#UpdateAutomatic |
	#UpdateManual

// UpdateAutomatic means the resource should be updated automatically,
// without any human intervention.
#UpdateAutomatic: #UpdatePolicy & "Automatic"

// UpdateManual means the resource requires human intervention to
// update.
#UpdateManual: #UpdatePolicy & "Manual"

// ResolvePolicy is a type for resolve policy.
#ResolvePolicy: string // #enumResolvePolicy

#enumResolvePolicy:
	#ResolvePolicyAlways

// ResolutionPolicy is a type for resolution policy.
#ResolutionPolicy: string // #enumResolutionPolicy

#enumResolutionPolicy:
	#ResolutionPolicyRequired |
	#ResolutionPolicyOptional

// ResolvePolicyAlways is a resolve option.
// When the ResolvePolicy is set to ResolvePolicyAlways the reference will
// be tried to resolve for every reconcile loop.
#ResolvePolicyAlways: #ResolvePolicy & "Always"

// ResolutionPolicyRequired is a resolution option.
// When the ResolutionPolicy is set to ResolutionPolicyRequired the execution
// could not continue even if the reference cannot be resolved.
#ResolutionPolicyRequired: #ResolutionPolicy & "Required"

// ResolutionPolicyOptional is a resolution option.
// When the ReferenceResolutionPolicy is set to ReferencePolicyOptional the
// execution could continue even if the reference cannot be resolved.
#ResolutionPolicyOptional: #ResolutionPolicy & "Optional"
