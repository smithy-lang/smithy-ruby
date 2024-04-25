$version: "2.0"
namespace smithy.ruby.tests

@suppress(["HttpBindingsMissing"])
operation DefaultsTest {
    input: DefaultsTestInputOutput,
    output: DefaultsTestInputOutput,
}

structure DefaultsTestInputOutput {
    String: String,

    @suppress(["DeprecatedShape"])
    struct: Struct

    unRequiredNumber: DefaultInteger = 0,

    unRequiredBool: DefaultBool = false,

    @required
    Number: DefaultInteger = 0,

    @required
    Bool: DefaultBool = false,

    @required
    hello: String = "world",

    @required
    simpleEnum: SimpleEnum = "YES",

    @required
    typedEnum: TypedEnum = "no",

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

@default(0)
integer DefaultInteger

@default(false)
boolean DefaultBool

intEnum IntEnumType {
    ONE = 1
    TWO = 2
    THREE = 3
}