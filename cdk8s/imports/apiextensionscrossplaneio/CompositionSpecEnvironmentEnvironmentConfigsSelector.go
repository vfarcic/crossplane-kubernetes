package apiextensionscrossplaneio


// Selector selects one EnvironmentConfig via labels.
type CompositionSpecEnvironmentEnvironmentConfigsSelector struct {
	// MatchLabels ensures an object with matching labels is selected.
	MatchLabels *[]*CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabels `field:"optional" json:"matchLabels" yaml:"matchLabels"`
}

