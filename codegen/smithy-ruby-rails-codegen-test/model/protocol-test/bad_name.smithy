$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests


@httpRequestTests([
    {
        id: "rails_json_serializes_bad_names",
        protocol: railsJson,
        documentation: "Serializes requests for operations/members with bad names",
        body: "{\"member\":{\"__123foo\":\"foo value\"}}",
        headers: {"Content-Type": "application/json"},
        bodyMediaType: "application/json",
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            __123abc: "abc_value",
            Member: {
                __123foo: "foo value"
            }
        },
        method: "POST",
        uri: "/BadName/abc_value",
    }
])
@httpResponseTests([
    {
        id: "rails_json_parses_bad_names",
        protocol: railsJson,
        documentation: "Parses responses for operations/members with bad names",
        body: "{\"member\":{\"__123foo\":\"foo value\"}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Member: {
                __123foo: "foo value"
            }
        },
        code: 200,
    }
])
@http(method: "POST", uri: "/BadName/{__123abc}")
operation __789BadName {
    input: __BadNameInput,
    output: __BadNameOutput,
}

structure __BadNameInput {
    @required
    @httpLabel
    __123abc: String,

    Member: __456efg,
}

structure __BadNameOutput {
    Member: __456efg,
}

structure __456efg {
    __123foo: String,
}