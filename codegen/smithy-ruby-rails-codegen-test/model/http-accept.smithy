$version: "1.0"

namespace aws.protocoltests.misc

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@readonly
@http(method: "GET", uri: "/test-accept-header")
@documentation("Service accepts `*` in ACCEPT header")
@httpRequestTests([
    {
        id: "RailsJsonAcceptHeaderStarRequestTest",
        protocol: "smithy.ruby.protocols#railsJson",
        uri: "/test-accept-header",
        headers: {
            "Accept": "application/*",
        },
        params: {},
        method: "GET",
        appliesTo: "server",
    },
    {
        id: "RailsJsonAcceptHeaderStarStarRequestTest",
        protocol: "smithy.ruby.protocols#railsJson",
        uri: "/test-accept-header",
        headers: {
            "Accept": "*/*",
        },
        params: {},
        method: "GET",
        appliesTo: "server",
    }
])
operation AcceptHeaderStarService {
    input: AcceptHeaderStarServiceInput,
    output: AcceptHeaderStarServiceOutput,
}

@output
structure AcceptHeaderStarServiceOutput {}
@input
structure AcceptHeaderStarServiceInput {}
