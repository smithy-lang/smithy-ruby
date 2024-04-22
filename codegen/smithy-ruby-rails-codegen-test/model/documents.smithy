// This file defines test cases that serialize document types.

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

// Define some shapes shared throughout these test cases.
document Document

/// This example serializes a document as part of the payload.
@idempotent
@http(uri: "/DocumentType", method: "PUT")
operation DocumentType {
    input: DocumentTypeInputOutput,
    output: DocumentTypeInputOutput
}

structure DocumentTypeInputOutput {
    stringValue: String,
    documentValue: Document,
}

apply DocumentType @httpRequestTests([
    {
        id: "RailsJsonDocumentTypeInputWithObject",
        documentation: "Serializes document types as part of the JSON request payload with no escaping.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentType",
        body: """
              {
                  "string_value": "string",
                  "document_value": {
                      "foo": "bar"
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: {
                foo: "bar"
            }
        }
    },
    {
        id: "RailsJsonDocumentInputWithString",
        documentation: "Serializes document types using a string.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentType",
        body: """
              {
                  "string_value": "string",
                  "document_value": "hello"
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: "hello"
        }
    },
    {
        id: "RailsJsonDocumentInputWithNumber",
        documentation: "Serializes document types using a number.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentType",
        body: """
              {
                  "string_value": "string",
                  "document_value": 10
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: 10
        }
    },
    {
        id: "RailsJsonDocumentInputWithBoolean",
        documentation: "Serializes document types using a boolean.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentType",
        body: """
              {
                  "string_value": "string",
                  "document_value": true
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: true
        }
    },
    {
        id: "RailsJsonDocumentInputWithList",
        documentation: "Serializes document types using a list.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentType",
        body: """
              {
                  "string_value": "string",
                  "document_value": [
                      true,
                      "hi",
                      [
                          1,
                          2
                      ],
                      {
                          "foo": {
                              "baz": [
                                  3,
                                  4
                              ]
                          }
                      }
                  ]
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: [
                true,
                "hi",
                [
                    1,
                    2
                ],
                {
                    "foo": {
                        "baz": [
                            3,
                            4
                        ]
                    }
                }
            ]
        }
    },
])

apply DocumentType @httpResponseTests([
    {
        id: "RailsJsonDocumentOutput",
        documentation: "Serializes documents as part of the JSON response payload with no escaping.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string_value": "string",
                "document_value": {
                    "foo": "bar"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: {
                foo: "bar"
            }
        }
    },
    {
        id: "RailsJsonDocumentOutputString",
        documentation: "Document types can be JSON scalars too.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string_value": "string",
                "document_value": "hello"
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: "hello"
        }
    },
    {
        id: "RailsJsonDocumentOutputNumber",
        documentation: "Document types can be JSON scalars too.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string_value": "string",
                "document_value": 10
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: 10
        }
    },
    {
        id: "RailsJsonDocumentOutputBoolean",
        documentation: "Document types can be JSON scalars too.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string_value": "string",
                "document_value": false
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: false
        }
    },
    {
        id: "RailsJsonDocumentOutputArray",
        documentation: "Document types can be JSON arrays.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "string_value": "string",
                "document_value": [
                    true,
                    false
                ]
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            stringValue: "string",
            documentValue: [true, false]
        }
    }
])

/// This example serializes a document as the entire HTTP payload.
@idempotent
@http(uri: "/DocumentTypeAsPayload", method: "PUT")
operation DocumentTypeAsPayload {
    input: DocumentTypeAsPayloadInputOutput,
    output: DocumentTypeAsPayloadInputOutput
}

structure DocumentTypeAsPayloadInputOutput {
    @httpPayload
    documentValue: Document,
}

apply DocumentTypeAsPayload @httpRequestTests([
    {
        id: "RailsJsonDocumentTypeAsPayloadInput",
        documentation: "Serializes a document as the target of the httpPayload trait.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentTypeAsPayload",
        body: """
              {
                  "foo": "bar"
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            documentValue: {
                foo: "bar"
            }
        }
    },
    {
        id: "RailsJsonDocumentTypeAsPayloadInputString",
        documentation: "Serializes a document as the target of the httpPayload trait using a string.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentTypeAsPayload",
        body: "\"hello\"",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            documentValue: "hello"
        }
    }
])

apply DocumentTypeAsPayload @httpResponseTests([
    {
        id: "RailsJsonDocumentTypeAsPayloadOutput",
        documentation: "Serializes a document as the target of the httpPayload trait.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "foo": "bar"
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            documentValue: {
                foo: "bar"
            }
        }
    },
    {
        id: "RailsJsonDocumentTypeAsPayloadOutputString",
        documentation: "Serializes a document as a payload string.",
        protocol: railsJson,
        code: 200,
        body: "\"hello\"",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            documentValue: "hello"
        }
    }
])

/// This example serializes documents as the value of maps.
@idempotent
@http(uri: "/DocumentTypeAsMapValue", method: "PUT")
operation DocumentTypeAsMapValue {
    input: DocumentTypeAsMapValueInputOutput,
    output: DocumentTypeAsMapValueInputOutput,
}

structure DocumentTypeAsMapValueInputOutput {
    docValuedMap: DocumentValuedMap,
}

map DocumentValuedMap {
    key: String,
    value: Document,
}

apply DocumentTypeAsMapValue @httpRequestTests([
    {
        id: "RailsJsonDocumentTypeAsMapValueInput",
        documentation: "Serializes a map that uses documents as the value.",
        protocol: railsJson,
        method: "PUT",
        uri: "/DocumentTypeAsMapValue",
        body: """
            {
                "doc_valued_map": {
                    "foo": { "f": 1, "o": 2 },
                    "bar": [ "b", "a", "r" ],
                    "baz": "BAZ"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            docValuedMap: {
                "foo": { "f": 1, "o": 2 },
                "bar": [ "b", "a", "r" ],
                "baz": "BAZ",
            },
        },
    },
])

apply DocumentTypeAsMapValue @httpResponseTests([
    {
        id: "RailsJsonDocumentTypeAsMapValueOutput",
        documentation: "Serializes a map that uses documents as the value.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "doc_valued_map": {
                    "foo": { "f": 1, "o": 2 },
                    "bar": [ "b", "a", "r" ],
                    "baz": "BAZ"
                }
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            docValuedMap: {
                "foo": { "f": 1, "o": 2 },
                "bar": [ "b", "a", "r" ],
                "baz": "BAZ",
            },
        },
    },
])
