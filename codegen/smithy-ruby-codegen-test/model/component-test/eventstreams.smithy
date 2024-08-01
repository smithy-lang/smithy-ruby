$version: "2.0"

namespace smithy.ruby.tests

@optionalAuth
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
    message: String

    @eventHeader
    headerA: String
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