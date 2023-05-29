//go:build no_runtime_type_checking

package instancecivocrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateCivoInstance_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateCivoInstance_IsConstructParameters(x interface{}) error {
	return nil
}

func validateCivoInstance_ManifestParameters(props *CivoInstanceProps) error {
	return nil
}

func validateCivoInstance_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewCivoInstanceParameters(scope constructs.Construct, id *string, props *CivoInstanceProps) error {
	return nil
}

