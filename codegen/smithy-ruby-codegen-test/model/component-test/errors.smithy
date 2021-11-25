$version: "1.0"
namespace smithy.ruby.tests

operation ErrorsTest {
    errors: [ClientError, ServerError]
}

@error("client")
structure ClientError {
  Message: String
}

@error("server")
structure ServerError {}