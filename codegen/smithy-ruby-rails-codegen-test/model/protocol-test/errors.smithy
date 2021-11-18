// This file defines test cases that test error serialization.

$version: "1.0"

namespace protocoltests.RailsJson

use smithy.rails#RailsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This operation has three possible return values:
///
/// 1. A successful response in the form of GreetingWithErrorsOutput
/// 2. An InvalidGreeting error.
/// 3. A ComplexError error.
///
/// Implementations must be able to successfully take a response and
/// properly deserialize successful and error responses.
@http(method: "POST", uri: "/greetingwitherrors")
@idempotent
operation GreetingWithErrors {
    output: GreetingWithErrorsOutput,
    errors: [InvalidGreeting, ComplexError]
}

structure GreetingWithErrorsOutput {
    greeting: String,
}

/// This error is thrown when an invalid greeting value is provided.
@error("client")
structure InvalidGreeting {
    Message: String,
}

apply InvalidGreeting @httpResponseTests([
    {
        id: "RailsJsonInvalidGreetingError",
        documentation: "Parses simple JSON errors",
        protocol: RailsJson,
        params: {
            Message: "Hi"
        },
        code: 400,
        headers: {
            "Content-Type": "application/json",
            "x-smithy-error": "InvalidGreeting"
        },
        body: """
              {
                  "message": "Hi"
              }""",
        bodyMediaType: "application/json",
    },
])

/// This error is thrown when a request is invalid.
@error("client")
structure ComplexError {
    TopLevel: String,
    Nested: ComplexNestedErrorData,
}

structure ComplexNestedErrorData {
    @jsonName("Fooooo")
    Foo: String,
}

apply ComplexError @httpResponseTests([
    {
        id: "RailsJsonComplexError",
        documentation: "Parses a complex error with no message member",
        protocol: RailsJson,
        params: {
            TopLevel: "Top level",
            Nested: {
                Foo: "bar"
            }
        },
        code: 400,
        headers: {
            "Content-Type": "application/json",
            "x-smithy-error": "ComplexError"
        },
        body: """
              {
                  "top_level": "Top level",
                  "nested": {
                      "Fooooo": "bar"
                  }
              }""",
        bodyMediaType: "application/json"
    },
    {
        id: "RailsJsonEmptyComplexError",
        protocol: RailsJson,
        code: 400,
        headers: {
            "Content-Type": "application/json",
            "x-smithy-error": "ComplexError"
        },
        body: """
              {
              }""",
        bodyMediaType: "application/json"
    },
])