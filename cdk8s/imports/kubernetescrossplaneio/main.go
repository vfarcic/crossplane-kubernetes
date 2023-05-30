// kubernetescrossplaneio
package kubernetescrossplaneio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"kubernetescrossplaneio.Object",
		reflect.TypeOf((*Object)(nil)).Elem(),
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
			j := jsiiProxy_Object{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectProps",
		reflect.TypeOf((*ObjectProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpec",
		reflect.TypeOf((*ObjectSpec)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecDeletionPolicy",
		reflect.TypeOf((*ObjectSpecDeletionPolicy)(nil)).Elem(),
		map[string]interface{}{
			"ORPHAN": ObjectSpecDeletionPolicy_ORPHAN,
			"DELETE": ObjectSpecDeletionPolicy_DELETE,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecForProvider",
		reflect.TypeOf((*ObjectSpecForProvider)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecManagementPolicy",
		reflect.TypeOf((*ObjectSpecManagementPolicy)(nil)).Elem(),
		map[string]interface{}{
			"DEFAULT":               ObjectSpecManagementPolicy_DEFAULT,
			"OBSERVE_CREATE_UPDATE": ObjectSpecManagementPolicy_OBSERVE_CREATE_UPDATE,
			"OBSERVE_DELETE":        ObjectSpecManagementPolicy_OBSERVE_DELETE,
			"OBSERVE":               ObjectSpecManagementPolicy_OBSERVE,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecProviderConfigRef",
		reflect.TypeOf((*ObjectSpecProviderConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecProviderConfigRefPolicy",
		reflect.TypeOf((*ObjectSpecProviderConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecProviderConfigRefPolicyResolution",
		reflect.TypeOf((*ObjectSpecProviderConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ObjectSpecProviderConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ObjectSpecProviderConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecProviderConfigRefPolicyResolve",
		reflect.TypeOf((*ObjectSpecProviderConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS":         ObjectSpecProviderConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ObjectSpecProviderConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecProviderRef",
		reflect.TypeOf((*ObjectSpecProviderRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecProviderRefPolicy",
		reflect.TypeOf((*ObjectSpecProviderRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecProviderRefPolicyResolution",
		reflect.TypeOf((*ObjectSpecProviderRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ObjectSpecProviderRefPolicyResolution_REQUIRED,
			"OPTIONAL": ObjectSpecProviderRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecProviderRefPolicyResolve",
		reflect.TypeOf((*ObjectSpecProviderRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS":         ObjectSpecProviderRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ObjectSpecProviderRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsTo",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsTo)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsToConfigRef",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsToConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsToConfigRefPolicy",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsToConfigRefPolicy)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolution",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolution)(nil)).Elem(),
		map[string]interface{}{
			"REQUIRED": ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolution_REQUIRED,
			"OPTIONAL": ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolution_OPTIONAL,
		},
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve)(nil)).Elem(),
		map[string]interface{}{
			"ALWAYS":         ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve_ALWAYS,
			"IF_NOT_PRESENT": ObjectSpecPublishConnectionDetailsToConfigRefPolicyResolve_IF_NOT_PRESENT,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecPublishConnectionDetailsToMetadata",
		reflect.TypeOf((*ObjectSpecPublishConnectionDetailsToMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecReferences",
		reflect.TypeOf((*ObjectSpecReferences)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecReferencesDependsOn",
		reflect.TypeOf((*ObjectSpecReferencesDependsOn)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecReferencesPatchesFrom",
		reflect.TypeOf((*ObjectSpecReferencesPatchesFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ObjectSpecWriteConnectionSecretToRef",
		reflect.TypeOf((*ObjectSpecWriteConnectionSecretToRef)(nil)).Elem(),
	)
	_jsii_.RegisterClass(
		"kubernetescrossplaneio.ProviderConfig",
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
		"kubernetescrossplaneio.ProviderConfigProps",
		reflect.TypeOf((*ProviderConfigProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpec",
		reflect.TypeOf((*ProviderConfigSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecCredentials",
		reflect.TypeOf((*ProviderConfigSpecCredentials)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecCredentialsEnv",
		reflect.TypeOf((*ProviderConfigSpecCredentialsEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecCredentialsFs",
		reflect.TypeOf((*ProviderConfigSpecCredentialsFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecCredentialsSecretRef",
		reflect.TypeOf((*ProviderConfigSpecCredentialsSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ProviderConfigSpecCredentialsSource",
		reflect.TypeOf((*ProviderConfigSpecCredentialsSource)(nil)).Elem(),
		map[string]interface{}{
			"NONE":              ProviderConfigSpecCredentialsSource_NONE,
			"SECRET":            ProviderConfigSpecCredentialsSource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecCredentialsSource_INJECTED_IDENTITY,
			"ENVIRONMENT":       ProviderConfigSpecCredentialsSource_ENVIRONMENT,
			"FILESYSTEM":        ProviderConfigSpecCredentialsSource_FILESYSTEM,
		},
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecIdentity",
		reflect.TypeOf((*ProviderConfigSpecIdentity)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecIdentityEnv",
		reflect.TypeOf((*ProviderConfigSpecIdentityEnv)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecIdentityFs",
		reflect.TypeOf((*ProviderConfigSpecIdentityFs)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"kubernetescrossplaneio.ProviderConfigSpecIdentitySecretRef",
		reflect.TypeOf((*ProviderConfigSpecIdentitySecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ProviderConfigSpecIdentitySource",
		reflect.TypeOf((*ProviderConfigSpecIdentitySource)(nil)).Elem(),
		map[string]interface{}{
			"NONE":              ProviderConfigSpecIdentitySource_NONE,
			"SECRET":            ProviderConfigSpecIdentitySource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecIdentitySource_INJECTED_IDENTITY,
			"ENVIRONMENT":       ProviderConfigSpecIdentitySource_ENVIRONMENT,
			"FILESYSTEM":        ProviderConfigSpecIdentitySource_FILESYSTEM,
		},
	)
	_jsii_.RegisterEnum(
		"kubernetescrossplaneio.ProviderConfigSpecIdentityType",
		reflect.TypeOf((*ProviderConfigSpecIdentityType)(nil)).Elem(),
		map[string]interface{}{
			"GOOGLE_APPLICATION_CREDENTIALS": ProviderConfigSpecIdentityType_GOOGLE_APPLICATION_CREDENTIALS,
		},
	)
}
