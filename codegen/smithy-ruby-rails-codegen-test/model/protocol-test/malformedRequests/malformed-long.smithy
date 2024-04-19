$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests

@suppress(["UnstableTrait"])
@http(uri: "/MalformedLong/{longInPath}", method: "POST")
operation MalformedLong {
    input: MalformedLongInput
}

apply MalformedLong @httpMalformedRequestTests([
    {
        id: "RailsJsonBodyLongUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            body: """
            { "longInBody" : $value:L }""",
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
            "value" : ["-184467440737095500000", "184467440737095500000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonPathLongUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/$value:L"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["-184467440737095500000", "184467440737095500000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonQueryLongUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            queryParams: [
                "longInQuery=$value:L"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["-184467440737095500000", "184467440737095500000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonHeaderLongUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            headers: {
               "longInHeader" : "$value:L"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["-184467440737095500000", "184467440737095500000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonBodyLongMalformedValueRejected",
        documentation: """
        Malformed values in the body should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            body: """
            { "longInBody" : $value:L }""",
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
        id: "RailsJsonPathLongMalformedValueRejected",
        documentation: """
        Malformed values in the path should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/$value:L"
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
        id: "RailsJsonQueryLongMalformedValueRejected",
        documentation: """
        Malformed values in query parameters should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            queryParams: [
                "longInQuery=$value:L"
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
        id: "RailsJsonHeaderLongMalformedValueRejected",
        documentation: """
        Malformed values in headers should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedLong/1",
            headers: {
               "longInHeader" : "$value:L"
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

structure MalformedLongInput {
    longInBody: Long,

    @httpLabel
    @required
    longInPath: Long,

    @httpQuery("longInQuery")
    longInQuery: Long,

    @httpHeader("longInHeader")
    longInHeader: Long
}

