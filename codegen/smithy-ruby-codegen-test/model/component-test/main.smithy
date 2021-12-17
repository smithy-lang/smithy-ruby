$version: "1.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
/// The test SDK.
/// This service should pass the tests.
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

/// The kitchen sink operation
operation KitchenSink {
    /// The kitchen sink input
    input: KitchenSinkInput
}

structure KitchenSinkInput {
    // simple member
    String: String,

    // complex member
    /// This is some member documentation of Struct.
    /// It should override Struct's documentation.
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

/// This docstring should be different than KitchenSinkInput struct member.
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

/// This is some union documentation.
/// It has some union members.
union Union {
    /// This is a String member.
    /// Struct should also be documented too because the structure is.
    String: String,
    Struct: Struct,
}
