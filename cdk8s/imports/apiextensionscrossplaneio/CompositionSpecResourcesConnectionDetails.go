package apiextensionscrossplaneio


// ConnectionDetail includes the information about the propagation of the connection information from one secret to another.
type CompositionSpecResourcesConnectionDetails struct {
	// FromConnectionSecretKey is the key that will be used to fetch the value from the composed resource's connection secret.
	FromConnectionSecretKey *string `field:"optional" json:"fromConnectionSecretKey" yaml:"fromConnectionSecretKey"`
	// FromFieldPath is the path of the field on the composed resource whose value to be used as input.
	//
	// Name must be specified if the type is FromFieldPath.
	FromFieldPath *string `field:"optional" json:"fromFieldPath" yaml:"fromFieldPath"`
	// Name of the connection secret key that will be propagated to the connection secret of the composition instance.
	//
	// Leave empty if you'd like to use the same key name.
	Name *string `field:"optional" json:"name" yaml:"name"`
	// Type sets the connection detail fetching behaviour to be used.
	//
	// Each connection detail type may require its own fields to be set on the ConnectionDetail object. If the type is omitted Crossplane will attempt to infer it based on which other fields were specified. If multiple fields are specified the order of precedence is: 1. FromValue 2. FromConnectionSecretKey 3. FromFieldPath
	Type CompositionSpecResourcesConnectionDetailsType `field:"optional" json:"type" yaml:"type"`
	// Value that will be propagated to the connection secret of the composite resource.
	//
	// May be set to inject a fixed, non-sensitive connection secret value, for example a well-known port.
	Value *string `field:"optional" json:"value" yaml:"value"`
}

