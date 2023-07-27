$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@httpRequestTests([
    {
        id: "RailsJsonCanCallOperationWithNoInputOrOutput",
        protocol: railsJson,
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
        id: "RailsJsonCanCallOperationWithOptionalInput",
        protocol: railsJson,
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