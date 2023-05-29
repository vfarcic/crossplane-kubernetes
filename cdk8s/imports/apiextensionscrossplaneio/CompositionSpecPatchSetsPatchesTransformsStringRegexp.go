package apiextensionscrossplaneio


// Extract a match from the input using a regular expression.
type CompositionSpecPatchSetsPatchesTransformsStringRegexp struct {
	// Match string.
	//
	// May optionally include submatches, aka capture groups. See https://pkg.go.dev/regexp/ for details.
	Match *string `field:"required" json:"match" yaml:"match"`
	// Group number to match.
	//
	// 0 (the default) matches the entire expression.
	Group *float64 `field:"optional" json:"group" yaml:"group"`
}

