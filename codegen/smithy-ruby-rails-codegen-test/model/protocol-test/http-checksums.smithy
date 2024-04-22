// This file defines test cases that test HTTP checksum trait(s).
// See: https://smithy.io/2.0/spec/http-bindings.html#httpchecksumrequired-trait
$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests

/// This example tests httpChecksumRequired trait
@suppress(["UnstableTrait"])
@httpChecksumRequired
@http(uri: "/http_checksum_required", method: "POST")
operation HttpChecksumRequired {
    input: HttpChecksumRequiredInputOutput,
    output: HttpChecksumRequiredInputOutput
}

structure HttpChecksumRequiredInputOutput{
    foo: String
}

apply HttpChecksumRequired @httpRequestTests([
    {
        id: "RailsJsonHttpChecksumRequired",
        documentation: "Adds Content-MD5 header",
        protocol: railsJson,
        method: "POST",
        uri: "/http_checksum_required",
        body: """
        {
            "foo":"base64 encoded md5 checksum"
        }
        """,
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
            "Content-MD5": "iB0/3YSo7maijL0IGOgA9g=="
        },
        params: {
            foo: "base64 encoded md5 checksum"
        }
    }
])
