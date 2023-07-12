$version: "1.0"
namespace smithy.ruby.tests

@requestCompression(
    encodings: ["gzip"]
)

@http(method: "POST", uri: "/some_operation")
operation SomeOperation {
    input: SomeOperationInput
}

@http(method: "POST", uri: "/some_streaming_operation")
operation SomeStreamingOperation {
    input: SomeStreamingInput
}

@input
structure SomeOperationInput {
    @httpPayload
    body: SomeBody
}

@input
structure SomeStreamingInput {
    @httpPayload
    body: SomeStreamingBody
}

blob SomeBody

@streaming
@requiresLength
blob SomeStreamingBody

