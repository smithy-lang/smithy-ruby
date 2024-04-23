// This file defines test cases that serialize synthesized JSON documents
// in the payload of HTTP requests and responses.

$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use aws.protocoltests.shared#DateTime
use aws.protocoltests.shared#EpochSeconds
use aws.protocoltests.shared#FooEnum
use aws.protocoltests.shared#FooEnumList
use aws.protocoltests.shared#FooEnumSet
use aws.protocoltests.shared#FooEnumMap
use aws.protocoltests.shared#IntegerEnum
use aws.protocoltests.shared#IntegerEnumList
use aws.protocoltests.shared#IntegerEnumSet
use aws.protocoltests.shared#IntegerEnumMap
use aws.protocoltests.shared#HttpDate
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

// This example serializes simple scalar types in the top level JSON document.
// Note that headers are not serialized in the payload.
@idempotent
@http(uri: "/SimpleScalarProperties", method: "PUT")
operation SimpleScalarProperties {
    input: SimpleScalarPropertiesInputOutput,
    output: SimpleScalarPropertiesInputOutput
}

apply SimpleScalarProperties @httpRequestTests([
    {
        id: "RailsJsonSimpleScalarProperties",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: """
              {
                  "string_value": "string",
                  "true_boolean_value": true,
                  "false_boolean_value": false,
                  "byte_value": 1,
                  "short_value": 2,
                  "integer_value": 3,
                  "long_value": 4,
                  "float_value": 5.5,
                  "DoubleDribble": 6.5
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
            "X-Foo": "Foo",
        },
        params: {
            foo: "Foo",
            stringValue: "string",
            trueBooleanValue: true,
            falseBooleanValue: false,
            byteValue: 1,
            shortValue: 2,
            integerValue: 3,
            longValue: 4,
            floatValue: 5.5,
            doubleValue: 6.5,
        }
    },
    {
        id: "RailsJsonDoesntSerializeNullStructureValues",
        documentation: "Rails Json should not serialize null structure values",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            stringValue: null
        },
        appliesTo: "client",
    },
    {
        id: "RailsJsonServersDontSerializeNullStructureValues",
        documentation: "Rails Json should not deserialize null structure values",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: """
            {
                "string_value": null
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {},
        appliesTo: "server",
    },
    {
        id: "RailsJsonSupportsNaNFloatInputs",
        documentation: "Supports handling NaN float values.",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: """
            {
                "float_value": "NaN",
                "DoubleDribble": "NaN"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "NaN",
            doubleValue: "NaN",
        }
    },
    {
        id: "RailsJsonSupportsInfinityFloatInputs",
        documentation: "Supports handling Infinity float values.",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: """
            {
                "float_value": "Infinity",
                "DoubleDribble": "Infinity"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "Infinity",
            doubleValue: "Infinity",
        }
    },
    {
        id: "RailsJsonSupportsNegativeInfinityFloatInputs",
        documentation: "Supports handling -Infinity float values.",
        protocol: railsJson,
        method: "PUT",
        uri: "/SimpleScalarProperties",
        body: """
            {
                "float_value": "-Infinity",
                "DoubleDribble": "-Infinity"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "-Infinity",
            doubleValue: "-Infinity",
        }
    },
])

apply SimpleScalarProperties @httpResponseTests([
    {
        id: "RailsJsonSimpleScalarProperties",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "string_value": "string",
                  "true_boolean_value": true,
                  "false_boolean_value": false,
                  "byte_value": 1,
                  "short_value": 2,
                  "integer_value": 3,
                  "long_value": 4,
                  "float_value": 5.5,
                  "DoubleDribble": 6.5
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
            "X-Foo": "Foo",
        },
        params: {
            foo: "Foo",
            stringValue: "string",
            trueBooleanValue: true,
            falseBooleanValue: false,
            byteValue: 1,
            shortValue: 2,
            integerValue: 3,
            longValue: 4,
            floatValue: 5.5,
            doubleValue: 6.5,
        }
    },
    {
        id: "RailsJsonDoesntDeserializeNullStructureValues",
        documentation: "Rails Json should not deserialize null structure values",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "string_value": null
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {},
        appliesTo: "client",
    },
    {
        id: "RailsJsonServersDontSerializeNullStructureValues",
        documentation: "Rails Json should not serialize null structure values",
        protocol: railsJson,
        code: 200,
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            stringValue: null
        },
        appliesTo: "server",
    },
    {
        id: "RailsJsonSupportsNaNFloatInputs",
        documentation: "Supports handling NaN float values.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "float_value": "NaN",
                "DoubleDribble": "NaN"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "NaN",
            doubleValue: "NaN",
        }
    },
    {
        id: "RailsJsonSupportsInfinityFloatInputs",
        documentation: "Supports handling Infinity float values.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "float_value": "Infinity",
                "DoubleDribble": "Infinity"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "Infinity",
            doubleValue: "Infinity",
        }
    },
    {
        id: "RailsJsonSupportsNegativeInfinityFloatInputs",
        documentation: "Supports handling -Infinity float values.",
        protocol: railsJson,
        code: 200,
        body: """
            {
                "float_value": "-Infinity",
                "DoubleDribble": "-Infinity"
            }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
        },
        params: {
            floatValue: "-Infinity",
            doubleValue: "-Infinity",
        }
    },
])

structure SimpleScalarPropertiesInputOutput {
    @httpHeader("X-Foo")
    foo: String,

    stringValue: String,
    trueBooleanValue: Boolean,
    falseBooleanValue: Boolean,
    byteValue: Byte,
    shortValue: Short,
    integerValue: Integer,
    longValue: Long,
    floatValue: Float,

    @jsonName("DoubleDribble")
    doubleValue: Double,
}

/// Blobs are base64 encoded
@http(uri: "/JsonBlobs", method: "POST")
operation JsonBlobs {
    input: JsonBlobsInputOutput,
    output: JsonBlobsInputOutput
}

apply JsonBlobs @httpRequestTests([
    {
        id: "RailsJsonBlobs",
        documentation: "Blobs are base64 encoded",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonBlobs",
        body: """
              {
                  "data": "dmFsdWU="
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            data: "value"
        }
    }
])

apply JsonBlobs @httpResponseTests([
    {
        id: "RailsJsonBlobs",
        documentation: "Blobs are base64 encoded",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "data": "dmFsdWU="
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            data: "value"
        }
    }
])

structure JsonBlobsInputOutput {
    data: Blob
}

/// This tests how timestamps are serialized, including using the
/// default format of date-time and various @timestampFormat trait
/// values.
@http(uri: "/JsonTimestamps", method: "POST")
operation JsonTimestamps {
    input: JsonTimestampsInputOutput,
    output: JsonTimestampsInputOutput
}

apply JsonTimestamps @httpRequestTests([
    {
        id: "RailsJsonTimestamps",
        documentation: "Tests how normal timestamps are serialized",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "normal": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            normal: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithDateTimeFormat",
        documentation: "Ensures that the timestampFormat of date-time works like normal timestamps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "date_time": "2014-04-29T18:30:38Z"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            dateTime: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithDateTimeOnTargetFormat",
        documentation: "Ensures that the timestampFormat of date-time on the target shape works like normal timestamps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "date_time_on_target": "2014-04-29T18:30:38Z"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            dateTimeOnTarget: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithEpochSecondsFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "epoch_seconds": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            epochSeconds: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithEpochSecondsOnTargetFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds on the target shape works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "epoch_seconds_on_target": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            epochSecondsOnTarget: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithHttpDateFormat",
        documentation: "Ensures that the timestampFormat of http-date works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "http_date": "Tue, 29 Apr 2014 18:30:38 GMT"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            httpDate: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithHttpDateOnTargetFormat",
        documentation: "Ensures that the timestampFormat of http-date on the target shape works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "http_date_on_target": "Tue, 29 Apr 2014 18:30:38 GMT"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            httpDateOnTarget: 1398796238
        }
    },
])

apply JsonTimestamps @httpResponseTests([
    {
        id: "RailsJsonTimestamps",
        documentation: "Tests how normal timestamps are serialized",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "normal": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            normal: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithDateTimeFormat",
        documentation: "Ensures that the timestampFormat of date-time works like normal timestamps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "date_time": "2014-04-29T18:30:38Z"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            dateTime: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithDateTimeOnTargetFormat",
        documentation: "Ensures that the timestampFormat of date-time on the target shape works like normal timestamps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "date_time_on_target": "2014-04-29T18:30:38Z"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            dateTimeOnTarget: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithEpochSecondsFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "epoch_seconds": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            epochSeconds: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithEpochSecondsOnTargetFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds on the target shape works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "epoch_seconds_on_target": 1398796238
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            epochSecondsOnTarget: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithHttpDateFormat",
        documentation: "Ensures that the timestampFormat of http-date works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "http_date": "Tue, 29 Apr 2014 18:30:38 GMT"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            httpDate: 1398796238
        }
    },
    {
        id: "RailsJsonTimestampsWithHttpDateOnTargetFormat",
        documentation: "Ensures that the timestampFormat of http-date on the target shape works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "http_date_on_target": "Tue, 29 Apr 2014 18:30:38 GMT"
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            httpDateOnTarget: 1398796238
        }
    }
])

structure JsonTimestampsInputOutput {
    @timestampFormat("epoch-seconds")
    normal: Timestamp,

    @timestampFormat("date-time")
    dateTime: Timestamp,

    dateTimeOnTarget: DateTime,

    @timestampFormat("epoch-seconds")
    epochSeconds: Timestamp,

    epochSecondsOnTarget: EpochSeconds,

    @timestampFormat("http-date")
    httpDate: Timestamp,

    httpDateOnTarget: HttpDate,
}

/// This example serializes enums as top level properties, in lists, sets, and maps.
@idempotent
@http(uri: "/JsonEnums", method: "PUT")
operation JsonEnums {
    input: JsonEnumsInputOutput,
    output: JsonEnumsInputOutput
}

apply JsonEnums @httpRequestTests([
    {
        id: "RailsJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        method: "PUT",
        uri: "/JsonEnums",
        body: """
              {
                  "foo_enum1": "Foo",
                  "foo_enum2": "0",
                  "foo_enum3": "1",
                  "foo_enum_list": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_set": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_map": {
                      "hi": "Foo",
                      "zero": "0"
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            fooEnum1: "Foo",
            fooEnum2: "0",
            fooEnum3: "1",
            fooEnumList: ["Foo", "0"],
            fooEnumSet: ["Foo", "0"],
            fooEnumMap: {
                "hi": "Foo",
                "zero": "0"
            }
        }
    }
])

apply JsonEnums @httpResponseTests([
    {
        id: "RailsJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "foo_enum1": "Foo",
                  "foo_enum2": "0",
                  "foo_enum3": "1",
                  "foo_enum_list": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_set": [
                      "Foo",
                      "0"
                  ],
                  "foo_enum_map": {
                      "hi": "Foo",
                      "zero": "0"
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            fooEnum1: "Foo",
            fooEnum2: "0",
            fooEnum3: "1",
            fooEnumList: ["Foo", "0"],
            fooEnumSet: ["Foo", "0"],
            fooEnumMap: {
                "hi": "Foo",
                "zero": "0"
            }
        }
    }
])

structure JsonEnumsInputOutput {
    fooEnum1: FooEnum,
    fooEnum2: FooEnum,
    fooEnum3: FooEnum,
    fooEnumList: FooEnumList,
    fooEnumSet: FooEnumSet,
    fooEnumMap: FooEnumMap,
}

/// This example serializes intEnums as top level properties, in lists, sets, and maps.
@idempotent
@http(uri: "/JsonIntEnums", method: "PUT")
operation JsonIntEnums {
    input: JsonIntEnumsInputOutput,
    output: JsonIntEnumsInputOutput
}

apply JsonIntEnums @httpRequestTests([
    {
        id: "RailsJsonIntEnums",
        documentation: "Serializes intEnums as integers",
        protocol: railsJson,
        method: "PUT",
        uri: "/JsonIntEnums",
        body: """
              {
                  "integer_enum1": 1,
                  "integer_enum2": 2,
                  "integer_enum3": 3,
                  "integer_enum_list": [
                      1,
                      2,
                      3
                  ],
                  "integer_enum_set": [
                      1,
                      2
                  ],
                  "integer_enum_map": {
                      "abc": 1,
                      "def": 2
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            integerEnum1: 1,
            integerEnum2: 2,
            integerEnum3: 3,
            integerEnumList: [1, 2, 3],
            integerEnumSet: [1, 2],
            integerEnumMap: {
                "abc": 1,
                "def": 2
            }
        }
    }
])

apply JsonIntEnums @httpResponseTests([
    {
        id: "RailsJsonIntEnums",
        documentation: "Serializes intEnums as integers",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "integer_enum1": 1,
                  "integer_enum2": 2,
                  "integer_enum3": 3,
                  "integer_enum_list": [
                      1,
                      2,
                      3
                  ],
                  "integer_enum_set": [
                      1,
                      2
                  ],
                  "integer_enum_map": {
                      "abc": 1,
                      "def": 2
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            integerEnum1: 1,
            integerEnum2: 2,
            integerEnum3: 3,
            integerEnumList: [1, 2, 3],
            integerEnumSet: [1, 2],
            integerEnumMap: {
                "abc": 1,
                "def": 2
            }
        }
    }
])

structure JsonIntEnumsInputOutput {
    integerEnum1: IntegerEnum,
    integerEnum2: IntegerEnum,
    integerEnum3: IntegerEnum,
    integerEnumList: IntegerEnumList,
    integerEnumSet: IntegerEnumSet,
    integerEnumMap: IntegerEnumMap,
}

/// Recursive shapes
@idempotent
@http(uri: "/RecursiveShapes", method: "PUT")
operation RecursiveShapes {
    input: RecursiveShapesInputOutput,
    output: RecursiveShapesInputOutput
}

apply RecursiveShapes @httpRequestTests([
    {
        id: "RailsJsonRecursiveShapes",
        documentation: "Serializes recursive structures",
        protocol: railsJson,
        method: "PUT",
        uri: "/RecursiveShapes",
        body: """
              {
                  "nested": {
                      "foo": "Foo1",
                      "nested": {
                          "bar": "Bar1",
                          "recursive_member": {
                              "foo": "Foo2",
                              "nested": {
                                  "bar": "Bar2"
                              }
                          }
                      }
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            nested: {
                foo: "Foo1",
                nested: {
                    bar: "Bar1",
                    recursiveMember: {
                        foo: "Foo2",
                        nested: {
                            bar: "Bar2"
                        }
                    }
                }
            }
        }
    }
])

apply RecursiveShapes @httpResponseTests([
    {
        id: "RailsJsonRecursiveShapes",
        documentation: "Serializes recursive structures",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "nested": {
                      "foo": "Foo1",
                      "nested": {
                          "bar": "Bar1",
                          "recursive_member": {
                              "foo": "Foo2",
                              "nested": {
                                  "bar": "Bar2"
                              }
                          }
                      }
                  }
              }""",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json"
        },
        params: {
            nested: {
                foo: "Foo1",
                nested: {
                    bar: "Bar1",
                    recursiveMember: {
                        foo: "Foo2",
                        nested: {
                            bar: "Bar2"
                        }
                    }
                }
            }
        }
    }
])

structure RecursiveShapesInputOutput {
    nested: RecursiveShapesInputOutputNested1
}

structure RecursiveShapesInputOutputNested1 {
    foo: String,
    nested: RecursiveShapesInputOutputNested2
}

structure RecursiveShapesInputOutputNested2 {
    bar: String,
    recursiveMember: RecursiveShapesInputOutputNested1,
}
