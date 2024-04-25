$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#DateTime
use smithy.test#httpResponseTests

// These tests are for verifying the client can correctly parse
// the `DateTime` timestamp with an offset
@tags(["client-only"])
@http(uri: "/DatetimeOffsets", method: "POST")
operation DatetimeOffsets {
    output: DatetimeOffsetsOutput
}

apply DatetimeOffsets @httpResponseTests([
    {
        id: "RailsJsonDateTimeWithNegativeOffset",
        documentation: """
        Ensures that clients can correctly parse datetime (timestamps) with offsets""",
        protocol: railsJson,
        code: 200,
        body:
        """
              {
                  "datetime": "2019-12-16T22:48:18-01:00"
              }
        """,
        params: { datetime: 1576540098 }
        bodyMediaType: "application/json",
        appliesTo: "client"
    },
    {
        id: "RailsJsonDateTimeWithPositiveOffset",
        documentation: """
        Ensures that clients can correctly parse datetime (timestamps) with offsets""",
        protocol: railsJson,
        code: 200,
        body:
        """
              {
                  "datetime": "2019-12-17T00:48:18+01:00"
              }
        """,
        params: { datetime: 1576540098 }
        bodyMediaType: "application/json",
        appliesTo: "client"
    },
])

structure DatetimeOffsetsOutput {
    datetime: DateTime
}
