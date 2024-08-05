$version: "2.0"
namespace smithy.ruby.tests

@http(method: "POST", uri: "/streaming")
operation Streaming {
    input: StreamingInput,
    output: StreamingOutput,
}

@input
structure StreamingInput {
    @httpPayload
    @required
    stream: StreamingBlob,
}

@output
structure StreamingOutput {
    @httpPayload
    @required
    stream: StreamingBlob,
}

@streaming
blob StreamingBlob

@http(method: "POST", uri: "/streaming_with_length")
operation StreamingWithLength {
    input: StreamingWithLengthInput,
}

@input
structure StreamingWithLengthInput {
    @httpPayload
    @required
    stream: FiniteStreamingBlob,
}

@streaming
@requiresLength
blob FiniteStreamingBlob