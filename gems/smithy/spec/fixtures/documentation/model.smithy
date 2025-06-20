$version: "2"

namespace smithy.ruby.tests

@deprecated(message: "Deprecated service", since: "1.0")
@documentation("Service documentation")
@externalDocumentation("Service link": "https://www.example.com/")
@since("1.0")
@title("Documentation Test")
@unstable
service Documentation {
    operations: [Operation]
}

@deprecated(message: "Deprecated operation", since: "1.0")
@documentation("Operation documentation")
@externalDocumentation("Operation link": "https://www.example.com/")
@since("1.0")
@unstable
operation Operation {
    input: OperationInputOutput
    output: OperationInputOutput
}

structure OperationInputOutput {
    structure: Structure
    enum: Enum
    intEnum: IntEnum
    union: Union
}

@deprecated(message: "Deprecated structure", since: "1.0")
@documentation("Structure documentation")
@externalDocumentation("Structure link": "https://www.example.com/")
@sensitive
@since("1.0")
@unstable
structure Structure {
    @deprecated(message: "Deprecated structure member", since: "2.0")
    @documentation("Structure member documentation")
    @externalDocumentation("Structure member link": "https://www.example.com/")
    @recommended(reason: "This is recommended")
    @since("2.0")
    @unstable
    documentedMember: String

    undocumentedMember: String
}

@deprecated(message: "Deprecated enum", since: "1.0")
@documentation("Enum documentation")
@externalDocumentation("Enum link": "https://www.example.com/")
@sensitive
@since("1.0")
@unstable
enum Enum {
    @deprecated(message: "Deprecated enum member", since: "2.0")
    @documentation("Enum member documentation")
    @externalDocumentation("Enum member link": "https://www.example.com/")
    @since("2.0")
    @unstable
    MEMBER
}

@deprecated(message: "Deprecated int enum", since: "1.0")
@documentation("Int enum documentation")
@externalDocumentation("Int enum link": "https://www.example.com/")
@sensitive
@since("1.0")
@unstable
intEnum IntEnum {
    @deprecated(message: "Deprecated int enum member", since: "2.0")
    @documentation("Int enum member documentation")
    @externalDocumentation("Int enum member link": "https://www.example.com/")
    @since("2.0")
    @unstable
    MEMBER = 1
}

@deprecated(message: "Deprecated union", since: "1.0")
@documentation("Union documentation")
@externalDocumentation("Union link": "https://www.example.com/")
@sensitive
@since("1.0")
@unstable
union Union {
    @deprecated(message: "Deprecated union member", since: "2.0")
    @documentation("Union member documentation")
    @externalDocumentation("Union member link": "https://www.example.com/")
    @since("2.0")
    @unstable
    documentedMember: String

    undocumentedMember: String
}

@documentation("Shape documentation")
string String
