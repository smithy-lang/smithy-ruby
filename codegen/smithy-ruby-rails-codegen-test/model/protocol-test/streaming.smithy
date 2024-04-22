// This file defines test cases that test HTTP streaming bindings.
// See: https://smithy.io/2.0/spec/streaming.html

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// This examples serializes a streaming blob shape in the request body.
///
/// In this example, no JSON document is synthesized because the payload is
/// not a structure or a union type.
@http(uri: "/streaming_traits", method: "POST")
operation StreamingTraits {
    input: StreamingTraitsInputOutput,
    output: StreamingTraitsInputOutput
}

apply StreamingTraits @httpRequestTests([
    {
        id: "RailsJsonStreamingTraitsWithBlob",
        documentation: "Serializes a blob in the HTTP payload",
        protocol: railsJson,
        method: "POST",
        uri: "/streaming_traits",
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "application/octet-stream"
        },
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    },
    {
        id: "RailsJsonStreamingTraitsWithNoBlobBody",
        documentation: "Serializes an empty blob in the HTTP payload",
        protocol: railsJson,
        method: "POST",
        uri: "/streaming_traits",
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

apply StreamingTraits @httpResponseTests([
    {
        id: "RailsJsonStreamingTraitsWithBlob",
        documentation: "Serializes a blob in the HTTP payload",
        protocol: railsJson,
        code: 200,
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "application/octet-stream"
        },
        params: {
            foo: "Foo",
            blob: "blobby blob blob"
        }
    },
    {
        id: "RailsJsonStreamingTraitsWithNoBlobBody",
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
    }
])

structure StreamingTraitsInputOutput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPayload
    blob: StreamingBlob = "",
}

@streaming
blob StreamingBlob

/// This examples serializes a streaming blob shape with a required content
/// length in the request body.
///
/// In this example, no JSON document is synthesized because the payload is
/// not a structure or a union type.
@http(uri: "/streaming_traits_require_length", method: "POST")
operation StreamingTraitsRequireLength {
    input: StreamingTraitsRequireLengthInput
}

apply StreamingTraitsRequireLength @httpRequestTests([
    {
        id: "RailsJsonStreamingTraitsRequireLengthWithBlob",
        documentation: "Serializes a blob in the HTTP payload with a required length",
        protocol: railsJson,
        method: "POST",
        uri: "/streaming_traits_require_length",
        body: "blobby blob blob",
        bodyMediaType: "application/octet-stream",
        headers: {
            "X-Foo": "Foo",
            "Content-Type": "application/octet-stream"
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
        id: "RailsJsonStreamingTraitsRequireLengthWithNoBlobBody",
        documentation: "Serializes an empty blob in the HTTP payload",
        protocol: railsJson,
        method: "POST",
        uri: "/streaming_traits_require_length",
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

@input
structure StreamingTraitsRequireLengthInput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPayload
    blob: FiniteStreamingBlob = "",
}

@streaming
@requiresLength
blob FiniteStreamingBlob

/// This examples serializes a streaming media-typed blob shape in the request body.
///
/// This examples uses a `@mediaType` trait on the payload to force a custom
/// content-type to be serialized.
@http(uri: "/streaming_traits_with_media_type", method: "POST")
operation StreamingTraitsWithMediaType {
    input: StreamingTraitsWithMediaTypeInputOutput,
    output: StreamingTraitsWithMediaTypeInputOutput
}

apply StreamingTraitsWithMediaType @httpRequestTests([
    {
        id: "RailsJsonStreamingTraitsWithMediaTypeWithBlob",
        documentation: "Serializes a blob in the HTTP payload with a content-type",
        protocol: railsJson,
        method: "POST",
        uri: "/streaming_traits_with_media_type",
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

apply StreamingTraitsWithMediaType @httpResponseTests([
    {
        id: "RailsJsonStreamingTraitsWithMediaTypeWithBlob",
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

structure StreamingTraitsWithMediaTypeInputOutput {
    @httpHeader("X-Foo")
    foo: String,

    @httpPayload
    blob: StreamingTextPlainBlob = ""
}

@streaming
@mediaType("text/plain")
blob StreamingTextPlainBlob
