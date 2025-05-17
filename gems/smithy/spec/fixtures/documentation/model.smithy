$version: "2"

namespace smithy.ruby.tests

@deprecated(message: "Deprecated service", since: "1.0")
@documentation("Service documentation")
@externalDocumentation("Service link": "https://www.example.com/")
@since("1.0")
@title("Documentation Test")
service Documentation {
    operations: [Operation]
}

@deprecated(message: "Deprecated operation", since: "1.0")
@documentation("Operation documentation")
@externalDocumentation("Operation link": "https://www.example.com/")
@since("1.0")
operation Operation {
    input: Foo
    output: Foo
}

@deprecated(message: "Deprecated structure", since: "1.0")
@documentation("Structure documentation")
@externalDocumentation("Structure link": "https://www.example.com/")
@sensitive
@since("1.0")
structure Foo {
    @deprecated(message: "Deprecated structure member", since: "2.0")
    @documentation("Member documentation")
    @externalDocumentation("Member link": "https://www.example.com/")
    @recommended(reason: "This is recommended")
    @since("2.0")
    baz: Baz

    @required
    bar: Baz

    qux: Structure
}

@documentation("Shape documentation")
string Baz

structure Structure {}
