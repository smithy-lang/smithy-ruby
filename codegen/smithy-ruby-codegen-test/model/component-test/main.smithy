$version: "1.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSink,
        PaginatorsTest,
        PaginatorsTestWithItems,
        __PaginatorsTestWithBadNames,
        WaitersTest,
        DefaultsTest
    ]
}

operation KitchenSink {
    input: KitchenSinkInputOutput,
    output: KitchenSinkInputOutput,
    errors: [ClientError, ServerError],
}

structure KitchenSinkInputOutput {
    // simple member
    String: String,

    // complex member
    Struct: Struct,

    // document member
    Document: Document,

    // collections (simple + complex)
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,
    SetOfStrings: SetOfStrings,

    // union member
    Union: Union,
}

structure Struct {
    value: String,
}

list ListOfStrings {
    member: String,
}

list ListOfStructs {
    member: Struct,
}

map MapOfStrings {
    key: String,
    value: String,
}

map MapOfStructs {
    key: String,
    value: Struct,
}

set SetOfStrings {
    member: String,
}

union Union {
    String: String,
    Struct: Struct,
}


@error("client")
structure ClientError {
  Message: String
}

@error("server")
structure ServerError {}

operation DefaultsTest {
    input: DefaultsTestInputOutput,
    output: DefaultsTestInputOutput,
}

structure DefaultsTestInputOutput {
    // simple member
    String: String,

    // boxed
    boxedNumber: BoxedInteger,

    // members with defaults (unboxed)
    defaultNumber: DefaultInteger,
    defaultBool: DefaultBool
}

integer DefaultInteger
boolean DefaultBool

@box
integer BoxedInteger