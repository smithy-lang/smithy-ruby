// This file defines test cases that test httpPrefix headers.
// See: https://smithy.io/2.0/spec/http-bindings.html#httpprefixheaders-trait

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests
use aws.protocoltests.shared#StringMap

/// This examples adds headers to the input of a request and response by prefix.
@readonly
@http(uri: "/http_prefix_headers", method: "GET")
@externalDocumentation("httpPrefixHeaders Trait": "https://smithy.io/2.0/spec/http-bindings.html#httpprefixheaders-trait")
operation HttpPrefixHeaders  {
    input: HttpPrefixHeadersInput,
    output: HttpPrefixHeadersOutput
}

apply HttpPrefixHeaders @httpRequestTests([
    {
        id: "RailsJsonHttpPrefixHeadersArePresent",
        documentation: "Adds headers by prefix",
        protocol: railsJson,
        method: "GET",
        uri: "/http_prefix_headers",
        body: "",
        headers: {
            "X-Foo": "Foo",
            "X-Foo-Abc": "Abc value",
            "X-Foo-Def": "Def value",
        },
        params: {
            foo: "Foo",
            fooMap: {
                Abc: "Abc value",
                Def: "Def value",
            }
        }
    },
    {
        id: "RailsJsonHttpPrefixHeadersAreNotPresent",
        documentation: "No prefix headers are serialized because the value is empty",
        protocol: railsJson,
        method: "GET",
        uri: "/http_prefix_headers",
        body: "",
        headers: {
            "X-Foo": "Foo"
        },
        params: {
            foo: "Foo",
            fooMap: {}
        },
        appliesTo: "client"
    },
])

apply HttpPrefixHeaders @httpResponseTests([
    {
        id: "RailsJsonHttpPrefixHeadersArePresent",
        documentation: "Adds headers by prefix",
        protocol: railsJson,
        code: 200,
        headers: {
            "X-Foo": "Foo",
            "X-Foo-Abc": "Abc value",
            "X-Foo-Def": "Def value",
        },
        params: {
            foo: "Foo",
            fooMap: {
                Abc: "Abc value",
                Def: "Def value",
            }
        }
    },
])

@input
structure HttpPrefixHeadersInput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPrefixHeaders("X-Foo-")
    fooMap: StringMap,
}

@output
structure HttpPrefixHeadersOutput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPrefixHeaders("X-Foo-")
    fooMap: StringMap,
}

/// Clients that perform this test extract all headers from the response.
@readonly
@http(uri: "/http_prefix_headers_response", method: "GET")
operation HttpPrefixHeadersInResponse  {
    input: HttpPrefixHeadersInResponseInput,
    output: HttpPrefixHeadersInResponseOutput
}

apply HttpPrefixHeadersInResponse @httpResponseTests([
    {
        id: "RailsJsonHttpPrefixHeadersResponse",
        documentation: "(de)serializes all response headers",
        protocol: railsJson,
        code: 200,
        headers: {
            "X-Foo": "Foo",
            "Hello": "Hello"
        },
        params: {
            prefixHeaders: {
                "X-Foo": "Foo",
                "Hello": "Hello"
            }
        }
    },
])

@input
structure HttpPrefixHeadersInResponseInput {}

@output
structure HttpPrefixHeadersInResponseOutput {
    @httpPrefixHeaders("")
    prefixHeaders: StringMap,
}
