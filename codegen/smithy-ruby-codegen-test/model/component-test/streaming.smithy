$version: "1.0"
namespace smithy.ruby.tests

operation StreamingOperation {
    input: StreamingOperationInput,
    output: StreamingOperationOutput,
}

@input
structure StreamingOperationInput {
    output: StreamingBlob,
}

@output
structure StreamingOperationOutput {
    @httpPayload
    output: StreamingBlob,
}

@streaming
blob StreamingBlob