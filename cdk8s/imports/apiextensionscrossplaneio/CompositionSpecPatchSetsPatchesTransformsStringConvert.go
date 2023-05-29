package apiextensionscrossplaneio


// Optional conversion method to be specified.
//
// `ToUpper` and `ToLower` change the letter case of the input string. `ToBase64` and `FromBase64` perform a base64 conversion based on the input string. `ToJson` converts any input value into its raw JSON representation. `ToSha1`, `ToSha256` and `ToSha512` generate a hash value based on the input converted to JSON.
type CompositionSpecPatchSetsPatchesTransformsStringConvert string

const (
	// ToUpper.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_UPPER CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_UPPER"
	// ToLower.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_LOWER CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_LOWER"
	// ToBase64.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_BASE64 CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_BASE64"
	// FromBase64.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_FROM_BASE64 CompositionSpecPatchSetsPatchesTransformsStringConvert = "FROM_BASE64"
	// ToJson.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_JSON CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_JSON"
	// ToSha1.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA1 CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_SHA1"
	// ToSha256.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA256 CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_SHA256"
	// ToSha512.
	CompositionSpecPatchSetsPatchesTransformsStringConvert_TO_SHA512 CompositionSpecPatchSetsPatchesTransformsStringConvert = "TO_SHA512"
)

