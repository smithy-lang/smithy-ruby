// This file defines test cases that test error serialization.

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This operation has three possible return values:
///
/// 1. A successful response in the form of GreetingWithErrorsOutput
/// 2. An InvalidGreeting error.
/// 3. A BadRequest error.
///
/// Implementations must be able to successfully take a response and
/// properly (de)serialize successful and error responses based on the
/// the presence of the
@idempotent
@http(uri: "/GreetingWithErrors", method: "PUT")
operation GreetingWithErrors {
    output: GreetingWithErrorsOutput,
    errors: [InvalidGreeting, ComplexError]
}

apply GreetingWithErrors @httpResponseTests([
    {
        id: "RailsJsonGreetingWithErrors",
        documentation: """
                Ensures that operations with errors successfully know how
                to deserialize a successful response. As of January 2021,
                server implementations are expected to respond with a
                JSON object regardless of if the output parameters are
                empty.""",
        protocol: railsJson,
        code: 200,
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "X-Greeting": "Hello",
        },
        params: {
            greeting: "Hello"
        }
    },
    {
        id: "RailsJsonGreetingWithErrorsNoPayload",
        documentation: """
                This test is similar to RailsJsonGreetingWithErrors, but it
                ensures that clients can gracefully deal with a server
                omitting a response payload.""",
        protocol: railsJson,
        code: 200,
        body: "",
        headers: {
            "X-Greeting": "Hello",
        },
        params: {
            greeting: "Hello"
        },
        appliesTo: "client"
    },
])

structure GreetingWithErrorsOutput {
    @httpHeader("X-Greeting")
    greeting: String,
}

/// This error is thrown when an invalid greeting value is provided.
@error("client")
@httpError(400)
structure InvalidGreeting {
    Message: String,
}

apply InvalidGreeting @httpResponseTests([
    {
        id: "RailsJsonInvalidGreetingError",
        documentation: "Parses simple JSON errors",
        protocol: railsJson,
        params: {
            Message: "Hi"
        },
        code: 400,
        headers: {
            "Content-Type": "application/json",
            "X-Amzn-Errortype": "InvalidGreeting",
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
@httpError(403)
structure ComplexError {
    // Errors support HTTP bindings!
    @httpHeader("X-Header")
    Header: String,

    TopLevel: String,

    Nested: ComplexNestedErrorData,
}

apply ComplexError @httpResponseTests([
    {
        id: "RailsJsonComplexErrorWithNoMessage",
        documentation: "Serializes a complex error with no message member",
        protocol: railsJson,
        params: {
            Header: "Header",
            TopLevel: "Top level",
            Nested: {
                Foo: "bar"
            }
        },
        code: 403,
        headers: {
            "Content-Type": "application/json",
            "X-Header": "Header",
            "X-Amzn-Errortype": "ComplexError",
        },
        body: """
              {
                  "top_level": "Top level",
                  "nested": {
                      "Fooooo": "bar"
                  }
              }""",
        bodyMediaType: "application/json",
    },
    {
        id: "RailsJsonEmptyComplexErrorWithNoMessage",
        protocol: railsJson,
        params: {},
        code: 403,
        headers: {
            "Content-Type": "application/json",
            "X-Amzn-Errortype": "ComplexError"
        },
        body: "{}",
        bodyMediaType: "application/json",
    },
])

structure ComplexNestedErrorData {
    @jsonName("Fooooo")
    Foo: String,
}
