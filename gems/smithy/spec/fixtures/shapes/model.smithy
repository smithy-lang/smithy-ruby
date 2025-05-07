$version: "2"

namespace smithy.ruby.tests

@trait
structure shape {}

@shape
service ShapeService {
    version: "2018-10-31"
    operations: [Operation]
}

@shape
operation Operation {
    input: OperationInputOutput
    output: OperationInputOutput
}

structure OperationInputOutput {
    // https://smithy.io/2.0/spec/simple-types.html
    blob: Blob = "YmxvYg=="
    boolean: Boolean = true
    string: String = "string"
    byte: Byte = 0
    short: Short = 0
    integer: Integer = 0
    long: Long = 0
    float: Float = 0.0
    double: Double = 0.0
    bigInteger: BigInteger = 0
    bigDecimal: BigDecimal = 0.0
    timestamp: Timestamp = "1985-04-12T23:20:50.52Z"
    document: Document = null
    enum: Enum = "bar"
    intEnum: IntEnum = 1

    // https://smithy.io/2.0/spec/aggregate-types.html
    list: List = []
    map: Map = {}
    structure: Structure
    union: Union
}

@shape
blob Blob

@shape
boolean Boolean

@shape
string String

@shape
byte Byte

@shape
short Short

@shape
integer Integer

@shape
long Long

@shape
float Float

@shape
double Double

@shape
bigInteger BigInteger

@shape
bigDecimal BigDecimal

@shape
timestamp Timestamp

@shape
document Document

@shape
enum Enum {
    FOO = "bar"
}

@shape
intEnum IntEnum {
    BAZ = 1
}

@shape
list List {
    @shape
    member: String
}

@shape
map Map {
    @shape
    key: String
    @shape
    value: String
}

@shape
union Union {
    @shape
    string: String
    @shape
    structure: Structure
    @shape
    unit: Unit
}

@shape
structure Structure {
    @shape
    member: String
}
