$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests

@suppress(["UnstableTrait"])
@http(uri: "/MalformedList", method: "POST")
operation MalformedList {
    input: MalformedListInput
}

apply MalformedList @httpMalformedRequestTests([
    {
        id: "RailsJsonBodyMalformedListNullItem",
        documentation: """
        When a dense list contains null, the response should be a 400
        SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedList",
            body: """
            { "bodyList" : ["a", null, "b", "c"] }""",
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
        id: "RailsJsonBodyMalformedListUnclosed",
        documentation: """
        When a list does not have a closing bracket, the response should be
        a 400 SerializationException.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedList",
            body: """
            { "bodyList" : ["a", "b", "c" }""",
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
])

structure MalformedListInput {
    bodyList: SimpleList,
}


list SimpleList {
    member: String
}

