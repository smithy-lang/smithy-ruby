$version: "2.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#fakeProtocol
use smithy.rules#clientContextParams
use smithy.rules#endpointRuleSet

@endpointRuleSet({
    "version": "1.0",
    "parameters": {
        "Stage": {
            "required": false,
            "documentation": "Specify the stage (beta|gamma|prod)",
            "type": "String",
        }
        "Dataplane": {
            "required": false,
            "documentation": "Is this a dataplane operation",
            type: "Boolean"
        }
        "ContextPath": {
            "required": false,
            "documentation": "Additional Path to add from context (operation input).",
            "type": "String",
        }
        "Endpoint": {
            "builtIn": "SDK::Endpoint",
            "required": false,
            "documentation": "Override the endpoint used to send requests",
            "type": "String",
        }
    },
    "rules": [
        // Rule to allow using endpoint overrides
        {
            "type": "endpoint",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Endpoint"}]} ],
            "endpoint": { "url": {"ref": "Endpoint"} },
        },
        // Rule to for Stage
        {
            "type": "endpoint",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Stage"}]}, {"fn": "stringEquals", "argv": [{"ref": "Stage"}, "alpha"]} ],
            "endpoint": { "url": "https://alpha.whitelabel.dev" },
        },
        // Rule to for Stage = beta
        {
            "type": "endpoint",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Stage"}]}, {"fn": "stringEquals", "argv": [{"ref": "Stage"}, "beta"]} ],
            "endpoint": { "url": "https://beta.whitelabel.dev" },
        },
        // Rule to for Stage = gamma
        {
            "type": "endpoint",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Stage"}]}, {"fn": "stringEquals", "argv": [{"ref": "Stage"}, "gamma"]} ],
            "endpoint": { "url": "https://gamma.whitelabel.dev" },
        },
        // prod endpoints
        {
            "type": "endpoint",
            "conditions": [{"fn": "isSet", "argv": [{"ref": "Dataplane"}]}],
            "endpoint": { "url": "https://data.whitelabel.com" },
        },
        {
            "type": "endpoint",
            "conditions": [{"fn": "isSet", "argv": [{"ref": "ContextPath"}]}],
            "endpoint": { "url": "https://whitelabel.com/{ContextPath}" },
        },
        {
            "type": "endpoint",
            "conditions": [],
            "endpoint": { "url": "https://whitelabel.com" },
        },
    ],
})
@clientContextParams(
    Stage: {
        type: "string"
        documentation: "Specify the stage (beta|gamma|prod)"
    }
)
@fakeProtocol
@title("FakeProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSink,
        PaginatorsTest,
        PaginatorsTestWithItems,
        __PaginatorsTestWithBadNames,
        WaitersTest,
        DefaultsTest,
        StreamingOperation,
        StreamingWithLength,
        EndpointOperation,
        EndpointWithHostLabelOperation,
        DataplaneOperation,
        EndpointOperationWithPath,
        MixinTest,
        RelativeMiddlewareOperation,
        RequestCompressionOperation,
        RequestCompressionStreamingOperation,
        HttpBasicAuth,
        HttpDigestAuth,
        HttpBearerAuth,
        HttpApiKeyAuth,
        OptionalAuth,
        NoAuth,
        OrderedAuth,
        CustomAuth
    ]
}

@http(method: "POST", uri: "/kitchen_sink")
operation KitchenSink {
    input: KitchenSinkInputOutput,
    output: KitchenSinkInputOutput,
    errors: [ClientError, ServerError],
}

structure KitchenSinkInputOutput {
    // simple member
    String: String,

    // enum members
    SimpleEnum: SimpleEnum,
    TypedEnum: TypedEnum,

    // complex member
    Struct: Struct,

    // document member
    Document: Document,

    // collections (simple + complex)
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,

    // union member
    Union: Union,
}

@suppress(["EnumNamesPresent"])
@enum([{value: "YES"}, {value: "NO"}])
string SimpleEnum

@enum([{value: "YES", name: "YES"}, {value: "NO", name: "NO"}])
string TypedEnum

structure Struct {
    value: String,
}

list ListOfStrings {
    member: String,
}

list ListOfStructs {
    member: Struct,
}

map MapOfStrings {
    key: String,
    value: String,
}

map MapOfStructs {
    key: String,
    value: Struct,
}

union Union {
    String: String,
    Struct: Struct,
}


@error("client")
@retryable
structure ClientError {
  Message: String
}

@error("server")
@retryable(throttling: true)
structure ServerError {}
