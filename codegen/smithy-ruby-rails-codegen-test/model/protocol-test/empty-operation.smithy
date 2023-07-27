$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests


@httpResponseTests([
    {
        id: "RailsJsonHandlesEmptyOutputShape",
        protocol: railsJson,
        documentation: """
                When no output is defined, the service is expected to return
                an empty payload, however, client must ignore a JSON payload
                if one is returned. This ensures that if output is added later,
                then it will not break the client.""",
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        code: 200,
        // Service implementations must ignore this test.
        appliesTo: "client"
    },
    {
        id: "RailsJsonHandlesUnexpectedJsonOutput",
        protocol: railsJson,
        documentation: """
                This client-only test builds on handles_empty_output_shape,
                by including unexpected fields in the JSON. A client
                needs to ignore JSON output that is empty or that contains
                JSON object data.""",
        body: """
            {
                "foo": true
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        code: 200,
        // Service implementations must ignore this test.
        appliesTo: "client"
    },
    {
        id: "RailsJsonServiceRespondsWithNoPayload",
        protocol: railsJson,
        documentation: """
                When no output is defined, the service is expected to return
                an empty payload. Despite the lack of a payload, the service
                is expected to always send a Content-Type header. Clients must
                handle cases where a service returns a JSON object and where
                a service returns no JSON at all.""",
        body: "",
        headers: {
            "Content-Type": "application/json",
        },
        code: 200
    },
])
@http(method: "POST", uri: "/emptyoperation")
operation EmptyOperation {}