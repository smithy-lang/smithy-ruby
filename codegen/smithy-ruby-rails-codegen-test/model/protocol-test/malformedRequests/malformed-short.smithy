$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests

@suppress(["UnstableTrait"])
@http(uri: "/MalformedShort/{shortInPath}", method: "POST")
operation MalformedShort {
    input: MalformedShortInput
}

apply MalformedShort @httpMalformedRequestTests([
    {
        id: "RailsJsonBodyShortUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            body: """
            { "shortInBody" : $value:L }""",
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
            "value" : ["40000", "-40000", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonPathShortUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/$value:L"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["40000", "-40000", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonQueryShortUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            queryParams: [
                "shortInQuery=$value:L"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["40000", "-40000", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonHeaderShortUnderflowOverflow",
        documentation: """
        Underflow or overflow should result in SerializationException""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            headers: {
               "shortInHeader" : "$value:L"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        testParameters: {
            "value" : ["40000", "-40000", "-9223372000000000000", "9223372000000000000", "123000000000000000000000" ]
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RailsJsonBodyShortMalformedValueRejected",
        documentation: """
        Malformed values in the body should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            body: """
            { "shortInBody" : $value:L }""",
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
        id: "RailsJsonPathShortMalformedValueRejected",
        documentation: """
        Malformed values in the path should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/$value:L"
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
        id: "RailsJsonQueryShortMalformedValueRejected",
        documentation: """
        Malformed values in query parameters should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            queryParams: [
                "shortInQuery=$value:L"
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
        id: "RailsJsonHeaderShortMalformedValueRejected",
        documentation: """
        Malformed values in headers should be rejected""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedShort/1",
            headers: {
               "shortInHeader" : "$value:L"
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

structure MalformedShortInput {
    shortInBody: Short,

    @httpLabel
    @required
    shortInPath: Short,

    @httpQuery("shortInQuery")
    shortInQuery: Short,

    @httpHeader("shortInHeader")
    shortInHeader: Short
}

