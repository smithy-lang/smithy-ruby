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
    initialStructure: InitialStructure
}

@output
structure StartEventStreamOutput {
    event: Events,
    initialStructure: InitialStructure
}

@streaming
union Events {
    simpleEvent: SimpleEvent
    nestedEvent: NestedEvent
    explicitPayloadEvent: ExplicitPayloadEvent
}

structure SimpleEvent {
    message: String
}

structure NestedEvent {
    // implicit payload
    nested: NestedStructure
}

structure ExplicitPayloadEvent {
    @eventHeader
    headerA: String

    @eventPayload
    payload: NestedStructure
}

structure NestedStructure {
    values: Values
}

list Values {
    member: String
}

structure InitialStructure {
    message: String,
    nested: NestedStructure
}
