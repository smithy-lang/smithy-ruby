// This file defines test cases that serialize maps in JSON payloads.

$version: "1.0"

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
                  "dense_struct_map": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                  },
                  "sparse_struct_map": {
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
            },
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
        id: "RailsJsonSerializesNullMapValues",
        documentation: "Serializes JSON map values in sparse maps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "sparse_boolean_map": {
                    "x": null
                },
                "sparse_number_map": {
                    "x": null
                },
                "sparse_string_map": {
                    "x": null
                },
                "sparse_struct_map": {
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
        id: "RailsJsonSerializesZeroValuesInMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "dense_number_map": {
                    "x": 0
                },
                "sparse_number_map": {
                    "x": 0
                },
                "dense_boolean_map": {
                    "x": false
                },
                "sparse_boolean_map": {
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
            "sparseNumberMap": {
                "x": 0
            },
            "denseBooleanMap": {
                "x": false
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
        uri: "/JsonMaps",
        body: """
            {
                "sparse_set_map": {
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
        id: "RailsJsonSerializesDenseSetMap",
        documentation: "A request that contains a dense map of sets.",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "dense_set_map": {
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
        id: "RailsJsonSerializesSparseSetMapAndRetainsNull",
        documentation: "A request that contains a sparse map of sets.",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonMaps",
        body: """
            {
                "sparse_set_map": {
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

apply JsonMaps @httpResponseTests([
    {
        id: "RailsJsonJsonMaps",
        documentation: "Deserializes JSON maps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "dense_struct_map": {
                      "foo": {
                          "hi": "there"
                      },
                      "baz": {
                          "hi": "bye"
                      }
                  },
                  "sparse_struct_map": {
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
            },
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
        id: "RailsJsonDeserializesNullMapValues",
        documentation: "Deserializes null JSON map values",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparse_boolean_map": {
                    "x": null
                },
                "sparse_number_map": {
                    "x": null
                },
                "sparse_string_map": {
                    "x": null
                },
                "sparse_struct_map": {
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
        id: "RailsJsonDeserializesZeroValuesInMaps",
        documentation: "Ensure that 0 and false are sent over the wire in all maps and lists",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "dense_number_map": {
                    "x": 0
                },
                "sparse_number_map": {
                    "x": 0
                },
                "dense_boolean_map": {
                    "x": false
                },
                "sparse_boolean_map": {
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
            "sparseNumberMap": {
                "x": 0
            },
            "denseBooleanMap": {
                "x": false
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
                "sparse_set_map": {
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
        id: "RailsJsonDeserializesDenseSetMap",
        documentation: "A response that contains a dense map of sets.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "dense_set_map": {
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
        id: "RailsJsonDeserializesSparseSetMapAndRetainsNull",
        documentation: "A response that contains a sparse map of sets.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "sparse_set_map": {
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
                "dense_set_map": {
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
    denseStructMap: DenseStructMap,
    sparseStructMap: SparseStructMap,
    denseNumberMap: DenseNumberMap,
    denseBooleanMap: DenseBooleanMap,
    denseStringMap: DenseStringMap,
    sparseNumberMap: SparseNumberMap,
    sparseBooleanMap: SparseBooleanMap,
    sparseStringMap: SparseStringMap,
    denseSetMap: DenseSetMap,
    sparseSetMap: SparseSetMap,
}

map DenseStructMap {
    key: String,
    value: GreetingStruct
}

@sparse
map SparseStructMap {
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

map DenseSetMap {
    key: String,
    value: StringSet
}

@sparse
map SparseSetMap {
    key: String,
    value: StringSet
}