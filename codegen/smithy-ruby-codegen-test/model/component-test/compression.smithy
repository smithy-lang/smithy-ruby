$version: "1.0"
namespace smithy.ruby.tests

@requestCompression(
    encodings: ["gzip"]
)

@http(method: "POST", uri: "/request_compress_operation")
operation RequestCompressionOperation {
    input: RequestCompressionInput
}

@http(method: "POST", uri: "/request_compress_streaming_operation")
operation RequestCompressionStreamingOperation {
    input: RequestCompressionStreamingInput
}

@input
structure RequestCompressionInput {
    @httpPayload
    body: SomeBody
}

@input
structure RequestCompressionStreamingInput {
    @httpPayload
    body: StreamingBody
}

blob SomeBody

@streaming
@requiresLength
blob StreamingBody

