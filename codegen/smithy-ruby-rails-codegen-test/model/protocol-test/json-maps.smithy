// This file defines test cases that serialize maps in JSON payloads.

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#FooEnumMap
use aws.protocoltests.shared#GreetingStruct
use aws.protocoltests.shared#SparseStringMap
use aws.protocoltests.shared#StringSet
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// The example tests basic map serialization.
@http(uri: "/JsonMaps", method: "POST")
operation JsonMaps {
    input: JsonMapsInputOutput,
    output: JsonMapsInputOutput
}

apply JsonMaps @httpRequestTests([
    {
        id: "RailsJsonJsonMaps",
        documentation: "Serializes JSON maps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
              {
                  "denseStructMap": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseStructMap": {
                "foo": {
                    "hi": "there"
                },
                "baz": {
                    "hi": "bye"
                }
            }
        }
    },
    {
        id: "RailsJsonSerializesZeroValuesInMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "denseNumberMap": {
                    "x": 0
                },
                "denseBooleanMap": {
                    "x": false
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseNumberMap": {
                "x": 0
            },
            "denseBooleanMap": {
                "x": false
            },
        }
    },
    {
        id: "RailsJsonSerializesDenseSetMap",
        documentation: "A request that contains a dense map of sets.",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "denseSetMap": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseSetMap": {
                "x": [],
                "y": ["a", "b"]
            }
        }
    }
])

apply JsonMaps @httpResponseTests([
    {
        id: "RailsJsonJsonMaps",
        documentation: "Deserializes JSON maps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "denseStructMap": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseStructMap": {
                "foo": {
                    "hi": "there"
                },
                "baz": {
                    "hi": "bye"
                }
            }
        }
    },
    {
        id: "RailsJsonDeserializesZeroValuesInMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "denseNumberMap": {
                    "x": 0
                },
                "denseBooleanMap": {
                    "x": false
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseNumberMap": {
                "x": 0
            },
            "denseBooleanMap": {
                "x": false
            },
        }
    },
    {
        id: "RailsJsonDeserializesDenseSetMap",
        documentation: "A response that contains a dense map of sets.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "denseSetMap": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseSetMap": {
                "x": [],
                "y": ["a", "b"]
            }
        }
    },
    {
        id: "RailsJsonDeserializesDenseSetMapAndSkipsNull",
        documentation: """
            Clients SHOULD tolerate seeing a null value in a dense map, and they SHOULD
            drop the null key-value pair.""",
        protocol: railsJson,
        appliesTo: "client",
        code: 200,
        body: """
            {
                "denseSetMap": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "denseSetMap": {
                "x": [],
                "y": ["a", "b"]
            }
        }
    }
])

structure JsonMapsInputOutput {
    denseStructMap: DenseStructMap
    denseNumberMap: DenseNumberMap
    denseBooleanMap: DenseBooleanMap
    denseStringMap: DenseStringMap
    denseSetMap: DenseSetMap
}

map DenseStructMap {
    key: String,
    value: GreetingStruct
}

map DenseBooleanMap {
    key: String,
    value: Boolean
}

map DenseNumberMap {
    key: String,
    value: Integer
}

map DenseStringMap {
    key: String,
    value: String
}

map DenseSetMap {
    key: String,
    value: StringSet
}

/// This example tests sparse map serialization.
@http(uri: "/SparseJsonMaps", method: "POST")
operation SparseJsonMaps {
    input: SparseJsonMapsInputOutput
    output: SparseJsonMapsInputOutput
}

apply SparseJsonMaps @httpRequestTests([
    {
        id: "RailsJsonSparseJsonMaps",
        documentation: "Serializes JSON maps",
        protocol: railsJson,
        method: "POST",
        uri: "/SparseJsonMaps",
        body: """
              {
                  "sparseStructMap": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseStructMap": {
                "foo": {
                    "hi": "there"
                },
                "baz": {
                    "hi": "bye"
                }
            }
        }
    },
    {
        id: "RailsJsonSerializesSparseNullMapValues",
        documentation: "Serializes JSON map values in sparse maps",
        protocol: railsJson,
        method: "POST",
        uri: "/SparseJsonMaps",
        body: """
            {
                "sparseBooleanMap": {
                    "x": null
                },
                "sparseNumberMap": {
                    "x": null
                },
                "sparseStringMap": {
                    "x": null
                },
                "sparseStructMap": {
                    "x": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseBooleanMap": {
                "x": null
            },
            "sparseNumberMap": {
                "x": null
            },
            "sparseStringMap": {
                "x": null
            },
            "sparseStructMap": {
                "x": null
            }
        }
    },
    {
        id: "RailsJsonSerializesZeroValuesInSparseMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        method: "POST",
        uri: "/SparseJsonMaps",
        body: """
            {
                "sparseNumberMap": {
                    "x": 0
                },
                "sparseBooleanMap": {
                    "x": false
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseNumberMap": {
                "x": 0
            },
            "sparseBooleanMap": {
                "x": false
            }
        }
    },
    {
        id: "RailsJsonSerializesSparseSetMap",
        documentation: "A request that contains a sparse map of sets",
        protocol: railsJson,
        method: "POST",
        uri: "/SparseJsonMaps",
        body: """
            {
                "sparseSetMap": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseSetMap": {
                "x": [],
                "y": ["a", "b"]
            }
        }
    },
    {
        id: "RailsJsonSerializesSparseSetMapAndRetainsNull",
        documentation: "A request that contains a sparse map of sets.",
        protocol: railsJson,
        method: "POST",
        uri: "/SparseJsonMaps",
        body: """
            {
                "sparseSetMap": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseSetMap": {
                "x": [],
                "y": ["a", "b"],
                "z": null
            }
        }
    }
])

apply SparseJsonMaps @httpResponseTests([
    {
        id: "RailsJsonSparseJsonMaps",
        documentation: "Deserializes JSON maps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "sparseStructMap": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                 }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseStructMap": {
                "foo": {
                    "hi": "there"
                },
                "baz": {
                    "hi": "bye"
                }
            }
        }
    },
    {
        id: "RailsJsonDeserializesSparseNullMapValues",
        documentation: "Deserializes null JSON map values",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparseBooleanMap": {
                    "x": null
                },
                "sparseNumberMap": {
                    "x": null
                },
                "sparseStringMap": {
                    "x": null
                },
                "sparseStructMap": {
                    "x": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseBooleanMap": {
                "x": null
            },
            "sparseNumberMap": {
                "x": null
            },
            "sparseStringMap": {
                "x": null
            },
            "sparseStructMap": {
                "x": null
            }
        }
    },
    {
        id: "RailsJsonDeserializesZeroValuesInSparseMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparseNumberMap": {
                    "x": 0
                },
                "sparseBooleanMap": {
                    "x": false
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseNumberMap": {
                "x": 0
            },
            "sparseBooleanMap": {
                "x": false
            }
        }
    },
    {
        id: "RailsJsonDeserializesSparseSetMap",
        documentation: "A response that contains a sparse map of sets",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparseSetMap": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseSetMap": {
                "x": [],
                "y": ["a", "b"]
            }
        }
    },
    {
        id: "RailsJsonDeserializesSparseSetMapAndRetainsNull",
        documentation: "A response that contains a sparse map of sets.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparseSetMap": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            "sparseSetMap": {
                "x": [],
                "y": ["a", "b"],
                "z": null
            }
        }
    }
])

structure SparseJsonMapsInputOutput {
    sparseStructMap: SparseStructMap
    sparseNumberMap: SparseNumberMap
    sparseBooleanMap: SparseBooleanMap
    sparseStringMap: SparseStringMap
    sparseSetMap: SparseSetMap
}

@sparse
map SparseStructMap {
    key: String,
    value: GreetingStruct
}

@sparse
map SparseBooleanMap {
    key: String,
    value: Boolean
}

@sparse
map SparseNumberMap {
    key: String,
    value: Integer
}

@sparse
map SparseSetMap {
    key: String,
    value: StringSet
}
