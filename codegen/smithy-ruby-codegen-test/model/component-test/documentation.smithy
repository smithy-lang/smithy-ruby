$version: "1.0"
namespace smithy.ruby.tests

// test service shape documentation
apply WhiteLabel @documentation("The test SDK.\nThis service should pass the tests.")
apply WhiteLabel @deprecated(message: "This test SDK is not suitable\nfor production use.", since: "today")
apply WhiteLabel @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply WhiteLabel @internal
apply WhiteLabel @since("today")
apply WhiteLabel @unstable

// test operation shape documentation
apply KitchenSink @documentation("The kitchen sink operation.\nIt is kinda useless.")
apply KitchenSink @deprecated(message: "This operation is not suitable\nfor production use.", since: "today")
apply KitchenSink @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply KitchenSink @internal
apply KitchenSink @since("today")
apply KitchenSink @unstable

// full request/response syntax should be rendered too
apply KitchenSink @examples([
    {
        title: "Test input and output",
        documentation: "Demonstrates setting a range of input values and getting different types of outputs.",
        input: {
            String: "Test",
            Struct: { value: "struct" },
            Document: { thing: true, string: "hello" },
            ListOfStrings: ["foo", "bar"],
            ListOfStructs: [ { value: "struct1" }, { value: "struct2" } ],
            MapOfStrings: { key1: "value1", key2: "value2" },
            MapOfStructs: { key1: { value: "struct1" }, key2: { value: "struct2" } },
            SetOfStrings: ["set", "of", "strings"],
            SetOfStructs: [ { value: "struct1" }, { value: "struct2" } ],
            Union: { String: "union string" }
        },
        output: {
            String: "Test output",
            Struct: { value: "struct" },
            Document: { thing: true, string: "hello" },
            ListOfStrings: ["foo", "bar"],
            ListOfStructs: [ { value: "struct1" }, { value: "struct2" } ],
            MapOfStrings: { key1: "value1", key2: "value2" },
            MapOfStructs: { key1: { value: "struct1" }, key2: { value: "struct2" } },
            SetOfStrings: ["set", "of", "strings"],
            SetOfStructs: [ { value: "struct1" }, { value: "struct2" } ],
            Union: { Struct: { value: "union struct" } }
        }
    },
    {
        title: "Test errors",
        documentation: "Demonstrates an error example.",
        input: {
            String: "error",
        },
        error: {
            shapeId: smithy.ruby.tests#ClientError,
            content: {
                Message: "Client error",
            }
        }
    },
])

// test structure documentation
apply Struct @documentation("This docstring should be different than KitchenSink struct member.")
apply Struct @deprecated(message: "This structure is\ndeprecated.", since: "today")
apply Struct @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply Struct @internal
apply Struct @since("today")
apply Struct @unstable
apply Struct @sensitive

// test structure member documentation
apply KitchenSinkInputOutput$String @documentation("This is some member\ndocumentation of String.")
apply KitchenSinkInputOutput$String @deprecated(message: "This structure member is\ndeprecated.", since: "today")
apply KitchenSinkInputOutput$String @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply KitchenSinkInputOutput$String @internal
apply KitchenSinkInputOutput$String @since("today")
apply KitchenSinkInputOutput$String @unstable
apply KitchenSinkInputOutput$String @recommended(reason: "This structure member is\ncool AF.")
apply KitchenSinkInputOutput$String @sensitive

// test structure member documentation resolution
apply KitchenSinkInputOutput$Struct @documentation("This is some member documentation of Struct.\nIt should override Struct's documentation.")

// test union documentation
apply Union @documentation("This is some union documentation.\nIt has some union members")
apply Union @deprecated(message: "This union is\ndeprecated.", since: "today")
apply Union @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply Union @internal
apply Union @since("today")
apply Union @unstable
apply Union @sensitive

// test union member documentation
apply Union$String @documentation("This is a String member.\nStruct should also be documented too because the structure is.")
apply Union$String @deprecated(message: "This union member is\ndeprecated.", since: "today")
apply Union$String @externalDocumentation(
    "Homepage": "https://www.ruby-lang.org/en/",
    "Ruby Branches": "https://www.ruby-lang.org/en/downloads/branches/",
)
apply Union$String @internal
apply Union$String @since("today")
apply Union$String @unstable
apply Union$String @sensitive
