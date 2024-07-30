$version: "2.0"

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

apply WhiteLabel @auth([httpApiKeyAuth, httpBasicAuth, httpBearerAuth, httpDigestAuth, httpCustomAuth])

@auth([httpBasicAuth])
operation HttpBasicAuth {}

@auth([httpDigestAuth])
operation HttpDigestAuth {}

@auth([httpBearerAuth])
operation HttpBearerAuth {}

@auth([httpApiKeyAuth])
operation HttpApiKeyAuth {}

@optionalAuth
operation OptionalAuth {}

@auth([])
operation NoAuth {}

@auth([httpBasicAuth, httpDigestAuth, httpBearerAuth, httpApiKeyAuth])
operation OrderedAuth {}

@auth([httpCustomAuth])
operation CustomAuth {}
