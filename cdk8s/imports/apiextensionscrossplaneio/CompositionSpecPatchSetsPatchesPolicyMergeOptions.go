package apiextensionscrossplaneio


// MergeOptions Specifies merge options on a field path.
type CompositionSpecPatchSetsPatchesPolicyMergeOptions struct {
	// Specifies that already existing elements in a merged slice should be preserved.
	AppendSlice *bool `field:"optional" json:"appendSlice" yaml:"appendSlice"`
	// Specifies that already existing values in a merged map should be preserved.
	KeepMapValues *bool `field:"optional" json:"keepMapValues" yaml:"keepMapValues"`
}

