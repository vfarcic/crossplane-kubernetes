package apiextensionscrossplaneio


// MatchTransformPattern is a transform that returns the value that matches a pattern.
type CompositionSpecResourcesPatchesTransformsMatchPatterns struct {
	// The value that is used as result of the transform if the pattern matches.
	Result interface{} `field:"required" json:"result" yaml:"result"`
	// Type specifies how the pattern matches the input.
	//
	// * `literal` - the pattern value has to exactly match (case sensitive) the input string. This is the default.
	// * `regexp` - the pattern treated as a regular expression against which the input string is tested. Crossplane will throw an error if the key is not a valid regexp.
	Type CompositionSpecResourcesPatchesTransformsMatchPatternsType `field:"required" json:"type" yaml:"type"`
	// Literal exactly matches the input string (case sensitive).
	//
	// Is required if `type` is `literal`.
	Literal *string `field:"optional" json:"literal" yaml:"literal"`
	// Regexp to match against the input string.
	//
	// Is required if `type` is `regexp`.
	Regexp *string `field:"optional" json:"regexp" yaml:"regexp"`
}

