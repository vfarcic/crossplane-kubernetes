// clustercivocrossplaneio
package clustercivocrossplaneio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"clustercivocrossplaneio.CivoKubernetes",
		reflect.TypeOf((*CivoKubernetes)(nil)).Elem(),
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
			j := jsiiProxy_CivoKubernetes{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesProps",
		reflect.TypeOf((*CivoKubernetesProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpec",
		reflect.TypeOf((*CivoKubernetesSpec)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"clustercivocrossplaneio.CivoKubernetesSpecCni",
		reflect.TypeOf((*CivoKubernetesSpecCni)(nil)).Elem(),
		map[string]interface{}{
			"FLANNEL": CivoKubernetesSpecCni_FLANNEL,
			"CILIUM": CivoKubernetesSpecCni_CILIUM,
		},
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpecConnectionDetails",
		reflect.TypeOf((*CivoKubernetesSpecConnectionDetails)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"clustercivocrossplaneio.CivoKubernetesSpecDeletionPolicy",
		reflect.TypeOf((*CivoKubernetesSpecDeletionPolicy)(nil)).Elem(),
		map[string]interface{}{
			"ORPHAN": CivoKubernetesSpecDeletionPolicy_ORPHAN,
			"DELETE": CivoKubernetesSpecDeletionPolicy_DELETE,
		},
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpecPools",
		reflect.TypeOf((*CivoKubernetesSpecPools)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpecProviderConfigRef",
		reflect.TypeOf((*CivoKubernetesSpecProviderConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpecProviderRef",
		reflect.TypeOf((*CivoKubernetesSpecProviderRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"clustercivocrossplaneio.CivoKubernetesSpecWriteConnectionSecretToRef",
		reflect.TypeOf((*CivoKubernetesSpecWriteConnectionSecretToRef)(nil)).Elem(),
	)
}
