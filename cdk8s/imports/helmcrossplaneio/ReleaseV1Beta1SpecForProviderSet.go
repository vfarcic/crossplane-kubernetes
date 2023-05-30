package helmcrossplaneio


// SetVal represents a "set" value override in a Release.
type ReleaseV1Beta1SpecForProviderSet struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Value *string `field:"optional" json:"value" yaml:"value"`
	// ValueFromSource represents source of a value.
	ValueFrom *ReleaseV1Beta1SpecForProviderSetValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

