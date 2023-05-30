package helmcrossplaneio


// SetVal represents a "set" value override in a Release.
type ReleaseSpecForProviderSet struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Value *string `field:"optional" json:"value" yaml:"value"`
	// ValueFromSource represents source of a value.
	ValueFrom *ReleaseSpecForProviderSetValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

