package apiextensionscrossplaneio


// An EnvironmentSourceSelectorLabelMatcher acts like a k8s label selector but can draw the label value from a different path.
type CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabels struct {
	// Key of the label to match.
	Key *string `field:"required" json:"key" yaml:"key"`
	// Type specifies where the value for a label comes from.
	Type CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabelsType `field:"optional" json:"type" yaml:"type"`
	// Value specifies a literal label value.
	Value *string `field:"optional" json:"value" yaml:"value"`
	// ValueFromFieldPath specifies the field path to look for the label value.
	ValueFromFieldPath *string `field:"optional" json:"valueFromFieldPath" yaml:"valueFromFieldPath"`
}

