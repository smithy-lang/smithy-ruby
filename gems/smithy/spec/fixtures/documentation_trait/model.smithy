$version: "2"

namespace smithy.ruby.tests

service Documentation {
    operations: [Operation]
}

@documentation("Operation documentation")
operation Operation {
    input: Foo
    output: Foo
}

@documentation("Structure documentation")
structure Foo {
    @documentation("Member documentation")
    baz: Baz

    bar: Baz

    qux: String
}

@documentation("Shape documentation")
string Baz
