$version: "2.0"
namespace smithy.ruby.tests

use smithy.ruby.tests.protocols#testProtocol
use smithy.rules#clientContextParams
use smithy.rules#endpointRuleSet
use smithy.rules#endpointTests

@suppress(["UnstableTrait", "DeprecatedShape", "RuleSetAuthSchemes"])
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
        "ResourceUrl": {
            "required": false,
            "documentation": "URL for a customer owned resource.",
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
            "type": "error",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Endpoint"}]}, {"fn": "isSet", "argv": [{"ref": "ResourceUrl"}]}  ],
            "error": "Unable to set both Endpoint and ResourceUrl: \"{ResourceUrl}\"",
        },
        {
            "type": "endpoint",
            "conditions": [ {"fn": "isSet", "argv": [{"ref": "Endpoint"}]} ],
            "endpoint": { "url": {"ref": "Endpoint"} },
        },
        {
            "type": "endpoint",
            "documentation": "Use a user provided resource",
            "conditions": [
                {
                    "fn": "isSet",
                    "argv": [
                        {
                            "ref": "ResourceUrl"
                        }
                    ]
                },
                {
                    "fn": "parseURL",
                    "argv": [
                        "{ResourceUrl}"
                    ],
                    "assign": "parsedUrl"
                },
                {
                    "fn": "getAttr",
                    "argv": [
                        {
                            "ref": "parsedUrl"
                        },
                        "path"
                    ],
                    "assign": "path"
                }
            ],
            "endpoint": {
                "url": "https://{parsedUrl#authority}{path}",
                "headers": {
                    "x-resource-type": [
                        "custom"
                    ]
                },
                "properties": {
                    "authSchemes": [
                        {
                            "name": "bearer",
                        }
                    ]
                },
            },
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
            "conditions": [],
            "endpoint": { "url": "https://whitelabel.com" },
        },
    ],
})
@endpointTests(
version: "1.0",
testCases: [
    {
        "documentation": "Endpoint override is used",
        "params": {
            "Endpoint": "https://custom-endpoint.com"
        },
        "expect": {
            "endpoint": {
                "url": "https://custom-endpoint.com",
            }
        },
        "operationInputs": [
            {
                "operationName": "EndpointOperation",
                "operationParams": {
                },
                "builtInParams": {
                    "SDK::Endpoint": "https://custom-endpoint.com"
                }
            }
        ]
    },
    {
        "documentation": "Endpoint override is used when other parameters are set",
        "params": {
            "Endpoint": "https://custom-endpoint.com",
            "Stage": "prod",
            "Dataplane": true,
        },
        "expect": {
            "endpoint": {
                "url": "https://custom-endpoint.com"
            }
        },
    },
    {
        "documentation": "Errors when both Endpoint and ResourceURL are set",
        "params": {
            "Endpoint": "https://custom-endpoint.com",
            "ResourceUrl": "https://resource"
        },
        "expect": {
            "error": "Unable to set both Endpoint and ResourceUrl: \"https://resource\""
        },
    },
    {
        "documentation": "Stage is used",
        "params": {
            "Stage": "beta",
        },
        "expect": {
            "endpoint": {
                "url": "https://beta.whitelabel.dev"
            }
        },
        "operationInputs": [
            {
                "operationName": "EndpointOperation",
                "operationParams": {
                },
                "builtInParams": {

                },
                "clientParams": {
                    "Stage": "beta"
                }
            }
        ]
    },
    {
        "documentation": "ResourceURL is parsed and used",
        "params": {
            "ResourceUrl": "https://resource.com/path"
        },
        "expect": {
            "endpoint": {
                "url": "https://resource.com/path",
                "headers": {
                    "x-resource-type": ["custom"]
                },
                "properties": {
                    "authSchemes": [
                        {
                            "name": "bearer",
                        }
                    ]
                }
            },
        },
        "operationInputs": [
            {
                "operationName": "ResourceEndpoint",
                "operationParams": {
                    "resourceUrl": "https://resource.com/path"
                },
                "builtInParams": {
                },
                "clientParams": {
                }
            }
        ]
    },
    {
        "documentation": "Data prefix is applied",
        "params": {
            "Dataplane": true
        },
        "expect": {
            "endpoint": {
                "url": "https://data.whitelabel.com"
            },
        },
        "operationInputs": [
            {
                "operationName": "DataplaneEndpoint",
                "operationParams": {
                },
                "builtInParams": {
                },
                "clientParams": {
                }
            },
            {
                "operationName": "EndpointWithHostLabelOperation",
                "operationParams": {
                    "labelMember": "label"
                },
                "builtInParams": {
                },
                "clientParams": {
                }
            }
        ]
    },
])
@clientContextParams(
    Stage: {
        type: "string"
        documentation: "Specify the stage (beta|gamma|prod)"
    }
)
@testProtocol
@title("TestProtocol Test Service")
service WhiteLabel {
    version: "2018-01-01",
    operations: [
        KitchenSink,
        PaginatorsTest,
        PaginatorsTestWithItems,
        __PaginatorsTestWithBadNames,
        WaitersTest,
        DefaultsTest,
        Streaming,
        StreamingWithLength,
        EndpointOperation,
        EndpointWithHostLabelOperation,
        DataplaneEndpoint,
        ResourceEndpoint,
        MixinTest,
        RelativeMiddleware,
        RequestCompression,
        RequestCompressionStreaming,
        HttpBasicAuth,
        HttpDigestAuth,
        HttpBearerAuth,
        HttpApiKeyAuth,
        OptionalAuth,
        NoAuth,
        OrderedAuth,
        CustomAuth,
        TelemetryTest,
        StartEventStream
    ]
}

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
    @suppress(["DeprecatedShape"])
    ValuedEnum: ValuedEnum,

    // complex member
    @suppress(["DeprecatedShape"])
    Struct: Struct,

    // document member
    Document: Document,

    // collections (simple + complex)
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,

    // union member
    @suppress(["DeprecatedShape"])
    Union: Union,
}

enum SimpleEnum {
    YES
    NO
}

enum ValuedEnum {
    @enumValue("yes")
    YES

    @enumValue("no")
    NO
}

structure Struct {
    value: String,
}

list ListOfStrings {
    member: String,
}

list ListOfStructs {
    @suppress(["DeprecatedShape"])
    member: Struct,
}

map MapOfStrings {
    key: String,
    value: String,
}

map MapOfStructs {
    key: String,
    @suppress(["DeprecatedShape"])
    value: Struct,
}

union Union {
    String: String,
    @suppress(["DeprecatedShape"])
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

