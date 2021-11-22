$version: "1.0"
namespace smithy.ruby.tests

operation ParamsTest {
    input: ParamsTestInput
}

structure ParamsTestInput {
    // simple member
    String: String,
    // complex member
    Struct: Struct,
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
