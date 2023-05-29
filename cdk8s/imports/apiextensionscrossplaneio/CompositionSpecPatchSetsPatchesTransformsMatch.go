package apiextensionscrossplaneio


// Match is a more complex version of Map that matches a list of patterns.
type CompositionSpecPatchSetsPatchesTransformsMatch struct {
	// Determines to what value the transform should fallback if no pattern matches.
	FallbackTo CompositionSpecPatchSetsPatchesTransformsMatchFallbackTo `field:"optional" json:"fallbackTo" yaml:"fallbackTo"`
	// The fallback value that should be returned by the transform if now pattern matches.
	FallbackValue interface{} `field:"optional" json:"fallbackValue" yaml:"fallbackValue"`
	// The patterns that should be tested against the input string.
	//
	// Patterns are tested in order. The value of the first match is used as result of this transform.
	Patterns *[]*CompositionSpecPatchSetsPatchesTransformsMatchPatterns `field:"optional" json:"patterns" yaml:"patterns"`
}

