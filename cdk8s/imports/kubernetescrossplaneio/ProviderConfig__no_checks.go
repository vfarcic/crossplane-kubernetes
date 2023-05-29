//go:build no_runtime_type_checking

package kubernetescrossplaneio

// Building without runtime type checking enabled, so all the below just return nil

func validateProviderConfig_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateProviderConfig_IsConstructParameters(x interface{}) error {
	return nil
}

func validateProviderConfig_ManifestParameters(props *ProviderConfigProps) error {
	return nil
}

func validateProviderConfig_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewProviderConfigParameters(scope constructs.Construct, id *string, props *ProviderConfigProps) error {
	return nil
}

