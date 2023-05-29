package apiextensionscrossplaneio


// Optional conversion method to be specified.
//
// `ToUpper` and `ToLower` change the letter case of the input string. `ToBase64` and `FromBase64` perform a base64 conversion based on the input string. `ToJson` converts any input value into its raw JSON representation. `ToSha1`, `ToSha256` and `ToSha512` generate a hash value based on the input converted to JSON.
type CompositionSpecEnvironmentPatchesTransformsStringConvert string

const (
	// ToUpper.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_UPPER CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_UPPER"
	// ToLower.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_LOWER CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_LOWER"
	// ToBase64.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_BASE64 CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_BASE64"
	// FromBase64.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_FROM_BASE64 CompositionSpecEnvironmentPatchesTransformsStringConvert = "FROM_BASE64"
	// ToJson.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_JSON CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_JSON"
	// ToSha1.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA1 CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_SHA1"
	// ToSha256.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA256 CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_SHA256"
	// ToSha512.
	CompositionSpecEnvironmentPatchesTransformsStringConvert_TO_SHA512 CompositionSpecEnvironmentPatchesTransformsStringConvert = "TO_SHA512"
)

