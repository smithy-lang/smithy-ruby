// This file defines test cases that serialize unions.

$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests
use aws.protocoltests.shared#StringList
use aws.protocoltests.shared#StringMap
use aws.protocoltests.shared#GreetingStruct
use aws.protocoltests.shared#FooEnum


/// This operation uses unions for inputs and outputs.
@http(method: "POST", uri: "/jsonunions")
@idempotent
operation JsonUnions {
    input: UnionInputOutput,
    output: UnionInputOutput,
}

/// A shared structure that contains a single union member.
structure UnionInputOutput {
    contents: MyUnion
}

/// A union with a representative set of types for members.
union MyUnion {
    stringValue: String,
    booleanValue: Boolean,
    numberValue: Integer,
    blobValue: Blob,
    timestampValue: Timestamp,
    enumValue: FooEnum,
    listValue: StringList,
    mapValue: StringMap,
    structureValue: GreetingStruct,
}

apply JsonUnions @httpRequestTests([
    {
        id: "RailsJsonSerializeStringUnionValue",
        documentation: "Serializes a string union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "string_value": "foo"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                stringValue: "foo"
            }
        }
    },
    {
        id: "RailsJsonSerializeBooleanUnionValue",
        documentation: "Serializes a boolean union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "boolean_value": true
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                booleanValue: true
            }
        }
    },
    {
        id: "RailsJsonSerializeNumberUnionValue",
        documentation: "Serializes a number union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "number_value": 1
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                numberValue: 1
            }
        }
    },
    {
        id: "RailsJsonSerializeBlobUnionValue",
        documentation: "Serializes a blob union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "blob_value": "Zm9v"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                blobValue: "foo"
            }
        }
    },
    {
        id: "RailsJsonSerializeTimestampUnionValue",
        documentation: "Serializes a timestamp union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "timestamp_value": "2014-04-29T18:30:38.000Z"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                timestampValue: 1398796238
            }
        }
    },
    {
        id: "RailsJsonSerializeEnumUnionValue",
        documentation: "Serializes an enum union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "enum_value": "Foo"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                enumValue: "Foo"
            }
        }
    },
    {
        id: "RailsJsonSerializeListUnionValue",
        documentation: "Serializes a list union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "list_value": ["foo", "bar"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                listValue: ["foo", "bar"]
            }
        }
    },
    {
        id: "RailsJsonSerializeMapUnionValue",
        documentation: "Serializes a map union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "map_value": {
                        "foo": "bar",
                        "spam": "eggs"
                    }
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                mapValue: {
                    foo: "bar",
                    spam: "eggs",
                }
            }
        }
    },
    {
        id: "RailsJsonSerializeStructureUnionValue",
        documentation: "Serializes a structure union value",
        protocol: railsJson,
        method: "POST",
        "uri": "/jsonunions",
        body: """
            {
                "contents": {
                    "structure_value": {
                        "hi": "hello"
                    }
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            contents: {
                structureValue: {
                    hi: "hello",
                }
            }
        }
    },
])

apply JsonUnions @httpResponseTests([
    {
        id: "RailsJsonDeserializeStringUnionValue",
        documentation: "Deserializes a string union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "string_value": "foo"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                stringValue: "foo"
            }
        }
    },
    {
        id: "RailsJsonDeserializeBooleanUnionValue",
        documentation: "Deserializes a boolean union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "boolean_value": true
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                booleanValue: true
            }
        }
    },
    {
        id: "RailsJsonDeserializeNumberUnionValue",
        documentation: "Deserializes a number union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "number_value": 1
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                numberValue: 1
            }
        }
    },
    {
        id: "RailsJsonDeserializeBlobUnionValue",
        documentation: "Deserializes a blob union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "blob_value": "Zm9v"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                blobValue: "foo"
            }
        }
    },
    {
        id: "RailsJsonDeserializeTimestampUnionValue",
        documentation: "Deserializes a timestamp union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "timestamp_value": "2014-04-29T18:30:38.000Z"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                timestampValue: 1398796238
            }
        }
    },
    {
        id: "RailsJsonDeserializeEnumUnionValue",
        documentation: "Deserializes an enum union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "enum_value": "Foo"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                enumValue: "Foo"
            }
        }
    },
    {
        id: "RailsJsonDeserializeListUnionValue",
        documentation: "Deserializes a list union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "list_value": ["foo", "bar"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                listValue: ["foo", "bar"]
            }
        }
    },
    {
        id: "RailsJsonDeserializeMapUnionValue",
        documentation: "Deserializes a map union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "map_value": {
                        "foo": "bar",
                        "spam": "eggs"
                    }
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                mapValue: {
                    foo: "bar",
                    spam: "eggs"
                }
            }
        }
    },
    {
        id: "RailsJsonDeserializeStructureUnionValue",
        documentation: "Deserializes a structure union value",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "contents": {
                    "structure_value": {
                        "hi": "hello"
                    }
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            contents: {
                structureValue: {
                    hi: "hello",
                }
            }
        }
    },
])