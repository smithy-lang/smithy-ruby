$version: "2.0"

namespace smithy.ruby.tests

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
