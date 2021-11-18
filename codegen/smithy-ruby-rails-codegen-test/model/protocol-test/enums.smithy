$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#FooEnum
use aws.protocoltests.shared#FooEnumList
use aws.protocoltests.shared#FooEnumSet
use aws.protocoltests.shared#FooEnumMap
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This example serializes enums as top level properties, in lists, sets, and maps.
@idempotent
@http(method: "POST", uri: "/jsonenums")
operation JsonEnums {
    input: JsonEnumsInputOutput,
    output: JsonEnumsInputOutput
}

apply JsonEnums @httpRequestTests([
    {
        id: "RailsJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        method: "POST",
        uri: "/jsonenums",
        body: """
              {
                  "foo_enum1": "Foo",
                  "foo_enum2": "0",
                  "foo_enum3": "1",
                  "foo_enum_list": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_set": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_map": {
                      "hi": "Foo",
                      "zero": "0"
                  }
              }""",
        headers: {"Content-Type": "application/json"},
        bodyMediaType: "application/json",
        params: {
            fooEnum1: "Foo",
            fooEnum2: "0",
            fooEnum3: "1",
            fooEnumList: ["Foo", "0"],
            fooEnumSet: ["Foo", "0"],
            fooEnumMap: {
                "hi": "Foo",
                "zero": "0"
            }
        }
    }
])

apply JsonEnums @httpResponseTests([
    {
        id: "RailsJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "foo_enum1": "Foo",
                  "foo_enum2": "0",
                  "foo_enum3": "1",
                  "foo_enum_list": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_set": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_map": {
                      "hi": "Foo",
                      "zero": "0"
                  }
              }""",
        headers: {"Content-Type": "application/json"},
        bodyMediaType: "application/json",
        params: {
            fooEnum1: "Foo",
            fooEnum2: "0",
            fooEnum3: "1",
            fooEnumList: ["Foo", "0"],
            fooEnumSet: ["Foo", "0"],
            fooEnumMap: {
                "hi": "Foo",
                "zero": "0"
            }
        }
    }
])

structure JsonEnumsInputOutput {
    fooEnum1: FooEnum,
    fooEnum2: FooEnum,
    fooEnum3: FooEnum,
    fooEnumList: FooEnumList,
    fooEnumSet: FooEnumSet,
    fooEnumMap: FooEnumMap,
}