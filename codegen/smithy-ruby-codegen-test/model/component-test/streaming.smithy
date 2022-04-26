$version: "1.0"
namespace smithy.ruby.tests

@http(method: "POST", uri: "/streaming_operation")
operation StreamingOperation {
    input: StreamingOperationInput,
    output: StreamingOperationOutput,
}

@input
structure StreamingOperationInput {
    @httpPayload
    stream: StreamingBlob,
}

@output
structure StreamingOperationOutput {
    @httpPayload
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
    stream: FiniteStreamingBlob,
}

@streaming
@requiresLength
blob FiniteStreamingBlob