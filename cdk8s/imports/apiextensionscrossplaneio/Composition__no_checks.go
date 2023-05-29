//go:build no_runtime_type_checking

package apiextensionscrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateComposition_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateComposition_IsConstructParameters(x interface{}) error {
	return nil
}

func validateComposition_ManifestParameters(props *CompositionProps) error {
	return nil
}

func validateComposition_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewCompositionParameters(scope constructs.Construct, id *string, props *CompositionProps) error {
	return nil
}

