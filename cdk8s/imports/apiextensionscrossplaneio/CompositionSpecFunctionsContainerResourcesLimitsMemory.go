package apiextensionscrossplaneio

import (
	_init_ "example.com/cdk8s/imports/apiextensionscrossplaneio/jsii"
	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

// Memory, in bytes.
//
// (500Gi = 500GiB = 500 * 1024 * 1024 * 1024).
type CompositionSpecFunctionsContainerResourcesLimitsMemory interface {
	Value() interface{}
}

// The jsii proxy struct for CompositionSpecFunctionsContainerResourcesLimitsMemory
type jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsMemory struct {
	_ byte // padding
}

func (j *jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsMemory) Value() interface{} {
	var returns interface{}
	_jsii_.Get(
		j,
		"value",
		&returns,
	)
	return returns
}


func CompositionSpecFunctionsContainerResourcesLimitsMemory_FromNumber(value *float64) CompositionSpecFunctionsContainerResourcesLimitsMemory {
	_init_.Initialize()

	if err := validateCompositionSpecFunctionsContainerResourcesLimitsMemory_FromNumberParameters(value); err != nil {
		panic(err)
	}
	var returns CompositionSpecFunctionsContainerResourcesLimitsMemory

	_jsii_.StaticInvoke(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsMemory",
		"fromNumber",
		[]interface{}{value},
		&returns,
	)

	return returns
}

func CompositionSpecFunctionsContainerResourcesLimitsMemory_FromString(value *string) CompositionSpecFunctionsContainerResourcesLimitsMemory {
	_init_.Initialize()

	if err := validateCompositionSpecFunctionsContainerResourcesLimitsMemory_FromStringParameters(value); err != nil {
		panic(err)
	}
	var returns CompositionSpecFunctionsContainerResourcesLimitsMemory

	_jsii_.StaticInvoke(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsMemory",
		"fromString",
		[]interface{}{value},
		&returns,
	)

	return returns
}

