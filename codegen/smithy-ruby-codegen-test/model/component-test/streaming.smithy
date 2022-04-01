$version: "1.0"
namespace smithy.ruby.tests

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