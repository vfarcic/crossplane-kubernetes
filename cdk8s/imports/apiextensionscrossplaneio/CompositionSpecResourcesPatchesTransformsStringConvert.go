package apiextensionscrossplaneio


// Optional conversion method to be specified.
//
// `ToUpper` and `ToLower` change the letter case of the input string. `ToBase64` and `FromBase64` perform a base64 conversion based on the input string. `ToJson` converts any input value into its raw JSON representation. `ToSha1`, `ToSha256` and `ToSha512` generate a hash value based on the input converted to JSON.
type CompositionSpecResourcesPatchesTransformsStringConvert string

const (
	// ToUpper.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_UPPER CompositionSpecResourcesPatchesTransformsStringConvert = "TO_UPPER"
	// ToLower.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_LOWER CompositionSpecResourcesPatchesTransformsStringConvert = "TO_LOWER"
	// ToBase64.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_BASE64 CompositionSpecResourcesPatchesTransformsStringConvert = "TO_BASE64"
	// FromBase64.
	CompositionSpecResourcesPatchesTransformsStringConvert_FROM_BASE64 CompositionSpecResourcesPatchesTransformsStringConvert = "FROM_BASE64"
	// ToJson.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_JSON CompositionSpecResourcesPatchesTransformsStringConvert = "TO_JSON"
	// ToSha1.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA1 CompositionSpecResourcesPatchesTransformsStringConvert = "TO_SHA1"
	// ToSha256.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA256 CompositionSpecResourcesPatchesTransformsStringConvert = "TO_SHA256"
	// ToSha512.
	CompositionSpecResourcesPatchesTransformsStringConvert_TO_SHA512 CompositionSpecResourcesPatchesTransformsStringConvert = "TO_SHA512"
)

