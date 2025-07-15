$version: "2.0"

namespace smithy.ruby.tests

@httpApiKeyAuth(name: "x-api-key", in: "header")
service HttpApiKeyAuth {}
