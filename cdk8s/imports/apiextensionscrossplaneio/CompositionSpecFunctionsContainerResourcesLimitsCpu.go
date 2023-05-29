package apiextensionscrossplaneio

import (
	_init_ "example.com/cdk8s/imports/apiextensionscrossplaneio/jsii"
	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

// CPU, in cores.
//
// (500m = .5 cores)
type CompositionSpecFunctionsContainerResourcesLimitsCpu interface {
	Value() interface{}
}

// The jsii proxy struct for CompositionSpecFunctionsContainerResourcesLimitsCpu
type jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsCpu struct {
	_ byte // padding
}

func (j *jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsCpu) Value() interface{} {
	var returns interface{}
	_jsii_.Get(
		j,
		"value",
		&returns,
	)
	return returns
}


func CompositionSpecFunctionsContainerResourcesLimitsCpu_FromNumber(value *float64) CompositionSpecFunctionsContainerResourcesLimitsCpu {
	_init_.Initialize()

	if err := validateCompositionSpecFunctionsContainerResourcesLimitsCpu_FromNumberParameters(value); err != nil {
		panic(err)
	}
	var returns CompositionSpecFunctionsContainerResourcesLimitsCpu

	_jsii_.StaticInvoke(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsCpu",
		"fromNumber",
		[]interface{}{value},
		&returns,
	)

	return returns
}

func CompositionSpecFunctionsContainerResourcesLimitsCpu_FromString(value *string) CompositionSpecFunctionsContainerResourcesLimitsCpu {
	_init_.Initialize()

	if err := validateCompositionSpecFunctionsContainerResourcesLimitsCpu_FromStringParameters(value); err != nil {
		panic(err)
	}
	var returns CompositionSpecFunctionsContainerResourcesLimitsCpu

	_jsii_.StaticInvoke(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsCpu",
		"fromString",
		[]interface{}{value},
		&returns,
	)

	return returns
}

