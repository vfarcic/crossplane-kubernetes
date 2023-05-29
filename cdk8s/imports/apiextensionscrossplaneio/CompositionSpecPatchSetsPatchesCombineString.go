package apiextensionscrossplaneio


// String declares that input variables should be combined into a single string, using the relevant settings for formatting purposes.
type CompositionSpecPatchSetsPatchesCombineString struct {
	// Format the input using a Go format string.
	//
	// See https://golang.org/pkg/fmt/ for details.
	Fmt *string `field:"required" json:"fmt" yaml:"fmt"`
}

