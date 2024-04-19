$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpMalformedRequestTests
use aws.protocoltests.shared#GreetingStruct
use aws.protocoltests.shared#JpegBlob

apply MalformedAcceptWithBody @httpMalformedRequestTests([
    {
        id: "RailsJsonWithBodyExpectsApplicationJsonAccept",
        documentation: """
        When there is modeled output, the accept must be application/json""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedAcceptWithBody",
            headers: {
                // this should be application/json
                "accept": "application/hal+json"
            }
        },
        response: {
            code: 406,
            headers: {
                "x-amzn-errortype": "NotAcceptableException"
            }
        },
        tags: [ "accept" ]
    }
])

apply MalformedAcceptWithPayload @httpMalformedRequestTests([
    {
        id: "RailsJsonWithPayloadExpectsModeledAccept",
        documentation: """
        When there is a payload with a mediaType trait, the accept must match.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedAcceptWithPayload",
            headers: {
                // this should be image/jpeg
                "accept": "application/json"
            }
        },
        response: {
            code: 406,
            headers: {
                "x-amzn-errortype": "NotAcceptableException"
            }
        },
        tags: [ "accept" ]
    }
])

apply MalformedAcceptWithGenericString @httpMalformedRequestTests([
    {
        id: "RailsJsonWithPayloadExpectsImpliedAccept",
        documentation: """
        When there is a payload without a mediaType trait, the accept must match the
        implied content type of the shape.""",
        protocol: railsJson,
        request: {
            method: "POST",
            uri: "/MalformedAcceptWithGenericString",
            headers: {
                // this should be text/plain
                "accept": "application/json"
            }
        },
        response: {
            code: 406,
            headers: {
                "x-amzn-errortype": "NotAcceptableException"
            }
        },
        tags: [ "accept" ]
    }
])

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedAcceptWithBody")
operation MalformedAcceptWithBody {
    output: GreetingStruct
}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedAcceptWithPayload")
operation MalformedAcceptWithPayload {
    output: MalformedAcceptWithPayloadOutput
}

structure MalformedAcceptWithPayloadOutput {
    @httpPayload
    payload: JpegBlob
}

@suppress(["UnstableTrait"])
@http(method: "POST", uri: "/MalformedAcceptWithGenericString")
operation MalformedAcceptWithGenericString {
    output: MalformedAcceptWithGenericStringOutput
}

structure MalformedAcceptWithGenericStringOutput {
    @httpPayload
    payload: String
}
