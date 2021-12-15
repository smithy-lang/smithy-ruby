$version: "1.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        ErrorsTest,
        KitchenSink,
        PaginatorsTest,
        PaginatorsTestWithItems,
        WaitersTest
    ]
}

operation KitchenSink {
    input: KitchenSinkInput
}

structure KitchenSinkInput {
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

/// This is a very long string that I want to test with wrapping. There is a lot of typing to do
/// if I want to support long doc strings. Why is documentation so hard to generate? It is very
/// annoying.
structure Struct {
    /// this documents value
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
