$version: "2.0"
namespace smithy.ruby.tests

@auth([])
@http(method: "POST", uri: "/telemetry_test")
operation TelemetryTest {
    input: TelemetryInputOutput
    output: TelemetryInputOutput
}

structure TelemetryInputOutput {
    @httpPayload
    body: String
}