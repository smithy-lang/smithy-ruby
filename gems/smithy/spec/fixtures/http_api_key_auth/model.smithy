$version: "2"

namespace smithy.ruby.tests

@httpApiKeyAuth(name: "x-api-key", in: "header")
service HttpApiKeyAuth {
    operations: [Operation]
}

operation Operation {}
