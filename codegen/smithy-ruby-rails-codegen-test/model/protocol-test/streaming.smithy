$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

@http(method: "POST", uri: "/streamingoperation")
operation StreamingOperation {
    input: StreamingOperationInput,
    output: StreamingOperationOutput,
}

@input
structure StreamingOperationInput {
    @httpPayload
    output: StreamingBlob,
}

@output
structure StreamingOperationOutput {
    @httpPayload
    output: StreamingBlob,
}

@streaming
blob StreamingBlob