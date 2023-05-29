package apiextensionscrossplaneio


// A CombineVariable defines the source of a value that is combined with others to form and patch an output value.
//
// Currently, this only supports retrieving values from a field path.
type CompositionSpecPatchSetsPatchesCombineVariables struct {
	// FromFieldPath is the path of the field on the source whose value is to be used as input.
	FromFieldPath *string `field:"required" json:"fromFieldPath" yaml:"fromFieldPath"`
}

