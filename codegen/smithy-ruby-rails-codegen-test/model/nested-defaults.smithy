// defines test cases for nested defaults
// tests taken from: https://github.com/smithy-lang/smithy/blob/main/smithy-aws-protocol-tests/model/awsJson1_0/nestedDefaults.smithy
$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

apply OperationWithNestedStructure @httpRequestTests([
    {
        id: "RailsJsonClientPopulatesNestedDefaultValuesWhenMissing"
        documentation: "Client populates nested default values when missing."
        appliesTo: "client"
        tags: ["defaults"]
        protocol: railsJson
        method: "POST"
        bodyMediaType: "application/json"
        uri: "/OperationWithNestedStructure"
        headers: {"Content-Type": "application/json"}
        body: """
            {
                "top_level": {
                    "dialog": {
                        "language": "en",
                        "greeting": "hi"
                    },
                    "dialog_list": [
                        {
                            "greeting": "hi"
                        },
                        {
                            "greeting": "hi",
                            "farewell": {
                                "phrase": "bye"
                            }
                        },
                        {
                            "language": "it",
                            "greeting": "ciao",
                            "farewell": {
                                "phrase": "arrivederci"
                            }
                        }
                    ],
                    "dialog_map": {
                        "emptyDialog": {
                            "greeting": "hi"
                        },
                        "partialEmptyDialog": {
                            "language": "en",
                            "greeting": "hi",
                            "farewell": {
                                "phrase": "bye"
                            }
                        },
                        "nonEmptyDialog": {
                            "greeting": "konnichiwa",
                            "farewell": {
                                "phrase": "sayonara"
                            }
                        }
                    }
                }
            }"""
        params: {
            "topLevel": {
                "dialog": {
                    "language": "en"
                },
                "dialogList": [
                    {
                    },
                    {
                        "farewell": {}
                    },
                    {
                        "language": "it",
                        "greeting": "ciao",
                        "farewell": {
                            "phrase": "arrivederci"
                        }
                    }
                ],
                "dialogMap": {
                    "emptyDialog": {
                    },
                    "partialEmptyDialog": {
                        "language": "en",
                        "farewell": {}
                    },
                    "nonEmptyDialog": {
                        "greeting": "konnichiwa",
                        "farewell": {
                            "phrase": "sayonara"
                        }
                    }
                }
            }
        }
    }
])

apply OperationWithNestedStructure @httpResponseTests([
    {
        id: "RailsJsonClientPopulatesNestedDefaultsWhenMissingInResponseBody"
        documentation: "Client populates nested default values when missing in response body."
        appliesTo: "client"
        tags: ["defaults"]
        protocol: railsJson
        code: 200
        bodyMediaType: "application/json"
        headers: {"Content-Type": "application/json"}
        body: """
            {
                "dialog": {
                    "language": "en"
                },
                "dialog_list": [
                    {
                    },
                    {
                        "farewell": {}
                    },
                    {
                        "language": "it",
                        "greeting": "ciao",
                        "farewell": {
                            "phrase": "arrivederci"
                        }
                    }
                ],
                "dialog_map": {
                    "emptyDialog": {
                    },
                    "partialEmptyDialog": {
                        "language": "en",
                        "farewell": {}
                    },
                    "nonEmptyDialog": {
                        "greeting": "konnichiwa",
                        "farewell": {
                            "phrase": "sayonara"
                        }
                    }
                }
            }"""
        params: {
            "dialog": {
                "language": "en"
                "greeting": "hi",
            }
            "dialogList": [
                {
                    "greeting": "hi",
                },
                {
                    "greeting": "hi",
                    "farewell": {
                        "phrase": "bye",
                    }
                },
                {
                    "language": "it",
                    "greeting": "ciao",
                    "farewell": {
                        "phrase": "arrivederci"
                    }
                }
            ],
            "dialogMap": {
                "emptyDialog": {
                    "greeting": "hi",
                },
                "partialEmptyDialog": {
                    "language": "en",
                    "greeting": "hi",
                    "farewell": {
                        "phrase": "bye",
                    }
                },
                "nonEmptyDialog": {
                    "greeting": "konnichiwa",
                    "farewell": {
                        "phrase": "sayonara"
                    }
                }
            }
        }
    }
])

@http(uri: "/OperationWithNestedStructure", method: "POST")
operation OperationWithNestedStructure {
    input := {
        @required
        topLevel: TopLevel
    }

    output := with [NestedDefaultsMixin] {
    }
}

structure TopLevel with [NestedDefaultsMixin] {

}

@mixin
structure NestedDefaultsMixin {
    @required
    dialog: Dialog
    dialogList: DialogList = []
    dialogMap: DialogMap = {}
}

structure Dialog {
    language: String
    greeting: String = "hi"
    farewell: Farewell
}

structure Farewell {
    phrase: String = "bye"
}

list DialogList {
    member: Dialog
}

map DialogMap {
    key: String
    value: Dialog
}