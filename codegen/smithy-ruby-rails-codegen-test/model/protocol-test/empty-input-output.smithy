// This file defines test cases that test the basics of empty input and
// output shape serialization.
//
// TODO: does an operation with no input always send {}? What about no output?

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// The example tests how requests and responses are serialized when there's
/// no request or response payload because the operation has no input or output.
/// While this should be rare, code generators must support this.
@http(uri: "/no_input_and_no_output", method: "POST")
operation NoInputAndNoOutput {}

apply NoInputAndNoOutput @httpRequestTests([
    {
        id: "RailsJsonNoInputAndNoOutput",
        documentation: """
                No input serializes no payload. When clients do not need to
                serialize any data in the payload, they should omit a payload
                altogether.""",
        protocol: railsJson,
        method: "POST",
        uri: "/no_input_and_no_output",
        body: ""
    },
    {
        id: "RailsJsonNoInputAllowsAccept",
        documentation: """
                Servers should allow the accept header to be set to the
                default content-type.""",
        protocol: railsJson,
        method: "POST",
        uri: "/no_input_and_no_output",
        body: "",
        headers: {
            "Accept": "application/json"
        },
        appliesTo: "server",
    }
])

apply NoInputAndNoOutput @httpResponseTests([
   {
       id: "RailsJsonNoInputAndNoOutput",
       documentation: """
            When an operation does not define output, the service will respond
            with an empty payload, and may optionally include the content-type
            header.""",
       protocol: railsJson,
       code: 200,
       body: ""
   }
])

/// This test is similar to NoInputAndNoOutput, but uses explicit Unit types.
@http(uri: "/unit_input_and_output", method: "POST")
operation UnitInputAndOutput {
    input: Unit,
    output: Unit
}

apply UnitInputAndOutput @httpRequestTests([
    {
        id: "RailsJsonUnitInputAndOutput",
        documentation: """
                A unit type input serializes no payload. When clients do not
                need to serialize any data in the payload, they should omit
                a payload altogether.""",
        protocol: railsJson,
        method: "POST",
        uri: "/unit_input_and_output",
        body: ""
    },
    {
        id: "RailsJsonUnitInputAllowsAccept",
        documentation: """
                Servers should allow the accept header to be set to the
                default content-type.""",
        protocol: railsJson,
        method: "POST",
        uri: "/unit_input_and_output",
        body: "",
        headers: {
            "Accept": "application/json"
        },
        appliesTo: "server",
    }
])

apply UnitInputAndOutput @httpResponseTests([
   {
       id: "RailsJsonUnitInputAndOutputNoOutput",
       documentation: """
            When an operation defines Unit output, the service will respond
            with an empty payload, and may optionally include the content-type
            header.""",
       protocol: railsJson,
       code: 200,
       body: ""
   }
])

/// The example tests how requests and responses are serialized when there's
/// no request or response payload because the operation has no input and the
/// output is empty. While this should be rare, code generators must support
/// this.
@http(uri: "/no_input_and_output_output", method: "POST")
operation NoInputAndOutput {
    output: NoInputAndOutputOutput
}

apply NoInputAndOutput @httpRequestTests([
    {
        id: "RailsJsonNoInputAndOutput",
        documentation: """
                No input serializes no payload. When clients do not need to
                serialize any data in the payload, they should omit a payload
                altogether.""",
        protocol: railsJson,
        method: "POST",
        uri: "/no_input_and_output_output",
        body: "",
    },
    {
        id: "RailsJsonNoInputAndOutputAllowsAccept",
        documentation: """
                Servers should allow the accept header to be set to the
                default content-type.""",
        protocol: railsJson,
        method: "POST",
        uri: "/no_input_and_output_output",
        body: "",
        headers: {
            "Accept": "application/json"
        },
        appliesTo: "server"
    }
])

apply NoInputAndOutput @httpResponseTests([
    {
        id: "RailsJsonNoInputAndOutputWithJson",
        documentation: """
                Operations that define output and do not bind anything to
                the payload return a JSON object in the response.""",
        protocol: railsJson,
        code: 200,
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
    },
    {
       id: "RailsJsonNoInputAndOutputNoPayload",
       documentation: """
            This test is similar to RailsJsonNoInputAndOutputWithJson, but
            it ensures that clients can gracefully handle responses that
            omit a JSON payload.""",
       protocol: railsJson,
       code: 200,
       body: "",
       appliesTo: "client",
   }
])

@output
structure NoInputAndOutputOutput {}

/// The example tests how requests and responses are serialized when there's
/// no request or response payload because the operation has an empty input
/// and empty output structure that reuses the same shape. While this should
/// be rare, code generators must support this.
@http(uri: "/empty_input_and_empty_output", method: "POST")
operation EmptyInputAndEmptyOutput {
    input: EmptyInputAndEmptyOutputInput,
    output: EmptyInputAndEmptyOutputOutput
}

apply EmptyInputAndEmptyOutput @httpRequestTests([
    {
        id: "RailsJsonEmptyInputAndEmptyOutput",
        documentation: """
                Clients should not serialize a JSON payload when no parameters
                are given that are sent in the body. A service will tolerate
                clients that omit a payload or that send a JSON object.""",
        protocol: railsJson,
        method: "POST",
        uri: "/empty_input_and_empty_output",
        body: "",
    },
    {
        id: "RailsJsonEmptyInputAndEmptyOutputWithJson",
        documentation: """
                Similar to RailsJsonEmptyInputAndEmptyOutput, but ensures that
                services gracefully handles receiving a JSON object.""",
        protocol: railsJson,
        method: "POST",
        uri: "/empty_input_and_empty_output",
        headers: {
            "Content-Type": "application/json",
        },
        body: "{}",
        bodyMediaType: "application/json",
        appliesTo: "server",
    },
])

apply EmptyInputAndEmptyOutput @httpResponseTests([
    {
        id: "RailsJsonEmptyInputAndEmptyOutput",
        documentation: """
                As of January 2021, server implementations are expected to
                respond with a JSON object regardless of if the output
                parameters are empty.""",
        protocol: railsJson,
        code: 200,
        headers: {
            "Content-Type": "application/json",
        },
        body: "{}",
        bodyMediaType: "application/json",
    },
    {
        id: "RailsJsonEmptyInputAndEmptyOutputJsonObjectOutput",
        documentation: """
                This test ensures that clients can gracefully handle
                situations where a service omits a JSON payload entirely.""",
        protocol: railsJson,
        code: 200,
        body: "",
        appliesTo: "client",
    },
])

@input
structure EmptyInputAndEmptyOutputInput {}

@output
structure EmptyInputAndEmptyOutputOutput {}
