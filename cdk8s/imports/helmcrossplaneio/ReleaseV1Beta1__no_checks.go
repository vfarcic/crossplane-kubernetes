//go:build no_runtime_type_checking

package helmcrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateReleaseV1Beta1_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateReleaseV1Beta1_IsConstructParameters(x interface{}) error {
	return nil
}

func validateReleaseV1Beta1_ManifestParameters(props *ReleaseV1Beta1Props) error {
	return nil
}

func validateReleaseV1Beta1_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewReleaseV1Beta1Parameters(scope constructs.Construct, id *string, props *ReleaseV1Beta1Props) error {
	return nil
}

