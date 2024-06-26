$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#DateTime
use smithy.test#httpResponseTests

// These tests verify that clients can parse `DateTime` timestamps with fractional seconds.
@tags(["client-only"])
@http(uri: "/FractionalSeconds", method: "POST")
operation FractionalSeconds {
    output: FractionalSecondsOutput
}

apply FractionalSeconds @httpResponseTests([
    {
        id: "RailsJsonDateTimeWithFractionalSeconds",
        documentation: """
        Ensures that clients can correctly parse datetime timestamps with fractional seconds""",
        protocol: railsJson,
        code: 200,
        body:
        """
              {
                  "datetime": "2000-01-02T20:34:56.123Z"
              }
        """,
        params: { datetime: 946845296.123 }
        bodyMediaType: "application/json",
        appliesTo: "client"
    }
])

structure FractionalSecondsOutput {
    datetime: DateTime
}
