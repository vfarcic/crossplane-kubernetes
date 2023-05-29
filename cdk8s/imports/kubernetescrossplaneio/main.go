// kubernetescrossplaneio
package kubernetescrossplaneio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
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
			"NONE": ProviderConfigSpecCredentialsSource_NONE,
			"SECRET": ProviderConfigSpecCredentialsSource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecCredentialsSource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigSpecCredentialsSource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigSpecCredentialsSource_FILESYSTEM,
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
			"NONE": ProviderConfigSpecIdentitySource_NONE,
			"SECRET": ProviderConfigSpecIdentitySource_SECRET,
			"INJECTED_IDENTITY": ProviderConfigSpecIdentitySource_INJECTED_IDENTITY,
			"ENVIRONMENT": ProviderConfigSpecIdentitySource_ENVIRONMENT,
			"FILESYSTEM": ProviderConfigSpecIdentitySource_FILESYSTEM,
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
