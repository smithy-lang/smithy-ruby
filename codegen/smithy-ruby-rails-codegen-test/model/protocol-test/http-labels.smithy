// This file defines test cases that test HTTP URI label bindings.
// See: https://smithy.io/2.0/spec/http-bindings.html#httplabel-trait

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#DateTime
use aws.protocoltests.shared#EpochSeconds
use aws.protocoltests.shared#HttpDate
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// The example tests how requests are serialized when there's no input
/// payload but there are HTTP labels.
@readonly
@http(method: "GET", uri: "/http_request_with_labels/{string}/{short}/{integer}/{long}/{float}/{double}/{boolean}/{timestamp}")
operation HttpRequestWithLabels {
    input: HttpRequestWithLabelsInput
}

apply HttpRequestWithLabels @httpRequestTests([
    {
        id: "RailsJsonInputWithHeadersAndAllParams",
        documentation: "Sends a GET request that uses URI label bindings",
        protocol: railsJson,
        method: "GET",
        uri: "/http_request_with_labels/string/1/2/3/4.1/5.1/true/2019-12-16t23%3a48%3a18z",
        body: "",
        params: {
            string: "string",
            short: 1,
            integer: 2,
            long: 3,
            float: 4.1,
            double: 5.1,
            boolean: true,
            timestamp: 1576540098
        }
    },
    {
        id: "RailsJsonHttpRequestLabelEscaping",
        documentation: "Sends a GET request that uses URI label bindings",
        protocol: railsJson,
        method: "GET",
        uri: "/http_request_with_labels/%20%25%3a%2f%3f%23%5b%5d%40%21%24%26%27%28%29%2a%2b%2c%3b%3d%f0%9f%98%b9/1/2/3/4.1/5.1/true/2019-12-16t23%3a48%3a18z",
        body: "",
        params: {
            string: " %:/?#[]@!$&'()*+,;=😹",
            short: 1,
            integer: 2,
            long: 3,
            float: 4.1,
            double: 5.1,
            boolean: true,
            timestamp: 1576540098
        }
    },
])

structure HttpRequestWithLabelsInput {
    @httpLabel
    @required
    string: String,

    @httpLabel
    @required
    short: Short,

    @httpLabel
    @required
    integer: Integer,

    @httpLabel
    @required
    long: Long,

    @httpLabel
    @required
    float: Float,

    @httpLabel
    @required
    double: Double,

    /// Serialized in the path as true or false.
    @httpLabel
    @required
    boolean: Boolean,

    /// Note that this member has no format, so it's serialized as an RFC 3399 date-time.
    @httpLabel
    @required
    timestamp: Timestamp,
}

/// The example tests how requests serialize different timestamp formats in the
/// URI path.
@readonly
@http(method: "GET", uri: "/http_request_with_labels_and_timestamp_format/{member_epoch_seconds}/{member_http_date}/{member_date_time}/{default_format}/{target_epoch_seconds}/{target_http_date}/{target_date_time}")
operation HttpRequestWithLabelsAndTimestampFormat {
    input: HttpRequestWithLabelsAndTimestampFormatInput
}

apply HttpRequestWithLabelsAndTimestampFormat @httpRequestTests([
    {
        id: "RailsJsonHttpRequestWithLabelsAndTimestampFormat",
        documentation: "Serializes different timestamp formats in URI labels",
        protocol: railsJson,
        method: "GET",
        uri: """
             /HttpRequestWithLabelsAndTimestampFormat\
             /1576540098\
             /Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT\
             /2019-12-16T23%3A48%3A18Z\
             /2019-12-16T23%3A48%3A18Z\
             /1576540098\
             /Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT\
             /2019-12-16T23%3A48%3A18Z""",
        body: "",
        params: {
            memberEpochSeconds: 1576540098,
            memberHttpDate: 1576540098,
            memberDateTime: 1576540098,
            defaultFormat: 1576540098,
            targetEpochSeconds: 1576540098,
            targetHttpDate: 1576540098,
            targetDateTime: 1576540098,
        }
    },
])

structure HttpRequestWithLabelsAndTimestampFormatInput {
    @httpLabel
    @required
    @timestampFormat("epoch-seconds")
    memberEpochSeconds: Timestamp,

    @httpLabel
    @required
    @timestampFormat("http-date")
    memberHttpDate: Timestamp,

    @httpLabel
    @required
    @timestampFormat("date-time")
    memberDateTime: Timestamp,

    @httpLabel
    @required
    defaultFormat: Timestamp,

    @httpLabel
    @required
    targetEpochSeconds: EpochSeconds,

    @httpLabel
    @required
    targetHttpDate: HttpDate,

    @httpLabel
    @required
    targetDateTime: DateTime,
}

// This example uses a greedy label and a normal label.
@readonly
@http(method: "GET", uri: "/http_request_with_greedy_label_in_path/foo/{foo}/baz/{baz+}")
operation HttpRequestWithGreedyLabelInPath {
    input: HttpRequestWithGreedyLabelInPathInput
}

apply HttpRequestWithGreedyLabelInPath @httpRequestTests([
    {
        id: "RailsJsonHttpRequestWithGreedyLabelInPath",
        documentation: "Serializes greedy labels and normal labels",
        protocol: railsJson,
        method: "GET",
        uri: "/http_request_with_greedy_label_in_path/foo/hello%2fescape/baz/there/guy",
        body: "",
        params: {
            foo: "hello/escape",
            baz: "there/guy",
        }
    },
])

structure HttpRequestWithGreedyLabelInPathInput {
    @httpLabel
    @required
    foo: String,

    @httpLabel
    @required
    baz: String,
}

apply HttpRequestWithFloatLabels @httpRequestTests([
    {
        id: "RailsJsonSupportsNaNFloatLabels",
        documentation: "Supports handling NaN float label values.",
        protocol: railsJson,
        method: "GET",
        uri: "/float_http_labels/na_n/na_n",
        body: "",
        params: {
            float: "NaN",
            double: "NaN",
        }
    },
    {
        id: "RailsJsonSupportsInfinityFloatLabels",
        documentation: "Supports handling Infinity float label values.",
        protocol: railsJson,
        method: "GET",
        uri: "/float_http_labels/infinity/infinity",
        body: "",
        params: {
            float: "Infinity",
            double: "Infinity",
        }
    },
    {
        id: "RailsJsonSupportsNegativeInfinityFloatLabels",
        documentation: "Supports handling -Infinity float label values.",
        protocol: railsJson,
        method: "GET",
        uri: "/float_http_labels/-infinity/-infinity",
        body: "",
        params: {
            float: "-Infinity",
            double: "-Infinity",
        }
    },
])

@readonly
@http(method: "GET", uri: "/float_http_labels/{float}/{double}")
operation HttpRequestWithFloatLabels {
    input: HttpRequestWithFloatLabelsInput
}

structure HttpRequestWithFloatLabelsInput {
    @httpLabel
    @required
    float: Float,

    @httpLabel
    @required
    double: Double,
}

apply HttpRequestWithRegexLiteral @httpRequestTests([
    {
        id: "RailsJsonToleratesRegexCharsInSegments",
        documentation: "Path matching is not broken by regex expressions in literal segments",
        protocol: railsJson,
        method: "GET",
        uri: "/re_dos_literal/abc/(a+)+",
        body: "",
        params: {
            str: "abc"
        }
    },
])

@readonly
@http(method: "GET", uri: "/re_dos_literal/{str}/(a+)+")
operation HttpRequestWithRegexLiteral {
    input: HttpRequestWithRegexLiteralInput
}

structure HttpRequestWithRegexLiteralInput {
    @httpLabel
    @required
    str: String
}
