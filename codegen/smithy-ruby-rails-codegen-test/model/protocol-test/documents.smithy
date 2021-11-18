// This file defines test cases that serialize inline documents.

$version: "1.0"

namespace protocoltests.RailsJson

use smithy.rails#RailsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This example serializes an inline document as part of the payload.
@http(method: "POST", uri: "/putandgetinlinedocuments")
operation PutAndGetInlineDocuments {
    input: PutAndGetInlineDocumentsInputOutput,
    output: PutAndGetInlineDocumentsInputOutput
}

structure PutAndGetInlineDocumentsInputOutput {
    inlineDocument: Document
}

document Document

apply PutAndGetInlineDocuments @httpRequestTests([
    {
        id: "RailsJsonPutAndGetInlineDocumentsInput",
        documentation: "Serializes inline documents in a JSON request.",
        protocol: RailsJson,
        method: "POST",
        uri: "/putandgetinlinedocuments",
        body: """
              {
                  "inline_document": {"foo": "bar"}
              }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            inlineDocument: {
                foo: "bar"
            }
        }
    }
])

apply PutAndGetInlineDocuments @httpResponseTests([
    {
        id: "RailsJsonPutAndGetInlineDocumentsInput",
        documentation: "Serializes inline documents in a JSON response.",
        protocol: RailsJson,
        code: 200,
        body: """
            {
                "inline_document": {"foo": "bar"}
            }""",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            inlineDocument: {
                foo: "bar"
            }
        }
    }
])