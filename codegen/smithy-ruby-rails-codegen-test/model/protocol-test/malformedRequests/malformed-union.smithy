$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests

@suppress(["UnstableTrait"])
@http(uri: "/MalformedUnion", method: "POST")
operation MalformedUnion {
    input: MalformedUnionInput
}

apply MalformedUnion @httpMalformedRequestTests([
    {
        id: "RailsJsonMalformedUnionMultipleFieldsSet",
        documentation: """
            When the union has multiple fields set, the response should be a 400
            SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedUnion",
            body: """
                { "union" : { "int": 2, "string": "three" } }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RailsJsonMalformedUnionKnownAndUnknownFieldsSet",
        documentation: """
            When the union has multiple fields set, even when only one is modeled,
            the response should be a 400 SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedUnion",
            body: """
            { "union" : { "int": 2, "unknownField": "three" } }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RailsJsonMalformedUnionNoFieldsSet",
        documentation: """
            When the union has no fields set, the response should be a 400
            SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedUnion",
            body: """
                { "union" : { "int": null } }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RailsJsonMalformedUnionValueIsArray",
        documentation: """
            When the union value is actually an array, the response should be a 400
            SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedUnion",
            body: """
                { "union" : ["int"] }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    }
    {
        id: "RailsJsonMalformedUnionUnknownMember",
        documentation: """
            When an unknown union member is received, the response should be a 400
            SerializationException."""
        protocol: railsJson
        request: {
            method: "POST"
            uri: "/MalformedUnion"
            body: """
                {
                    "union": {
                        "unknown": "hello"
                    }
                }""",
            headers: {
                "content-type": "application/json"
            }
        }
        response: {
            code: 400
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    }
])

structure MalformedUnionInput {
    union: SimpleUnion
}

union SimpleUnion {
    int: Integer,

    string: String
}
