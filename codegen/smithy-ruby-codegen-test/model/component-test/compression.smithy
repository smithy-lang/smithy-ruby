$version: "2.0"
namespace smithy.ruby.tests

@suppress(["UnstableTrait"])
@httpChecksumRequired
@requestCompression(
    encodings: ["gzip"]
)
@http(method: "POST", uri: "/request_compression")
operation RequestCompression {
    input: RequestCompressionInput
}

@suppress(["UnstableTrait"])
@requestCompression(
    encodings: ["gzip"]
)
@http(method: "POST", uri: "/request_compression_streaming")
operation RequestCompressionStreaming {
    input: RequestCompressionStreamingInput
}

@input
structure RequestCompressionInput {
    @httpPayload
    body: Blob
}

@input
structure RequestCompressionStreamingInput {
    @httpPayload
    @required
    body: StreamingBlob
}

