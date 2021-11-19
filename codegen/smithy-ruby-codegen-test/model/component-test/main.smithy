$version: "1.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSinkOperation,
    ]
}

@http(method: "POST", uri: "/")
operation KitchenSinkOperation {
    input: KitchenSink,
    output: KitchenSink,
    errors: [
        ErrorWithMembers,
        ErrorWithoutMembers,
    ],
}

@error("client")
structure ErrorWithMembers {
    Code: String,
    ComplexData: KitchenSink,
    IntegerField: Integer,
    ListField: ListOfStrings,
    MapField: MapOfStrings,
    Message: String,
    /// abc
    StringField: String,
}

@error("server")
structure ErrorWithoutMembers {}

structure KitchenSink {
    Blob: Blob,
    Boolean: Boolean,
    Double: Double,
    EmptyStruct: EmptyStruct,
    Float: Float,
    @timestampFormat("http-date")
    HttpdateTimestamp: Timestamp,
    Integer: Integer,
    @timestampFormat("date-time")
    Iso8601Timestamp: Timestamp,
    JsonValue: JsonValue,
    ListOfLists: ListOfListOfStrings,
    ListOfMapsOfStrings: ListOfMapsOfStrings,
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    Long: Long,
    MapOfListsOfStrings: MapOfListsOfStrings,
    MapOfMaps: MapOfMapOfStrings,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,
    RecursiveList: ListOfKitchenSinks,
    RecursiveMap: MapOfKitchenSinks,
    RecursiveStruct: KitchenSink,
    SimpleStruct: SimpleStruct,
    String: String,
    StructWithLocationName: StructWithLocationName,
    Timestamp: Timestamp,
    @timestampFormat("epoch-seconds")
    UnixTimestamp: Timestamp,
}

list ListOfKitchenSinks {
    member: KitchenSink,
}

map MapOfKitchenSinks {
    key: String,
    value: KitchenSink,
}

structure EmptyStruct {}

structure SimpleStruct {
    Value: String,
}

structure StructWithLocationName {
    @jsonName("RenamedMember")
    Value: String,
}

list ListOfListOfStrings {
    member: ListOfStrings,
}

list ListOfMapsOfStrings {
    member: MapOfStrings,
}

list ListOfStrings {
    member: String,
}

list ListOfStructs {
    member: SimpleStruct,
}

map MapOfListsOfStrings {
    key: String,
    value: ListOfStrings,
}

map MapOfMapOfStrings {
    key: String,
    value: MapOfStrings,
}

map MapOfStrings {
    key: String,
    value: String,
}

map MapOfStructs {
    key: String,
    value: SimpleStruct,
}

@mediaType("application/json")
string JsonValue