$version: "1.0"
namespace smithy.ruby.tests

// test service documentation
apply WhiteLabel @documentation("The test SDK.\nThis service should pass the tests.")
apply WhiteLabel @deprecated(message: "This test SDK is not suitable\nfor production use.", since: "today")

// test operation documentation
apply KitchenSink @documentation("The kitchen sink operation.\nIt is kinda useless.")
apply KitchenSink @deprecated(message: "This operation is not suitable\nfor production use.", since: "today")

// test member/shape documentation resolution
apply KitchenSinkInputOutput$Struct @documentation("This is some member documentation of Struct.\nIt should override Struct's documentation.")
apply Struct @documentation("This docstring should be different than KitchenSink struct member.")

// test union documentation
apply Union @documentation("This is some union documentation.\nIt has some union members")
apply Union$String @documentation("This is a String member.\nStruct should also be documented too because the structure is.")
apply Union @deprecated(message: "This union is\ndeprecated.", since: "today")
apply Union$Struct @deprecated(message: "This union structure is\ndeprecated.", since: "today")

// test examples trait
// full request syntax should be rendered too
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