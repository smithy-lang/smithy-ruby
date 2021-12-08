// This file defines test cases that test HTTP query string bindings.
// See: https://awslabs.github.io/smithy/1.0/spec/http.html#httpquery-trait and
// https://awslabs.github.io/smithy/1.0/spec/http.html#httpqueryparams-trait

$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#BooleanList
use aws.protocoltests.shared#DoubleList
use aws.protocoltests.shared#FooEnum
use aws.protocoltests.shared#FooEnumList
use aws.protocoltests.shared#IntegerList
use aws.protocoltests.shared#IntegerSet
use aws.protocoltests.shared#StringList
use aws.protocoltests.shared#StringListMap
use aws.protocoltests.shared#StringMap
use aws.protocoltests.shared#StringSet
use aws.protocoltests.shared#TimestampList
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This example uses all query string types.
@readonly
@http(uri: "/AllQueryStringTypesInput", method: "GET")
operation AllQueryStringTypes {
    input: AllQueryStringTypesInput
}

apply AllQueryStringTypes @httpRequestTests([
    {
        id: "RailsJsonAllQueryStringTypes",
        documentation: "Serializes query string parameters with all supported types",
        protocol: railsJson,
        method: "GET",
        uri: "/AllQueryStringTypesInput",
        body: "",
        queryParams: [
            "String=Hello%20there",
            "StringList=a",
            "StringList=b",
            "StringList=c",
            "StringSet=a",
            "StringSet=b",
            "StringSet=c",
            "Byte=1",
            "Short=2",
            "Integer=3",
            "IntegerList=1",
            "IntegerList=2",
            "IntegerList=3",
            "IntegerSet=1",
            "IntegerSet=2",
            "IntegerSet=3",
            "Long=4",
            "Float=1.1",
            "Double=1.1",
            "DoubleList=1.1",
            "DoubleList=2.1",
            "DoubleList=3.1",
            "Boolean=true",
            "BooleanList=true",
            "BooleanList=false",
            "BooleanList=true",
            "Timestamp=1970-01-01T00%3A00%3A01.000Z",
            "TimestampList=1970-01-01T00%3A00%3A01.000Z",
            "TimestampList=1970-01-01T00%3A00%3A02.000Z",
            "TimestampList=1970-01-01T00%3A00%3A03.000Z",
            "Enum=Foo",
            "EnumList=Foo",
            "EnumList=Baz",
            "EnumList=Bar",
            "QueryParamsStringKeyA=Foo",
            "QueryParamsStringKeyB=Bar",
        ],
        params: {
            queryString: "Hello there",
            queryStringList: ["a", "b", "c"],
            queryStringSet: ["a", "b", "c"],
            queryByte: 1,
            queryShort: 2,
            queryInteger: 3,
            queryIntegerList: [1, 2, 3],
            queryIntegerSet: [1, 2, 3],
            queryLong: 4,
            queryFloat: 1.1,
            queryDouble: 1.1,
            queryDoubleList: [1.1, 2.1, 3.1],
            queryBoolean: true,
            queryBooleanList: [true, false, true],
            queryTimestamp: 1,
            queryTimestampList: [1, 2, 3],
            queryEnum: "Foo",
            queryEnumList: ["Foo", "Baz", "Bar"],
            queryParamsMapOfStrings: {
                "QueryParamsStringKeyA": "Foo",
                "QueryParamsStringKeyB": "Bar"
            },
        }
    }
])

structure AllQueryStringTypesInput {
    @httpQuery("String")
    queryString: String,

    @httpQuery("StringList")
    queryStringList: StringList,

    @httpQuery("StringSet")
    queryStringSet: StringSet,

    @httpQuery("Byte")
    queryByte: Byte,

    @httpQuery("Short")
    queryShort: Short,

    @httpQuery("Integer")
    queryInteger: Integer,

    @httpQuery("IntegerList")
    queryIntegerList: IntegerList,

    @httpQuery("IntegerSet")
    queryIntegerSet: IntegerSet,

    @httpQuery("Long")
    queryLong: Long,

    @httpQuery("Float")
    queryFloat: Float,

    @httpQuery("Double")
    queryDouble: Double,

    @httpQuery("DoubleList")
    queryDoubleList: DoubleList,

    @httpQuery("Boolean")
    queryBoolean: Boolean,

    @httpQuery("BooleanList")
    queryBooleanList: BooleanList,

    @httpQuery("Timestamp")
    queryTimestamp: Timestamp,

    @httpQuery("TimestampList")
    queryTimestampList: TimestampList,

    @httpQuery("Enum")
    queryEnum: FooEnum,

    @httpQuery("EnumList")
    queryEnumList: FooEnumList,

    @httpQueryParams
    queryParamsMapOfStrings: StringMap,
}

/// This example uses a constant query string parameters and a label.
/// This simply tests that labels and query string parameters are
/// compatible. The fixed query string parameter named "hello" should
/// in no way conflict with the label, `{hello}`.
@readonly
@http(uri: "/ConstantQueryString/{hello}?foo=bar&hello", method: "GET")
@httpRequestTests([
    {
        id: "RailsJsonConstantQueryString",
        documentation: "Includes constant query string parameters",
        protocol: railsJson,
        method: "GET",
        uri: "/ConstantQueryString/hi",
        queryParams: [
            "foo=bar",
            "hello",
        ],
        body: "",
        params: {
            hello: "hi"
        }
    },
])
operation ConstantQueryString {
    input: ConstantQueryStringInput
}

structure ConstantQueryStringInput {
    @httpLabel
    @required
    hello: String,
}

/// This example uses fixed query string params and variable query string params.
/// The fixed query string parameters and variable parameters must both be
/// serialized (implementations may need to merge them together).
@readonly
@http(uri: "/ConstantAndVariableQueryString?foo=bar", method: "GET")
operation ConstantAndVariableQueryString {
    input: ConstantAndVariableQueryStringInput
}

apply ConstantAndVariableQueryString @httpRequestTests([
    {
        id: "RailsJsonConstantAndVariableQueryStringMissingOneValue",
        documentation: "Mixes constant and variable query string parameters",
        protocol: railsJson,
        method: "GET",
        uri: "/ConstantAndVariableQueryString",
        queryParams: [
            "foo=bar",
            "baz=bam",
        ],
        forbidQueryParams: ["maybeSet"],
        body: "",
        params: {
            baz: "bam"
        }
    },
    {
        id: "RailsJsonConstantAndVariableQueryStringAllValues",
        documentation: "Mixes constant and variable query string parameters",
        protocol: railsJson,
        method: "GET",
        uri: "/ConstantAndVariableQueryString",
        queryParams: [
            "foo=bar",
            "baz=bam",
            "maybeSet=yes"
        ],
        body: "",
        params: {
            baz: "bam",
            maybeSet: "yes"
        }
    },
])

structure ConstantAndVariableQueryStringInput {
    @httpQuery("baz")
    baz: String,

    @httpQuery("maybeSet")
    maybeSet: String,
}

/// This example ensures that query string bound request parameters are
/// serialized in the body of responses if the structure is used in both
/// the request and response.
@readonly
@http(uri: "/IgnoreQueryParamsInResponse", method: "GET")
operation IgnoreQueryParamsInResponse {
    output: IgnoreQueryParamsInResponseOutput
}

apply IgnoreQueryParamsInResponse @httpResponseTests([
    {
        id: "RailsJsonIgnoreQueryParamsInResponse",
        documentation: """
                Query parameters must be ignored when serializing the output
                of an operation. As of January 2021, server implementations
                are expected to respond with a JSON object regardless of
                if the output parameters are empty.""",
        protocol: railsJson,
        code: 200,
        headers: {
            "Content-Type": "application/json"
        },
        body: "{}",
        bodyMediaType: "application/json",
        params: {}
    },
    {
        id: "RailsJsonIgnoreQueryParamsInResponseNoPayload",
        documentation: """
                This test is similar to RestJsonIgnoreQueryParamsInResponse,
                but it ensures that clients gracefully handle responses from
                the server that do not serialize an empty JSON object.""",
        protocol: railsJson,
        code: 200,
        body: "",
        params: {},
        appliesTo: "client",
    },
])

structure IgnoreQueryParamsInResponseOutput {
    @httpQuery("baz")
    baz: String
}

/// Omits null, but serializes empty string value.
@readonly
@http(uri: "/OmitsNullSerializesEmptyString", method: "GET")
operation OmitsNullSerializesEmptyString {
    input: OmitsNullSerializesEmptyStringInput
}

apply OmitsNullSerializesEmptyString @httpRequestTests([
    {
        id: "RailsJsonOmitsNullQuery",
        documentation: "Omits null query values",
        protocol: railsJson,
        method: "GET",
        uri: "/OmitsNullSerializesEmptyString",
        body: "",
        params: {
            nullValue: null
        },
        "appliesTo": "client",
    },
    {
        id: "RailsJsonSerializesEmptyQueryValue",
        documentation: "Serializes empty query strings",
        protocol: railsJson,
        method: "GET",
        uri: "/OmitsNullSerializesEmptyString",
        body: "",
        queryParams: [
            "Empty=",
        ],
        params: {
            emptyString: "",
        },
    },
])

structure OmitsNullSerializesEmptyStringInput {
    @httpQuery("Null")
    nullValue: String,

    @httpQuery("Empty")
    emptyString: String,
}

// httpQueryParams as Map of ListStrings
@http(uri: "/StringListMap", method: "POST")
operation QueryParamsAsStringListMap {
    input: QueryParamsAsStringListMapInput
}

apply QueryParamsAsStringListMap @httpRequestTests([
    {
        id: "RailsJsonQueryParamsStringListMap",
        documentation: "Serialize query params from map of list strings",
        protocol: railsJson,
        method: "POST",
        uri: "/StringListMap",
        body: "",
        queryParams: [
            "corge=named",
            "baz=bar",
            "baz=qux"
        ],
        params: {
            qux: "named",
            foo: {
                "baz": ["bar", "qux"]
            }
        },
        appliesTo: "client"
    },
    {
        id: "RailsJsonServersQueryParamsStringListMap",
        documentation: "Servers put all query params in map",
        protocol: railsJson,
        method: "POST",
        uri: "/StringListMap",
        body: "",
        queryParams: [
            "corge=named",
            "baz=bar",
            "baz=qux"
        ],
        params: {
            qux: "named",
            foo: {
                "corge": ["named"],
                "baz": ["bar", "qux"]
            }
        },
        appliesTo: "server"
    }
])

structure QueryParamsAsStringListMapInput {
    @httpQuery("corge")
    qux: String,

    @httpQueryParams
    foo: StringListMap
}