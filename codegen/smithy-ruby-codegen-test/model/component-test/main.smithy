$version: "2.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol

@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSink,
        DefaultKitchenSink,
        PaginatorsTest,
        PaginatorsTestWithItems,
        __PaginatorsTestWithBadNames,
        WaitersTest,
        DefaultsTest,
        StreamingOperation,
        StreamingWithLength,
        EndpointOperation,
        EndpointWithHostLabelOperation
    ]
}

@http(method: "POST", uri: "/kitchen_sink")
operation KitchenSink {
    input: KitchenSinkInputOutput,
    output: KitchenSinkInputOutput,
    errors: [ClientError, ServerError],
}

structure KitchenSinkInputOutput {
    // simple member
    String: String,

    // enum members
    SimpleEnum: SimpleEnum,
    TypedEnum: TypedEnum,

    // complex member
    Struct: Struct,

    // document member
    Document: Document,

    // collections (simple + complex)
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,

    // union member
    Union: Union,
}

@suppress(["EnumNamesPresent"])
@enum([{value: "YES"}, {value: "NO"}])
string SimpleEnum

@enum([{value: "YES", name: "YES"}, {value: "NO", name: "NO"}])
string TypedEnum

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

union Union {
    String: String,
    Struct: Struct,
}


@error("client")
@retryable
structure ClientError {
  Message: String
}

@error("server")
@retryable(throttling: true)
structure ServerError {}

@http(method: "POST", uri: "/default_kitchen_sink")
operation DefaultKitchenSink {
    input: DefaultKitchenSinkInputOutput,
    output: DefaultKitchenSinkInputOutput,
    errors: [],
}

structure DefaultKitchenSinkInputOutput {
    @required
    hello: String = "world",

    @required
    SimpleEnum: SimpleEnum = "YES",

    @required
    TypedEnum: TypedEnum = "NO",

    @required
    IntEnum: IntEnumType = 1,

    @required
    nullDocument: Document = null,

    @required
    stringDocument: Document = "some string document",

    @required
    booleanDocument: Document = true,

    @required
    numbersDocument: Document = 1.23,

    @required
    listDocument: Document = [],

    @required
    mapDocument: Document = {},

    @required
    ListOfStrings: ListOfStrings = [],

    @required
    MapOfStrings: MapOfStrings = {},

    @required
    @timestampFormat("date-time")
    Iso8601Timestamp: Timestamp = "1985-04-12T23:20:50.52Z",

    @required
    @timestampFormat("epoch-seconds")
    EpochTimestamp: Timestamp = 1515531081.1234
}

intEnum IntEnumType {
    ONE = 1
    TWO = 2
    THREE = 3
}
