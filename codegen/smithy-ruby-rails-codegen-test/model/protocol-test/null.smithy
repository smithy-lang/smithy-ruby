$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#SparseStringList
use aws.protocoltests.shared#SparseStringMap
use aws.protocoltests.shared#StringMap
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@httpRequestTests([
    {
        id: "RailsJsonStructuresDontSerializeNullValues",
        documentation: "Null structure values are dropped",
        protocol: railsJson,
        body: "{}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            string: null
        },
        method: "POST",
        uri: "/nulloperation"
,
        appliesTo: "client",
    },
    {
        id: "RailsJsonMapsSerializeNullValues",
        documentation: "Serializes null values in maps",
        protocol: railsJson,
        body: """
            {
                "sparse_string_map": {
                    "foo": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            "sparseStringMap": {
                "foo": null
            }
        },
        method: "POST",
        uri: "/nulloperation"
,
    },
    {
        id: "RailsJsonListsSerializeNull",
        documentation: "Serializes null values in lists",
        protocol: railsJson,
        body: """
            {
                "sparse_string_list": [
                    null
                ]
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            "sparseStringList": [
                null
            ]
        },
        method: "POST",
        uri: "/nulloperation"
,
    }
])
@httpResponseTests([
    {
        id: "RailsJsonStructuresDontDeserializeNullValues",
        documentation: "Null structure values are dropped",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string": null
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {},
        appliesTo: "client",
    },
    {
        id: "RailsJsonMapsDeserializeNullValues",
        documentation: "Deserializes null values in maps",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparse_string_map": {
                    "foo": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            "sparseStringMap": {
                "foo": null
            }
        },
    },
    {
        id: "RailsJsonListsDeserializeNull",
        documentation: "Deserializes null values in lists",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparse_string_list": [
                    null
                ]
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            "sparseStringList": [
                null
            ]
        },
    }
])
@http(method: "POST", uri: "/nulloperation")
operation NullOperation {
    input: NullOperationInputOutput,
    output: NullOperationInputOutput,
}
structure NullOperationInputOutput {
    string: String,
    sparseStringList: SparseStringList,
    sparseStringMap: SparseStringMap,
}