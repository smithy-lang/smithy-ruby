$version: "1.0"
namespace smithy.ruby.tests

@httpChecksumRequired
@requestCompression(
    encodings: ["gzip"]
)
@http(method: "POST", uri: "/request_compress_operation")
operation RequestCompressionOperation {
    input: RequestCompressionInput
}

@requestCompression(
    encodings: ["gzip"]
)
@http(method: "POST", uri: "/request_compress_streaming_operation")
operation RequestCompressionStreamingOperation {
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
    body: StreamingBlob
}

