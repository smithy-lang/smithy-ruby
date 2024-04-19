$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests

@suppress(["UnstableTrait"])
@http(uri: "/MalformedByte/{byteInPath}", method: "POST")
operation MalformedByte {
    input: MalformedByteInput
}

apply MalformedByte @httpMalformedRequestTests([
    {
        id: "RailsJsonBodyByteUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            body: """
            { "byteInBody" : $value:L }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["256", "-256", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonPathByteUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/$value:L"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["256", "-256", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonQueryByteUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            queryParams: [
                "byteInQuery=$value:L"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["256", "-256", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonHeaderByteUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            headers: {
               "byteInHeader" : "$value:L"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["256", "-256", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonBodyByteMalformedValueRejected",
        documentation: """
        Malformed values in the body should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            body: """
            { "byteInBody" : $value:L }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters : {
            "value" : ["\"123\"", "true", "1.001", "2ABC", "0x42",
                       "Infinity", "\"Infinity\"", "-Infinity", "\"-Infinity\"", "NaN", "\"NaN\""],
            "tag" : ["string_coercion", "boolean_coercion", "float_truncation", "trailing_chars", "hex",
                       "inf", "string_inf", "negative_inf", "string_negative_inf", "nan", "string_nan"]
        },
        tags: [ "$tag:L" ]
    },
    {
        id: "RailsJsonPathByteMalformedValueRejected",
        documentation: """
        Malformed values in the path should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/$value:L"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters : {
            "value" : ["true", "1.001", "2ABC", "0x42", "Infinity", "-Infinity", "NaN"],
            "tag" : ["boolean_coercion", "float_truncation", "trailing_chars", "hex", "inf", "negative_inf", "nan"]
        },
        tags: [ "$tag:L" ]
    },
    {
        id: "RailsJsonQueryByteMalformedValueRejected",
        documentation: """
        Malformed values in query parameters should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            queryParams: [
                "byteInQuery=$value:L"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters : {
            "value" : ["true", "1.001", "2ABC", "0x42", "Infinity", "-Infinity", "NaN"],
            "tag" : ["boolean_coercion", "float_truncation", "trailing_chars", "hex", "inf", "negative_inf", "nan"]
        },
        tags: [ "$tag:L" ]
    },
    {
        id: "RailsJsonHeaderByteMalformedValueRejected",
        documentation: """
        Malformed values in headers should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedByte/1",
            headers: {
               "byteInHeader" : "$value:L"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters : {
            "value" : ["true", "1.001", "2ABC", "0x42", "Infinity", "-Infinity", "NaN"],
            "tag" : ["boolean_coercion", "float_truncation", "trailing_chars", "hex", "inf", "negative_inf", "nan"]
        },
        tags: [ "$tag:L" ]
    },
])

structure MalformedByteInput {
    byteInBody: Byte,

    @httpLabel
    @required
    byteInPath: Byte,

    @httpQuery("byteInQuery")
    byteInQuery: Byte,

    @httpHeader("byteInHeader")
    byteInHeader: Byte
}

