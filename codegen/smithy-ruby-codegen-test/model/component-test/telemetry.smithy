$version: "2.0"
namespace smithy.ruby.tests

@http(method: "POST", uri: "/telemetry")
operation Telemetry {
    input: TelemetryInputOutput
    output: TelemetryInputOutput
}

structure TelemetryInputOutput {
    body: String
}
