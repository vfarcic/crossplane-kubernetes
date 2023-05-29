package apiextensionscrossplaneio


// The expected input format.
//
// * `quantity` - parses the input as a K8s [`resource.Quantity`](https://pkg.go.dev/k8s.io/apimachinery/pkg/api/resource#Quantity). Only used during `string -> float64` conversions.
// If this property is null, the default conversion is applied.
type CompositionSpecEnvironmentPatchesTransformsConvertFormat string

const (
	// none.
	CompositionSpecEnvironmentPatchesTransformsConvertFormat_NONE CompositionSpecEnvironmentPatchesTransformsConvertFormat = "NONE"
	// quantity.
	CompositionSpecEnvironmentPatchesTransformsConvertFormat_QUANTITY CompositionSpecEnvironmentPatchesTransformsConvertFormat = "QUANTITY"
)

