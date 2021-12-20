$version: "1.0"
namespace smithy.ruby.tests

// test service is documented
apply WhiteLabel @documentation("The test SDK.\nThis service should pass the tests.")

// test operation documentation
apply KitchenSink @documentation("The kitchen sink operation.\nIt is kinda useless.")

// test member/shape documentation resolution
apply KitchenSinkInputOutput$Struct @documentation("This is some member documentation of Struct.\nIt should override Struct's documentation.")
apply Struct @documentation("This docstring should be different than KitchenSink struct member.")

// test union documentation
apply Union @documentation("This is some union documentation.\nIt has some union members")
apply Union$String @documentation("This is a String member.\nStruct should also be documented too because the structure is.")

// test examples trait
// full request syntax should be rendered too
apply KitchenSink @examples([
    {
        title: "Test input and output",
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