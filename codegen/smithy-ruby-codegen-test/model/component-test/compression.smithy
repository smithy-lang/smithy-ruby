$version: "2.0"
namespace smithy.ruby.tests

@suppress(["UnstableTrait"])
@httpChecksumRequired
@requestCompression(
    encodings: ["gzip"]
)
operation RequestCompression {
    input: RequestCompressionInput
}

@suppress(["UnstableTrait"])
@requestCompression(
    encodings: ["gzip"]
)
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

