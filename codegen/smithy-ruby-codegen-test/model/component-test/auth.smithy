$version: "1.0"

namespace smithy.ruby.tests

apply WhiteLabel @httpBasicAuth
apply WhiteLabel @httpDigestAuth
apply WhiteLabel @httpBearerAuth
apply WhiteLabel @httpApiKeyAuth(name: "X-API-Key", in: "header", scheme: "Authorization")

@authDefinition
@trait(selector: "service")
structure httpCustomAuth {
    signerProperty: String,
    identityProperty: String
}
apply WhiteLabel @httpCustomAuth(signerProperty: "signer", identityProperty: "identity")

@auth([httpBasicAuth])
@http(method: "POST", uri: "/http_basic_auth")
operation HttpBasicAuth {}

@auth([httpDigestAuth])
@http(method: "POST", uri: "/http_digest_auth")
operation HttpDigestAuth {}

@auth([httpBearerAuth])
@http(method: "POST", uri: "/http_bearer_auth")
operation HttpBearerAuth {}

@auth([httpApiKeyAuth])
@http(method: "POST", uri: "/http_api_key_auth")
operation HttpApiKeyAuth {}

@optionalAuth
@http(method: "POST", uri: "/optional_auth")
operation OptionalAuth {}

@auth([])
@http(method: "POST", uri: "/no_auth")
operation NoAuth {}

@auth([httpBasicAuth, httpDigestAuth, httpBearerAuth, httpApiKeyAuth])
@http(method: "POST", uri: "/ordered_auth")
operation OrderedAuth {}

@auth([httpCustomAuth])
@http(method: "POST", uri: "/custom_auth")
operation CustomAuth {}
