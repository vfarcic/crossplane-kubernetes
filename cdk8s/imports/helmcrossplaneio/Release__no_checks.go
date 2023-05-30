//go:build no_runtime_type_checking

package helmcrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateRelease_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateRelease_IsConstructParameters(x interface{}) error {
	return nil
}

func validateRelease_ManifestParameters(props *ReleaseProps) error {
	return nil
}

func validateRelease_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewReleaseParameters(scope constructs.Construct, id *string, props *ReleaseProps) error {
	return nil
}

