package apiextensionscrossplaneio


// Transform is a unit of process whose input is transformed into an output with the supplied configuration.
type CompositionSpecPatchSetsPatchesTransforms struct {
	// Type of the transform to be run.
	Type CompositionSpecPatchSetsPatchesTransformsType `field:"required" json:"type" yaml:"type"`
	// Convert is used to cast the input into the given output type.
	Convert *CompositionSpecPatchSetsPatchesTransformsConvert `field:"optional" json:"convert" yaml:"convert"`
	// Map uses the input as a key in the given map and returns the value.
	Map *map[string]interface{} `field:"optional" json:"map" yaml:"map"`
	// Match is a more complex version of Map that matches a list of patterns.
	Match *CompositionSpecPatchSetsPatchesTransformsMatch `field:"optional" json:"match" yaml:"match"`
	// Math is used to transform the input via mathematical operations such as multiplication.
	Math *CompositionSpecPatchSetsPatchesTransformsMath `field:"optional" json:"math" yaml:"math"`
	// String is used to transform the input into a string or a different kind of string.
	//
	// Note that the input does not necessarily need to be a string.
	String *CompositionSpecPatchSetsPatchesTransformsString `field:"optional" json:"string" yaml:"string"`
}

