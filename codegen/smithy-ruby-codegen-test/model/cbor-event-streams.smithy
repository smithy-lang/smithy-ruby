$version: "2.0"
namespace smithy.ruby.eventstreamtests

use smithy.protocols#rpcv2Cbor

@rpcv2Cbor(
    http: ["h2", "http/1.1"],
    eventStreamHttp: ["h2"]
)
@title("RpcV2Cbor Event Streams Test Service")
service CborEventStreams {
    version: "2018-01-01",
    operations: [
        NonStreamingOperation,
        StartEventStream
    ]
}

operation NonStreamingOperation {
    input: NonStreamingOperationInput
    output: NonStreamingOperationOutput
}

structure NonStreamingOperationInput {
    inputValue: String
}

structure NonStreamingOperationOutput {
    outputValue: String
}

operation StartEventStream {
    input: StartEventStreamInput
    output: StartEventStreamOutput
}

@input
structure StartEventStreamInput {
    event: Events
}

@output
structure StartEventStreamOutput {
    event: Events
}

@streaming
union Events {
    eventA: EventA
    eventB: EventB
}

structure EventA {
    message: String
}

structure EventB {
    nested: NestedEvent
}

structure NestedEvent {
    values: EventValues
}

list EventValues {
    member: String
}
