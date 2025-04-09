$version: "2"

namespace smithy.ruby.tests

@httpApiKeyAuth(name: "x-api-key", in: "query")
service HttpApiKeyAuth {
    operations: [Operation]
}

operation Operation {}
