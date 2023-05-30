//go:build no_runtime_type_checking

package kubernetescrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateObject_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateObject_IsConstructParameters(x interface{}) error {
	return nil
}

func validateObject_ManifestParameters(props *ObjectProps) error {
	return nil
}

func validateObject_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewObjectParameters(scope constructs.Construct, id *string, props *ObjectProps) error {
	return nil
}
