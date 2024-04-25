$version: "2.0"

namespace smithy.ruby.tests

@http(method: "POST", uri: "/relative_middleware")
operation RelativeMiddleware {}
