// This file defines tests to ensure that implementations support endpoints with paths

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests

@httpRequestTests([
    {
        id: "RailsJsonHostWithPath",
        documentation: """
                Custom endpoints supplied by users can have paths""",
        protocol: railsJson,
        method: "GET",
        uri: "/custom/HostWithPathOperation",
        body: "",
        host: "example.com/custom",
        appliesTo: "client"
    }
])
@readonly
@http(uri: "/HostWithPathOperation", method: "GET")
operation HostWithPathOperation {}
