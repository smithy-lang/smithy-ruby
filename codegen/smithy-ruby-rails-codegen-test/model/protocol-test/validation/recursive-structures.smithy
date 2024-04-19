$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson.validation

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests
use smithy.test#httpRequestTests
use smithy.framework#ValidationException

@suppress(["UnstableTrait"])
@http(uri: "/RecursiveStructures", method: "POST")
operation RecursiveStructures {
    input: RecursiveStructuresInput,
    errors: [ValidationException]
}

apply RecursiveStructures @httpRequestTests([
    {
        id: "RailsJsonRecursiveStructuresValidate",
        documentation: """
        Validation should work with recursive structures.""",
        protocol: railsJson,
        params: {
            "union" : {
                "union" : {
                    "union" : { "string" : "abc" }
                }
            }
        },
        method: "POST",
        uri: "/RecursiveStructures",
        headers: {
            "content-type": "application/json"
        },
        body: """
        { "union" : {
            "union" : {
                "union" : { "string" : "abc" }
            }
          }
        }""",
        bodyMediaType: "application/json"
    }
])

apply RecursiveStructures @httpMalformedRequestTests([
    {
        id: "RailsJsonMalformedRecursiveStructures",
        documentation: """
        When a value deeply nested in a recursive structure does not meet constraints,
        a 400 ValidationException is returned.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/RecursiveStructures",
            body: """
            { "union" : {
                "union" : {
                    "union" : { "string" : "XYZ" }
                 }
              }
            }""",
            headers: {
                "content-type": "application/json"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "ValidationException"
            },
            body: {
                mediaType: "application/json",
                assertion: {
                    contents: """
                    { "message" : "1 validation error detected. Value at '/union/union/union/string' failed to satisfy constraint: Member must satisfy enum value set: [abc, def]",
                      "fieldList" : [{"message": "Value at '/union/union/union/string' failed to satisfy constraint: Member must satisfy enum value set: [abc, def]", "path": "/union/union/union/string"}]}"""
                }
            }
        }
    },
])

structure RecursiveStructuresInput {
    union: RecursiveUnionOne
}

enum RecursiveEnumString {
    ABC = "abc"
    DEF = "def"
}

union RecursiveUnionOne {
    string: RecursiveEnumString,
    union: RecursiveUnionTwo
}

union RecursiveUnionTwo {
    string: RecursiveEnumString,
    union: RecursiveUnionOne
}
