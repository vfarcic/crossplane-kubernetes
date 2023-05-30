// helmcrossplaneio
package helmcrossplaneio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"helmcrossplaneio.ProviderConfig",
		reflect.TypeOf((*ProviderConfig)(nil)).Elem(),
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
			j := jsiiProxy_ProviderConfig{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigProps",
		reflect.TypeOf((*ProviderConfigProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpec",
		reflect.TypeOf((*ProviderConfigSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecCredentials",
		reflect.TypeOf((*ProviderConfigSpecCredentials)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecCredentialsEnv",
		reflect.TypeOf((*ProviderConfigSpecCredentialsEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecCredentialsFs",
		reflect.TypeOf((*ProviderConfigSpecCredentialsFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecCredentialsSecretRef",
		reflect.TypeOf((*ProviderConfigSpecCredentialsSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigSpecCredentialsSource",
		reflect.TypeOf((*ProviderConfigSpecCredentialsSource)(nil)).Elem(),
		map[string]interface{}{
			"NONE": ProviderConfigSpecCredentialsSource_NONE,
			"SECRET": ProviderConfigSpecCredentialsSource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecCredentialsSource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigSpecCredentialsSource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigSpecCredentialsSource_FILESYSTEM,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecIdentity",
		reflect.TypeOf((*ProviderConfigSpecIdentity)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecIdentityEnv",
		reflect.TypeOf((*ProviderConfigSpecIdentityEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecIdentityFs",
		reflect.TypeOf((*ProviderConfigSpecIdentityFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigSpecIdentitySecretRef",
		reflect.TypeOf((*ProviderConfigSpecIdentitySecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigSpecIdentitySource",
		reflect.TypeOf((*ProviderConfigSpecIdentitySource)(nil)).Elem(),
		map[string]interface{}{
			"NONE": ProviderConfigSpecIdentitySource_NONE,
			"SECRET": ProviderConfigSpecIdentitySource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecIdentitySource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigSpecIdentitySource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigSpecIdentitySource_FILESYSTEM,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigSpecIdentityType",
		reflect.TypeOf((*ProviderConfigSpecIdentityType)(nil)).Elem(),
		map[string]interface{}{
			"GOOGLE_APPLICATION_CREDENTIALS": ProviderConfigSpecIdentityType_GOOGLE_APPLICATION_CREDENTIALS,
		},
	)
	_jsii_.RegisterClass(
		"helmcrossplaneio.ProviderConfigV1Beta1",
		reflect.TypeOf((*ProviderConfigV1Beta1)(nil)).Elem(),
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
			j := jsiiProxy_ProviderConfigV1Beta1{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1Props",
		reflect.TypeOf((*ProviderConfigV1Beta1Props)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1Spec",
		reflect.TypeOf((*ProviderConfigV1Beta1Spec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecCredentials",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecCredentials)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecCredentialsEnv",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecCredentialsEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecCredentialsFs",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecCredentialsFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecCredentialsSecretRef",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecCredentialsSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecCredentialsSource",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecCredentialsSource)(nil)).Elem(),
		map[string]interface{}{
			"NONE": ProviderConfigV1Beta1SpecCredentialsSource_NONE,
			"SECRET": ProviderConfigV1Beta1SpecCredentialsSource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigV1Beta1SpecCredentialsSource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigV1Beta1SpecCredentialsSource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigV1Beta1SpecCredentialsSource_FILESYSTEM,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentity",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentity)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentityEnv",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentityEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentityFs",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentityFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentitySecretRef",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentitySecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentitySource",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentitySource)(nil)).Elem(),
		map[string]interface{}{
			"NONE": ProviderConfigV1Beta1SpecIdentitySource_NONE,
			"SECRET": ProviderConfigV1Beta1SpecIdentitySource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigV1Beta1SpecIdentitySource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigV1Beta1SpecIdentitySource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigV1Beta1SpecIdentitySource_FILESYSTEM,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ProviderConfigV1Beta1SpecIdentityType",
		reflect.TypeOf((*ProviderConfigV1Beta1SpecIdentityType)(nil)).Elem(),
		map[string]interface{}{
			"GOOGLE_APPLICATION_CREDENTIALS": ProviderConfigV1Beta1SpecIdentityType_GOOGLE_APPLICATION_CREDENTIALS,
		},
	)
	_jsii_.RegisterClass(
		"helmcrossplaneio.Release",
		reflect.TypeOf((*Release)(nil)).Elem(),
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
			j := jsiiProxy_Release{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseProps",
		reflect.TypeOf((*ReleaseProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpec",
		reflect.TypeOf((*ReleaseSpec)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecDeletionPolicy",
		reflect.TypeOf((*ReleaseSpecDeletionPolicy)(nil)).Elem(),
		map[string]interface{}{
			"ORPHAN": ReleaseSpecDeletionPolicy_ORPHAN,
			"DELETE": ReleaseSpecDeletionPolicy_DELETE,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProvider",
		reflect.TypeOf((*ReleaseSpecForProvider)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderChart",
		reflect.TypeOf((*ReleaseSpecForProviderChart)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderChartPullSecretRef",
		reflect.TypeOf((*ReleaseSpecForProviderChartPullSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderPatchesFrom",
		reflect.TypeOf((*ReleaseSpecForProviderPatchesFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderPatchesFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderPatchesFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderPatchesFromSecretKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderPatchesFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderSet",
		reflect.TypeOf((*ReleaseSpecForProviderSet)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderSetValueFrom",
		reflect.TypeOf((*ReleaseSpecForProviderSetValueFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderSetValueFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderSetValueFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderSetValueFromSecretKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderSetValueFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderValuesFrom",
		reflect.TypeOf((*ReleaseSpecForProviderValuesFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderValuesFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderValuesFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecForProviderValuesFromSecretKeyRef",
		reflect.TypeOf((*ReleaseSpecForProviderValuesFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecProviderConfigRef",
		reflect.TypeOf((*ReleaseSpecProviderConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecProviderConfigRefPolicy",
		reflect.TypeOf((*ReleaseSpecProviderConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecProviderConfigRefPolicyResolution",
		reflect.TypeOf((*ReleaseSpecProviderConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseSpecProviderConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseSpecProviderConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecProviderConfigRefPolicyResolve",
		reflect.TypeOf((*ReleaseSpecProviderConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseSpecProviderConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseSpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecProviderRef",
		reflect.TypeOf((*ReleaseSpecProviderRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecProviderRefPolicy",
		reflect.TypeOf((*ReleaseSpecProviderRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecProviderRefPolicyResolution",
		reflect.TypeOf((*ReleaseSpecProviderRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseSpecProviderRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseSpecProviderRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecProviderRefPolicyResolve",
		reflect.TypeOf((*ReleaseSpecProviderRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseSpecProviderRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseSpecProviderRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsTo",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsTo)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsToConfigRef",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsToConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsToConfigRefPolicy",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsToConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolution",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseSpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecPublishConnectionDetailsToMetadata",
		reflect.TypeOf((*ReleaseSpecPublishConnectionDetailsToMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseSpecWriteConnectionSecretToRef",
		reflect.TypeOf((*ReleaseSpecWriteConnectionSecretToRef)(nil)).Elem(),
	)
	_jsii_.RegisterClass(
		"helmcrossplaneio.ReleaseV1Beta1",
		reflect.TypeOf((*ReleaseV1Beta1)(nil)).Elem(),
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
			j := jsiiProxy_ReleaseV1Beta1{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1Props",
		reflect.TypeOf((*ReleaseV1Beta1Props)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1Spec",
		reflect.TypeOf((*ReleaseV1Beta1Spec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecConnectionDetails",
		reflect.TypeOf((*ReleaseV1Beta1SpecConnectionDetails)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecDeletionPolicy",
		reflect.TypeOf((*ReleaseV1Beta1SpecDeletionPolicy)(nil)).Elem(),
		map[string]interface{}{
			"ORPHAN": ReleaseV1Beta1SpecDeletionPolicy_ORPHAN,
			"DELETE": ReleaseV1Beta1SpecDeletionPolicy_DELETE,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProvider",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProvider)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderChart",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderChart)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderChartPullSecretRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderChartPullSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderPatchesFrom",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderPatchesFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderPatchesFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderPatchesFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderPatchesFromSecretKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderPatchesFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderSet",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderSet)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderSetValueFrom",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderSetValueFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderSetValueFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderSetValueFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderSetValueFromSecretKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderSetValueFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderValuesFrom",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderValuesFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderValuesFromConfigMapKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderValuesFromConfigMapKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecForProviderValuesFromSecretKeyRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecForProviderValuesFromSecretKeyRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderConfigRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderConfigRefPolicy",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderConfigRefPolicyResolution",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseV1Beta1SpecProviderConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseV1Beta1SpecProviderConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderConfigRefPolicyResolve",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseV1Beta1SpecProviderConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseV1Beta1SpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderRefPolicy",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderRefPolicyResolution",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseV1Beta1SpecProviderRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseV1Beta1SpecProviderRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecProviderRefPolicyResolve",
		reflect.TypeOf((*ReleaseV1Beta1SpecProviderRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseV1Beta1SpecProviderRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseV1Beta1SpecProviderRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsTo",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsTo)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicy",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS": ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ReleaseV1Beta1SpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecPublishConnectionDetailsToMetadata",
		reflect.TypeOf((*ReleaseV1Beta1SpecPublishConnectionDetailsToMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"helmcrossplaneio.ReleaseV1Beta1SpecWriteConnectionSecretToRef",
		reflect.TypeOf((*ReleaseV1Beta1SpecWriteConnectionSecretToRef)(nil)).Elem(),
	)
}
