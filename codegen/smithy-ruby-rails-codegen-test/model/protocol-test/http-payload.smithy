// This file defines test cases that test HTTP payload bindings.
// See: https://smithy.io/2.0/spec/http-bindings.html#httppayload-trait

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#TextPlainBlob
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This example serializes a blob shape in the payload.
///
/// In this example, no JSON document is synthesized because the payload is
/// not a structure or a union type.
@http(uri: "/http_payload_traits", method: "POST")
operation HttpPayloadTraits {
    input: HttpPayloadTraitsInputOutput,
    output: HttpPayloadTraitsInputOutput
}

apply HttpPayloadTraits @httpRequestTests([
    {
        id: "RailsJsonHttpPayloadTraitsWithBlob",
        documentation: "Serializes a blob in the HTTP payload",
        protocol: railsJson,
        method: "POST",
        uri: "/http_payload_traits",
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "Content-Type": "application/octet-stream",
            "X-Foo": "Foo"
        },
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    },
    {
        id: "RailsJsonHttpPayloadTraitsWithNoBlobBody",
        documentation: "Serializes an empty blob in the HTTP payload",
        protocol: railsJson,
        method: "POST",
        uri: "/http_payload_traits",
        body: "",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo"
        },
        params: {
            foo: "Foo"
        }
    },
    {
        id: "RailsJsonHttpPayloadTraitsWithBlobAcceptsAllContentTypes",
        documentation: """
            Servers must accept any content type for blob inputs
            without the media type trait.""",
        protocol: railsJson,
        method: "POST",
        uri: "/http_payload_traits",
        body: "This is definitely a jpeg",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "image/jpeg"
        },
        params: {
            foo: "Foo",
            blob: "This is definitely a jpeg"
        },
        appliesTo: "server",
    },
    {
        id: "RailsJsonHttpPayloadTraitsWithBlobAcceptsAllAccepts",
        documentation: """
            Servers must accept any accept header for blob inputs
            without the media type trait.""",
        protocol: railsJson,
        method: "POST",
        uri: "/http_payload_traits",
        body: "This is definitely a jpeg",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Accept": "image/jpeg"
        },
        params: {
            foo: "Foo",
            blob: "This is definitely a jpeg"
        },
        appliesTo: "server",
    },
])

apply HttpPayloadTraits @httpResponseTests([
    {
        id: "RailsJsonHttpPayloadTraitsWithBlob",
        documentation: "Serializes a blob in the HTTP payload",
        protocol: railsJson,
        code: 200,
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo"
        },
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    },
    {
        id: "RailsJsonHttpPayloadTraitsWithNoBlobBody",
        documentation: "Serializes an empty blob in the HTTP payload",
        protocol: railsJson,
        code: 200,
        body: "",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo"
        },
        params: {
            foo: "Foo"
        }
    },
])

structure HttpPayloadTraitsInputOutput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPayload
    blob: Blob,
}

/// This example uses a `@mediaType` trait on the payload to force a custom
/// content-type to be serialized.
@http(uri: "/http_payload_traits_with_media_type", method: "POST")
operation HttpPayloadTraitsWithMediaType {
    input: HttpPayloadTraitsWithMediaTypeInputOutput,
    output: HttpPayloadTraitsWithMediaTypeInputOutput
}

apply HttpPayloadTraitsWithMediaType @httpRequestTests([
    {
        id: "RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob",
        documentation: "Serializes a blob in the HTTP payload with a content-type",
        protocol: railsJson,
        method: "POST",
        uri: "/http_payload_traits_with_media_type",
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "text/plain"
        },
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    }
])

apply HttpPayloadTraitsWithMediaType @httpResponseTests([
    {
        id: "RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob",
        documentation: "Serializes a blob in the HTTP payload with a content-type",
        protocol: railsJson,
        code: 200,
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "text/plain"
        },
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    }
])

structure HttpPayloadTraitsWithMediaTypeInputOutput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPayload
    blob: TextPlainBlob,
}

/// This example serializes a structure in the payload.
///
/// Note that serializing a structure changes the wrapper element name
/// to match the targeted structure.
@idempotent
@http(uri: "/http_payload_with_structure", method: "PUT")
operation HttpPayloadWithStructure {
    input: HttpPayloadWithStructureInputOutput,
    output: HttpPayloadWithStructureInputOutput
}

apply HttpPayloadWithStructure @httpRequestTests([
    {
        id: "RailsJsonHttpPayloadWithStructure",
        documentation: "Serializes a structure in the payload",
        protocol: railsJson,
        method: "PUT",
        uri: "/http_payload_with_structure",
        body: """
              {
                  "greeting": "hello",
                  "name": "Phreddy"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            nested: {
                greeting: "hello",
                name: "Phreddy"
            }
        }
    }
])

apply HttpPayloadWithStructure @httpResponseTests([
    {
        id: "RailsJsonHttpPayloadWithStructure",
        documentation: "Serializes a structure in the payload",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "greeting": "hello",
                  "name": "Phreddy"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            nested: {
                greeting: "hello",
                name: "Phreddy"
            }
        }
    }
])

structure HttpPayloadWithStructureInputOutput {
    @httpPayload
    nested: NestedPayload,
}

structure NestedPayload {
    greeting: String,
    name: String,
}

/// This example serializes a union in the payload.
@idempotent
@http(uri: "/http_payload_with_union", method: "PUT")
operation HttpPayloadWithUnion {
    input: HttpPayloadWithUnionInputOutput,
    output: HttpPayloadWithUnionInputOutput
}

apply HttpPayloadWithUnion @httpRequestTests([
    {
        id: "RailsJsonHttpPayloadWithUnion",
        documentation: "Serializes a union in the payload.",
        protocol: railsJson,
        method: "PUT",
        uri: "/http_payload_with_union",
        body: """
              {
                  "greeting": "hello"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            nested: {
                greeting: "hello"
            }
        }
    },
    {
        id: "RailsJsonHttpPayloadWithUnsetUnion",
        documentation: "No payload is sent if the union has no value.",
        protocol: railsJson,
        method: "PUT",
        uri: "/http_payload_with_union",
        body: "",
        params: {}
    }
])

apply HttpPayloadWithUnion @httpResponseTests([
    {
        id: "RailsJsonHttpPayloadWithUnion",
        documentation: "Serializes a union in the payload.",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "greeting": "hello"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            nested: {
                greeting: "hello"
            }
        }
    },
    {
        id: "RailsJsonHttpPayloadWithUnsetUnion",
        documentation: "No payload is sent if the union has no value.",
        protocol: railsJson,
        code: 200,
        body: "",
        headers: {
            "Content-Length": "0"
        },
        params: {}
    }
])

structure HttpPayloadWithUnionInputOutput {
    @httpPayload
    nested: UnionPayload,
}

union UnionPayload {
    greeting: String
}
