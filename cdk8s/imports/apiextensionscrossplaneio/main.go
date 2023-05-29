// apiextensionscrossplaneio
package apiextensionscrossplaneio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"apiextensionscrossplaneio.Composition",
		reflect.TypeOf((*Composition)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberMethod{JsiiMethod: "addDependency", GoMethod: "AddDependency"},
			_jsii_.MemberMethod{JsiiMethod: "addJsonPatch", GoMethod: "AddJsonPatch"},
			_jsii_.MemberProperty{JsiiProperty: "apiGroup", GoGetter: "ApiGroup"},
			_jsii_.MemberProperty{JsiiProperty: "apiVersion", GoGetter: "ApiVersion"},
			_jsii_.MemberProperty{JsiiProperty: "chart", GoGetter: "Chart"},
			_jsii_.MemberProperty{JsiiProperty: "kind", GoGetter: "Kind"},
			_jsii_.MemberProperty{JsiiProperty: "metadata", GoGetter: "Metadata"},
			_jsii_.MemberProperty{JsiiProperty: "name", GoGetter: "Name"},
			_jsii_.MemberProperty{JsiiProperty: "node", GoGetter: "Node"},
			_jsii_.MemberMethod{JsiiMethod: "toJson", GoMethod: "ToJson"},
			_jsii_.MemberMethod{JsiiMethod: "toString", GoMethod: "ToString"},
		},
		func() interface{} {
			j := jsiiProxy_Composition{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionProps",
		reflect.TypeOf((*CompositionProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpec",
		reflect.TypeOf((*CompositionSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecCompositeTypeRef",
		reflect.TypeOf((*CompositionSpecCompositeTypeRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironment",
		reflect.TypeOf((*CompositionSpecEnvironment)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigs",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigsRef",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigsRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigsSelector",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigsSelector)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabels",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabels)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabelsType",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabelsType)(nil)).Elem(),
		map[string]interface{}{
			"FROM_COMPOSITE_FIELD_PATH": CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabelsType_FROM_COMPOSITE_FIELD_PATH,
			"VALUE": CompositionSpecEnvironmentEnvironmentConfigsSelectorMatchLabelsType_VALUE,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentEnvironmentConfigsType",
		reflect.TypeOf((*CompositionSpecEnvironmentEnvironmentConfigsType)(nil)).Elem(),
		map[string]interface{}{
			"REFERENCE": CompositionSpecEnvironmentEnvironmentConfigsType_REFERENCE,
			"SELECTOR": CompositionSpecEnvironmentEnvironmentConfigsType_SELECTOR,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatches",
		reflect.TypeOf((*CompositionSpecEnvironmentPatches)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesCombine",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesCombine)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesCombineStrategy",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesCombineStrategy)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecEnvironmentPatchesCombineStrategy_STRING,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesCombineString",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesCombineString)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesCombineVariables",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesCombineVariables)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesPolicy",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesPolicyFromFieldPath",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesPolicyFromFieldPath)(nil)).Elem(),
		map[string]interface{}{
			"OPTIONAL": CompositionSpecEnvironmentPatchesPolicyFromFieldPath_OPTIONAL,
			"REQUIRED": CompositionSpecEnvironmentPatchesPolicyFromFieldPath_REQUIRED,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesPolicyMergeOptions",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesPolicyMergeOptions)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransforms",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransforms)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsConvert",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsConvert)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsConvertFormat",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsConvertFormat)(nil)).Elem(),
		map[string]interface{}{
			"NONE": CompositionSpecEnvironmentPatchesTransformsConvertFormat_NONE,
			"QUANTITY": CompositionSpecEnvironmentPatchesTransformsConvertFormat_QUANTITY,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsConvertToType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsConvertToType)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecEnvironmentPatchesTransformsConvertToType_STRING,
			"INT": CompositionSpecEnvironmentPatchesTransformsConvertToType_INT,
			"INT64": CompositionSpecEnvironmentPatchesTransformsConvertToType_INT64,
			"BOOL": CompositionSpecEnvironmentPatchesTransformsConvertToType_BOOL,
			"FLOAT64": CompositionSpecEnvironmentPatchesTransformsConvertToType_FLOAT64,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMatch",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMatch)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMatchFallbackTo",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMatchFallbackTo)(nil)).Elem(),
		map[string]interface{}{
			"VALUE": CompositionSpecEnvironmentPatchesTransformsMatchFallbackTo_VALUE,
			"INPUT": CompositionSpecEnvironmentPatchesTransformsMatchFallbackTo_INPUT,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMatchPatterns",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMatchPatterns)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMatchPatternsType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMatchPatternsType)(nil)).Elem(),
		map[string]interface{}{
			"LITERAL": CompositionSpecEnvironmentPatchesTransformsMatchPatternsType_LITERAL,
			"REGEXP": CompositionSpecEnvironmentPatchesTransformsMatchPatternsType_REGEXP,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMath",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMath)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsMathType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsMathType)(nil)).Elem(),
		map[string]interface{}{
			"MULTIPLY": CompositionSpecEnvironmentPatchesTransformsMathType_MULTIPLY,
			"CLAMP_MIN": CompositionSpecEnvironmentPatchesTransformsMathType_CLAMP_MIN,
			"CLAMP_MAX": CompositionSpecEnvironmentPatchesTransformsMathType_CLAMP_MAX,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsString",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsString)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsStringConvert",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsStringConvert)(nil)).Elem(),
		map[string]interface{}{
			"TO_UPPER": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_UPPER,
			"TO_LOWER": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_LOWER,
			"TO_BASE64": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_BASE64,
			"FROM_BASE64": CompositionSpecEnvironmentPatchesTransformsStringConvert_FROM_BASE64,
			"TO_JSON": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_JSON,
			"TO_SHA1": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA1,
			"TO_SHA256": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA256,
			"TO_SHA512": CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA512,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsStringRegexp",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsStringRegexp)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsStringType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsStringType)(nil)).Elem(),
		map[string]interface{}{
			"FORMAT": CompositionSpecEnvironmentPatchesTransformsStringType_FORMAT,
			"CONVERT": CompositionSpecEnvironmentPatchesTransformsStringType_CONVERT,
			"TRIM_PREFIX": CompositionSpecEnvironmentPatchesTransformsStringType_TRIM_PREFIX,
			"TRIM_SUFFIX": CompositionSpecEnvironmentPatchesTransformsStringType_TRIM_SUFFIX,
			"REGEXP": CompositionSpecEnvironmentPatchesTransformsStringType_REGEXP,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesTransformsType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesTransformsType)(nil)).Elem(),
		map[string]interface{}{
			"MAP": CompositionSpecEnvironmentPatchesTransformsType_MAP,
			"MATCH": CompositionSpecEnvironmentPatchesTransformsType_MATCH,
			"MATH": CompositionSpecEnvironmentPatchesTransformsType_MATH,
			"STRING": CompositionSpecEnvironmentPatchesTransformsType_STRING,
			"CONVERT": CompositionSpecEnvironmentPatchesTransformsType_CONVERT,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecEnvironmentPatchesType",
		reflect.TypeOf((*CompositionSpecEnvironmentPatchesType)(nil)).Elem(),
		map[string]interface{}{
			"FROM_COMPOSITE_FIELD_PATH": CompositionSpecEnvironmentPatchesType_FROM_COMPOSITE_FIELD_PATH,
			"FROM_ENVIRONMENT_FIELD_PATH": CompositionSpecEnvironmentPatchesType_FROM_ENVIRONMENT_FIELD_PATH,
			"TO_COMPOSITE_FIELD_PATH": CompositionSpecEnvironmentPatchesType_TO_COMPOSITE_FIELD_PATH,
			"COMBINE_FROM_COMPOSITE": CompositionSpecEnvironmentPatchesType_COMBINE_FROM_COMPOSITE,
			"COMBINE_TO_COMPOSITE": CompositionSpecEnvironmentPatchesType_COMBINE_TO_COMPOSITE,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctions",
		reflect.TypeOf((*CompositionSpecFunctions)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainer",
		reflect.TypeOf((*CompositionSpecFunctionsContainer)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerImagePullPolicy",
		reflect.TypeOf((*CompositionSpecFunctionsContainerImagePullPolicy)(nil)).Elem(),
		map[string]interface{}{
			"IF_NOT_PRESENT": CompositionSpecFunctionsContainerImagePullPolicy_IF_NOT_PRESENT,
			"ALWAYS": CompositionSpecFunctionsContainerImagePullPolicy_ALWAYS,
			"NEVER": CompositionSpecFunctionsContainerImagePullPolicy_NEVER,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerNetwork",
		reflect.TypeOf((*CompositionSpecFunctionsContainerNetwork)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerNetworkPolicy",
		reflect.TypeOf((*CompositionSpecFunctionsContainerNetworkPolicy)(nil)).Elem(),
		map[string]interface{}{
			"ISOLATED": CompositionSpecFunctionsContainerNetworkPolicy_ISOLATED,
			"RUNNER": CompositionSpecFunctionsContainerNetworkPolicy_RUNNER,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResources",
		reflect.TypeOf((*CompositionSpecFunctionsContainerResources)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimits",
		reflect.TypeOf((*CompositionSpecFunctionsContainerResourcesLimits)(nil)).Elem(),
	)
	_jsii_.RegisterClass(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsCpu",
		reflect.TypeOf((*CompositionSpecFunctionsContainerResourcesLimitsCpu)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberProperty{JsiiProperty: "value", GoGetter: "Value"},
		},
		func() interface{} {
			return &jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsCpu{}
		},
	)
	_jsii_.RegisterClass(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerResourcesLimitsMemory",
		reflect.TypeOf((*CompositionSpecFunctionsContainerResourcesLimitsMemory)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberProperty{JsiiProperty: "value", GoGetter: "Value"},
		},
		func() interface{} {
			return &jsiiProxy_CompositionSpecFunctionsContainerResourcesLimitsMemory{}
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecFunctionsContainerRunner",
		reflect.TypeOf((*CompositionSpecFunctionsContainerRunner)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecFunctionsType",
		reflect.TypeOf((*CompositionSpecFunctionsType)(nil)).Elem(),
		map[string]interface{}{
			"CONTAINER": CompositionSpecFunctionsType_CONTAINER,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSets",
		reflect.TypeOf((*CompositionSpecPatchSets)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatches",
		reflect.TypeOf((*CompositionSpecPatchSetsPatches)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesCombine",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesCombine)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesCombineStrategy",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesCombineStrategy)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecPatchSetsPatchesCombineStrategy_STRING,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesCombineString",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesCombineString)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesCombineVariables",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesCombineVariables)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesPolicy",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesPolicyFromFieldPath",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesPolicyFromFieldPath)(nil)).Elem(),
		map[string]interface{}{
			"OPTIONAL": CompositionSpecPatchSetsPatchesPolicyFromFieldPath_OPTIONAL,
			"REQUIRED": CompositionSpecPatchSetsPatchesPolicyFromFieldPath_REQUIRED,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesPolicyMergeOptions",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesPolicyMergeOptions)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransforms",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransforms)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsConvert",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsConvert)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsConvertFormat",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsConvertFormat)(nil)).Elem(),
		map[string]interface{}{
			"NONE": CompositionSpecPatchSetsPatchesTransformsConvertFormat_NONE,
			"QUANTITY": CompositionSpecPatchSetsPatchesTransformsConvertFormat_QUANTITY,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsConvertToType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsConvertToType)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecPatchSetsPatchesTransformsConvertToType_STRING,
			"INT": CompositionSpecPatchSetsPatchesTransformsConvertToType_INT,
			"INT64": CompositionSpecPatchSetsPatchesTransformsConvertToType_INT64,
			"BOOL": CompositionSpecPatchSetsPatchesTransformsConvertToType_BOOL,
			"FLOAT64": CompositionSpecPatchSetsPatchesTransformsConvertToType_FLOAT64,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMatch",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMatch)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMatchFallbackTo",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMatchFallbackTo)(nil)).Elem(),
		map[string]interface{}{
			"VALUE": CompositionSpecPatchSetsPatchesTransformsMatchFallbackTo_VALUE,
			"INPUT": CompositionSpecPatchSetsPatchesTransformsMatchFallbackTo_INPUT,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMatchPatterns",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMatchPatterns)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMatchPatternsType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMatchPatternsType)(nil)).Elem(),
		map[string]interface{}{
			"LITERAL": CompositionSpecPatchSetsPatchesTransformsMatchPatternsType_LITERAL,
			"REGEXP": CompositionSpecPatchSetsPatchesTransformsMatchPatternsType_REGEXP,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMath",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMath)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsMathType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsMathType)(nil)).Elem(),
		map[string]interface{}{
			"MULTIPLY": CompositionSpecPatchSetsPatchesTransformsMathType_MULTIPLY,
			"CLAMP_MIN": CompositionSpecPatchSetsPatchesTransformsMathType_CLAMP_MIN,
			"CLAMP_MAX": CompositionSpecPatchSetsPatchesTransformsMathType_CLAMP_MAX,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsString",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsString)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsStringConvert",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsStringConvert)(nil)).Elem(),
		map[string]interface{}{
			"TO_UPPER": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_UPPER,
			"TO_LOWER": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_LOWER,
			"TO_BASE64": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_BASE64,
			"FROM_BASE64": CompositionSpecPatchSetsPatchesTransformsStringConvert_FROM_BASE64,
			"TO_JSON": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_JSON,
			"TO_SHA1": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA1,
			"TO_SHA256": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA256,
			"TO_SHA512": CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA512,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsStringRegexp",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsStringRegexp)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsStringType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsStringType)(nil)).Elem(),
		map[string]interface{}{
			"FORMAT": CompositionSpecPatchSetsPatchesTransformsStringType_FORMAT,
			"CONVERT": CompositionSpecPatchSetsPatchesTransformsStringType_CONVERT,
			"TRIM_PREFIX": CompositionSpecPatchSetsPatchesTransformsStringType_TRIM_PREFIX,
			"TRIM_SUFFIX": CompositionSpecPatchSetsPatchesTransformsStringType_TRIM_SUFFIX,
			"REGEXP": CompositionSpecPatchSetsPatchesTransformsStringType_REGEXP,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesTransformsType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesTransformsType)(nil)).Elem(),
		map[string]interface{}{
			"MAP": CompositionSpecPatchSetsPatchesTransformsType_MAP,
			"MATCH": CompositionSpecPatchSetsPatchesTransformsType_MATCH,
			"MATH": CompositionSpecPatchSetsPatchesTransformsType_MATH,
			"STRING": CompositionSpecPatchSetsPatchesTransformsType_STRING,
			"CONVERT": CompositionSpecPatchSetsPatchesTransformsType_CONVERT,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecPatchSetsPatchesType",
		reflect.TypeOf((*CompositionSpecPatchSetsPatchesType)(nil)).Elem(),
		map[string]interface{}{
			"FROM_COMPOSITE_FIELD_PATH": CompositionSpecPatchSetsPatchesType_FROM_COMPOSITE_FIELD_PATH,
			"FROM_ENVIRONMENT_FIELD_PATH": CompositionSpecPatchSetsPatchesType_FROM_ENVIRONMENT_FIELD_PATH,
			"PATCH_SET": CompositionSpecPatchSetsPatchesType_PATCH_SET,
			"TO_COMPOSITE_FIELD_PATH": CompositionSpecPatchSetsPatchesType_TO_COMPOSITE_FIELD_PATH,
			"TO_ENVIRONMENT_FIELD_PATH": CompositionSpecPatchSetsPatchesType_TO_ENVIRONMENT_FIELD_PATH,
			"COMBINE_FROM_ENVIRONMENT": CompositionSpecPatchSetsPatchesType_COMBINE_FROM_ENVIRONMENT,
			"COMBINE_FROM_COMPOSITE": CompositionSpecPatchSetsPatchesType_COMBINE_FROM_COMPOSITE,
			"COMBINE_TO_COMPOSITE": CompositionSpecPatchSetsPatchesType_COMBINE_TO_COMPOSITE,
			"COMBINE_TO_ENVIRONMENT": CompositionSpecPatchSetsPatchesType_COMBINE_TO_ENVIRONMENT,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecPublishConnectionDetailsWithStoreConfigRef",
		reflect.TypeOf((*CompositionSpecPublishConnectionDetailsWithStoreConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResources",
		reflect.TypeOf((*CompositionSpecResources)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesConnectionDetails",
		reflect.TypeOf((*CompositionSpecResourcesConnectionDetails)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesConnectionDetailsType",
		reflect.TypeOf((*CompositionSpecResourcesConnectionDetailsType)(nil)).Elem(),
		map[string]interface{}{
			"FROM_CONNECTION_SECRET_KEY": CompositionSpecResourcesConnectionDetailsType_FROM_CONNECTION_SECRET_KEY,
			"FROM_FIELD_PATH": CompositionSpecResourcesConnectionDetailsType_FROM_FIELD_PATH,
			"FROM_VALUE": CompositionSpecResourcesConnectionDetailsType_FROM_VALUE,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatches",
		reflect.TypeOf((*CompositionSpecResourcesPatches)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesCombine",
		reflect.TypeOf((*CompositionSpecResourcesPatchesCombine)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesCombineStrategy",
		reflect.TypeOf((*CompositionSpecResourcesPatchesCombineStrategy)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecResourcesPatchesCombineStrategy_STRING,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesCombineString",
		reflect.TypeOf((*CompositionSpecResourcesPatchesCombineString)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesCombineVariables",
		reflect.TypeOf((*CompositionSpecResourcesPatchesCombineVariables)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesPolicy",
		reflect.TypeOf((*CompositionSpecResourcesPatchesPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesPolicyFromFieldPath",
		reflect.TypeOf((*CompositionSpecResourcesPatchesPolicyFromFieldPath)(nil)).Elem(),
		map[string]interface{}{
			"OPTIONAL": CompositionSpecResourcesPatchesPolicyFromFieldPath_OPTIONAL,
			"REQUIRED": CompositionSpecResourcesPatchesPolicyFromFieldPath_REQUIRED,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesPolicyMergeOptions",
		reflect.TypeOf((*CompositionSpecResourcesPatchesPolicyMergeOptions)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransforms",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransforms)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsConvert",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsConvert)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsConvertFormat",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsConvertFormat)(nil)).Elem(),
		map[string]interface{}{
			"NONE": CompositionSpecResourcesPatchesTransformsConvertFormat_NONE,
			"QUANTITY": CompositionSpecResourcesPatchesTransformsConvertFormat_QUANTITY,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsConvertToType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsConvertToType)(nil)).Elem(),
		map[string]interface{}{
			"STRING": CompositionSpecResourcesPatchesTransformsConvertToType_STRING,
			"INT": CompositionSpecResourcesPatchesTransformsConvertToType_INT,
			"INT64": CompositionSpecResourcesPatchesTransformsConvertToType_INT64,
			"BOOL": CompositionSpecResourcesPatchesTransformsConvertToType_BOOL,
			"FLOAT64": CompositionSpecResourcesPatchesTransformsConvertToType_FLOAT64,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMatch",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMatch)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMatchFallbackTo",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMatchFallbackTo)(nil)).Elem(),
		map[string]interface{}{
			"VALUE": CompositionSpecResourcesPatchesTransformsMatchFallbackTo_VALUE,
			"INPUT": CompositionSpecResourcesPatchesTransformsMatchFallbackTo_INPUT,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMatchPatterns",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMatchPatterns)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMatchPatternsType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMatchPatternsType)(nil)).Elem(),
		map[string]interface{}{
			"LITERAL": CompositionSpecResourcesPatchesTransformsMatchPatternsType_LITERAL,
			"REGEXP": CompositionSpecResourcesPatchesTransformsMatchPatternsType_REGEXP,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMath",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMath)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsMathType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsMathType)(nil)).Elem(),
		map[string]interface{}{
			"MULTIPLY": CompositionSpecResourcesPatchesTransformsMathType_MULTIPLY,
			"CLAMP_MIN": CompositionSpecResourcesPatchesTransformsMathType_CLAMP_MIN,
			"CLAMP_MAX": CompositionSpecResourcesPatchesTransformsMathType_CLAMP_MAX,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsString",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsString)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsStringConvert",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsStringConvert)(nil)).Elem(),
		map[string]interface{}{
			"TO_UPPER": CompositionSpecResourcesPatchesTransformsStringConvert_TO_UPPER,
			"TO_LOWER": CompositionSpecResourcesPatchesTransformsStringConvert_TO_LOWER,
			"TO_BASE64": CompositionSpecResourcesPatchesTransformsStringConvert_TO_BASE64,
			"FROM_BASE64": CompositionSpecResourcesPatchesTransformsStringConvert_FROM_BASE64,
			"TO_JSON": CompositionSpecResourcesPatchesTransformsStringConvert_TO_JSON,
			"TO_SHA1": CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA1,
			"TO_SHA256": CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA256,
			"TO_SHA512": CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA512,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsStringRegexp",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsStringRegexp)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsStringType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsStringType)(nil)).Elem(),
		map[string]interface{}{
			"FORMAT": CompositionSpecResourcesPatchesTransformsStringType_FORMAT,
			"CONVERT": CompositionSpecResourcesPatchesTransformsStringType_CONVERT,
			"TRIM_PREFIX": CompositionSpecResourcesPatchesTransformsStringType_TRIM_PREFIX,
			"TRIM_SUFFIX": CompositionSpecResourcesPatchesTransformsStringType_TRIM_SUFFIX,
			"REGEXP": CompositionSpecResourcesPatchesTransformsStringType_REGEXP,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesTransformsType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesTransformsType)(nil)).Elem(),
		map[string]interface{}{
			"MAP": CompositionSpecResourcesPatchesTransformsType_MAP,
			"MATCH": CompositionSpecResourcesPatchesTransformsType_MATCH,
			"MATH": CompositionSpecResourcesPatchesTransformsType_MATH,
			"STRING": CompositionSpecResourcesPatchesTransformsType_STRING,
			"CONVERT": CompositionSpecResourcesPatchesTransformsType_CONVERT,
		},
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesPatchesType",
		reflect.TypeOf((*CompositionSpecResourcesPatchesType)(nil)).Elem(),
		map[string]interface{}{
			"FROM_COMPOSITE_FIELD_PATH": CompositionSpecResourcesPatchesType_FROM_COMPOSITE_FIELD_PATH,
			"FROM_ENVIRONMENT_FIELD_PATH": CompositionSpecResourcesPatchesType_FROM_ENVIRONMENT_FIELD_PATH,
			"PATCH_SET": CompositionSpecResourcesPatchesType_PATCH_SET,
			"TO_COMPOSITE_FIELD_PATH": CompositionSpecResourcesPatchesType_TO_COMPOSITE_FIELD_PATH,
			"TO_ENVIRONMENT_FIELD_PATH": CompositionSpecResourcesPatchesType_TO_ENVIRONMENT_FIELD_PATH,
			"COMBINE_FROM_ENVIRONMENT": CompositionSpecResourcesPatchesType_COMBINE_FROM_ENVIRONMENT,
			"COMBINE_FROM_COMPOSITE": CompositionSpecResourcesPatchesType_COMBINE_FROM_COMPOSITE,
			"COMBINE_TO_COMPOSITE": CompositionSpecResourcesPatchesType_COMBINE_TO_COMPOSITE,
			"COMBINE_TO_ENVIRONMENT": CompositionSpecResourcesPatchesType_COMBINE_TO_ENVIRONMENT,
		},
	)
	_jsii_.RegisterStruct(
		"apiextensionscrossplaneio.CompositionSpecResourcesReadinessChecks",
		reflect.TypeOf((*CompositionSpecResourcesReadinessChecks)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"apiextensionscrossplaneio.CompositionSpecResourcesReadinessChecksType",
		reflect.TypeOf((*CompositionSpecResourcesReadinessChecksType)(nil)).Elem(),
		map[string]interface{}{
			"MATCH_STRING": CompositionSpecResourcesReadinessChecksType_MATCH_STRING,
			"MATCH_INTEGER": CompositionSpecResourcesReadinessChecksType_MATCH_INTEGER,
			"NON_EMPTY": CompositionSpecResourcesReadinessChecksType_NON_EMPTY,
			"NONE": CompositionSpecResourcesReadinessChecksType_NONE,
		},
	)
}
