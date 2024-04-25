$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@http(uri: "/EnumPayload", method: "POST")
@httpRequestTests([
    {
        id: "RailsJsonEnumPayloadRequest",
        uri: "/EnumPayload",
        body: "enumvalue",
        params: { payload: "enumvalue" },
        method: "POST",
        protocol: "smithy.ruby.protocols#railsJson"
    }
])
@httpResponseTests([
    {
        id: "RailsJsonEnumPayloadResponse",
        body: "enumvalue",
        params: { payload: "enumvalue" },
        protocol: "smithy.ruby.protocols#railsJson",
        code: 200
    }
])
operation HttpEnumPayload {
    input: EnumPayloadInput,
    output: EnumPayloadInput
}

structure EnumPayloadInput {
    @httpPayload
    payload: StringEnum
}

enum StringEnum {
    V = "enumvalue"
}

@http(uri: "/StringPayload", method: "POST")
@httpRequestTests([
    {
        id: "RailsJsonStringPayloadRequest",
        uri: "/StringPayload",
        body: "rawstring",
        params: { payload: "rawstring" },
        method: "POST",
        protocol: "smithy.ruby.protocols#railsJson"
    }
])
@httpResponseTests([
    {
        id: "RailsJsonStringPayloadResponse",
        body: "rawstring",
        params: { payload: "rawstring" },
        protocol: "smithy.ruby.protocols#railsJson",
        code: 200
    }
])
operation HttpStringPayload {
    input: StringPayloadInput,
    output: StringPayloadInput
}

structure StringPayloadInput {
    @httpPayload
    payload: String
}

