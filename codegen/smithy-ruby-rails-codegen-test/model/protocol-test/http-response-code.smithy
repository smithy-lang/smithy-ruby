// This file defines test cases that test HTTP response code bindings.
// See: https://awslabs.github.io/smithy/1.0/spec/core/http-traits.html#httpresponsecode-trait

$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpResponseTests

@idempotent
@http(uri: "/HttpResponseCode", method: "PUT")
operation HttpResponseCode {
    output: HttpResponseCodeOutput
}

structure HttpResponseCodeOutput {
    @httpResponseCode
    Status: Integer
}

apply HttpResponseCode @httpResponseTests([
    {
        id: "RailsJsonHttpResponseCode",
        documentation: """
                Binds the http response code to an output structure. Note that
                even though all members are bound outside of the payload, an
                empty JSON object is serialized in the response. However,
                clients should be able to handle an empty JSON object or an
                empty payload without failing to deserialize a response.""",
        protocol: railsJson,
        code: 201,
        headers: {
            "Content-Type": "application/json",
        },
        body: "{}",
        bodyMediaType: "application/json",
        params: {
            Status: 201,
        }
    },
    {
        id: "RailsJsonHttpResponseCodeWithNoPayload",
        documentation: """
                This test ensures that clients gracefully handle cases where
                the service responds with no payload rather than an empty JSON
                object.""",
        protocol: railsJson,
        code: 201,
        body: "",
        params: {
            Status: 201,
        },
        appliesTo: "client"
    },
])