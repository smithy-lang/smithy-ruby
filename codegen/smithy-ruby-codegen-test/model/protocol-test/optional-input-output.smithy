$version: "1.0"

namespace protocoltests.RailsJson

use smithy.rails#RailsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@httpRequestTests([
    {
        id: "rails_json_can_call_operation_with_no_input_or_output",
        protocol: RailsJson,
        documentation: "Can call operations with no input or output",
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        method: "POST",
        uri: "/operationwithoptionalinputoutput",
    },
    {
        id: "rails_json_can_call_operation_with_optional_input",
        protocol: RailsJson,
        documentation: "Can invoke operations with optional input",
        body: "{\"value\":\"Hi\"}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            Value: "Hi",
        },
        method: "POST",
        uri: "/operationwithoptionalinputoutput",
    },
])
@http(method: "POST", uri: "/operationwithoptionalinputoutput")
operation OperationWithOptionalInputOutput {
    input: SimpleStruct,
    output: SimpleStruct,
}