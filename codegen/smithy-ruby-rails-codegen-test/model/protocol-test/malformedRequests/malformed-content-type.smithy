$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests
use aws.protocoltests.shared#GreetingStruct
use aws.protocoltests.shared#JpegBlob

apply MalformedContentTypeWithoutBody @httpMalformedRequestTests([
    {
        id: "RailsJsonWithoutBodyExpectsEmptyContentType",
        documentation: """
        When there is no modeled input, content type must not be set and the body must be empty.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedContentTypeWithoutBody",
            body: "{}",
            headers: {
                // this should be omitted
                "content-type": "application/json"
            }
        },
        response: {
            code: 415,
            headers: {
                "x-amzn-errortype": "UnsupportedMediaTypeException"
            }
        },
        tags: [ "content-type" ]
    }
])

apply MalformedContentTypeWithBody @httpMalformedRequestTests([
    {
        id: "RailsJsonWithBodyExpectsApplicationJsonContentType",
        documentation: """
        When there is modeled input, they content type must be application/json""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedContentTypeWithBody",
            body: "{}",
            headers: {
                // this should be application/json
                "content-type": "application/hal+json"
            }
        },
        response: {
            code: 415,
            headers: {
                "x-amzn-errortype": "UnsupportedMediaTypeException"
            }
        },
        tags: [ "content-type" ]
    }
])

apply MalformedContentTypeWithPayload @httpMalformedRequestTests([
    {
        id: "RailsJsonWithPayloadExpectsModeledContentType",
        documentation: """
        When there is a payload with a mediaType trait, the content type must match.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedContentTypeWithPayload",
            body: "{}",
            headers: {
                // this should be image/jpeg
                "content-type": "application/json"
            }
        },
        response: {
            code: 415,
            headers: {
                "x-amzn-errortype": "UnsupportedMediaTypeException"
            }
        },
        tags: [ "content-type" ]
    }
])

apply MalformedContentTypeWithPayload @httpMalformedRequestTests([
    {
        id: "RailsJsonWithPayloadExpectsImpliedContentType",
        documentation: """
        When there is a payload without a mediaType trait, the content type must match the
        implied content type of the shape.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedContentTypeWithPayload",
            body: "{}",
            headers: {
                // this should be text/plain
                "content-type": "application/json"
            }
        },
        response: {
            code: 415,
            headers: {
                "x-amzn-errortype": "UnsupportedMediaTypeException"
            }
        },
        tags: [ "content-type" ]
    }
])

apply MalformedContentTypeWithoutBodyEmptyInput @httpMalformedRequestTests([
    {
        id: "RailsJsonWithoutBodyEmptyInputExpectsEmptyContentType",
        documentation: """
        When there is no modeled body input, content type must not be set and the body must be empty.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedContentTypeWithoutBodyEmptyInput",
            body: "{}",
            headers: {
                // this should be omitted
                "content-type": "application/json"
            }
        },
        response: {
            code: 415,
            headers: {
                "x-amzn-errortype": "UnsupportedMediaTypeException"
            }
        },
        tags: [ "content-type" ]
    }
])

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedContentTypeWithoutBody")
operation MalformedContentTypeWithoutBody {}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedContentTypeWithBody")
operation MalformedContentTypeWithBody {
    input: GreetingStruct
}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedContentTypeWithPayload")
operation MalformedContentTypeWithPayload {
    input: MalformedContentTypeWithPayloadInput
}

structure MalformedContentTypeWithPayloadInput {
    @httpPayload
    payload: JpegBlob
}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedContentTypeWithGenericString")
operation MalformedContentTypeWithGenericString {
    input: MalformedContentTypeWithGenericStringInput
}

structure MalformedContentTypeWithGenericStringInput {
    @httpPayload
    payload: String
}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedContentTypeWithoutBodyEmptyInput")
operation MalformedContentTypeWithoutBodyEmptyInput {
    input: MalformedContentTypeWithoutBodyEmptyInputInput
}

structure MalformedContentTypeWithoutBodyEmptyInputInput {
    @httpHeader("header")
    header: String
}
