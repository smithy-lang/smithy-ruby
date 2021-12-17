$version: "1.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSinkOperation,
        PaginatorsTest,
        PaginatorsTestWithItems,
        WaitersTest
    ]
}

operation KitchenSinkOperation {
    input: KitchenSink,
    output: KitchenSink,
    errors: [ClientError, ServerError],
}

structure KitchenSink {
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
    SetOfStructs: SetOfStructs,

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

set SetOfStructs {
    member: Struct,
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