$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.ruby.protocols#nestedAttributes

use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@httpRequestTests([
    {
        id: "rails_json_nested_attributes",
        protocol: railsJson,
        documentation: "Serializes members with nestedAttributes",
        body: "{\"simple_struct_attributes\":{\"value\":\"simple struct value\"}}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            SimpleStruct: {
                Value: "simple struct value"
            }
        },
        method: "POST",
        uri: "/nestedattributes",
    }
])
@http(method: "POST", uri: "/nestedattributes")
operation NestedAttributesOperation {
    input: NestedAttributesInput,
    output: SimpleStruct,
}

structure NestedAttributesInput {
    @nestedAttributes
    SimpleStruct: SimpleStruct
}