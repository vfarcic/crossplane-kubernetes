//go:build no_runtime_type_checking

package clustercivocrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateCivoKubernetes_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateCivoKubernetes_IsConstructParameters(x interface{}) error {
	return nil
}

func validateCivoKubernetes_ManifestParameters(props *CivoKubernetesProps) error {
	return nil
}

func validateCivoKubernetes_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewCivoKubernetesParameters(scope constructs.Construct, id *string, props *CivoKubernetesProps) error {
	return nil
}

