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
                  "stringValue": "string",
                  "trueBooleanValue": true,
                  "falseBooleanValue": false,
                  "byteValue": 1,
                  "shortValue": 2,
                  "integerValue": 3,
                  "longValue": 4,
                  "floatValue": 5.5,
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
                "stringValue": null
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
                "floatValue": "NaN",
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
                "floatValue": "Infinity",
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
                "floatValue": "-Infinity",
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
                  "stringValue": "string",
                  "trueBooleanValue": true,
                  "falseBooleanValue": false,
                  "byteValue": 1,
                  "shortValue": 2,
                  "integerValue": 3,
                  "longValue": 4,
                  "floatValue": 5.5,
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
                  "stringValue": null
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
                "floatValue": "NaN",
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
                "floatValue": "Infinity",
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
                "floatValue": "-Infinity",
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
        id: "RailsJsonJsonBlobs",
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
        id: "RailsJsonJsonBlobs",
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
        id: "RailsJsonJsonTimestamps",
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
        id: "RailsJsonJsonTimestampsWithDateTimeFormat",
        documentation: "Ensures that the timestampFormat of date-time works like normal timestamps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "dateTime": "2014-04-29T18:30:38Z"
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
        id: "RailsJsonJsonTimestampsWithDateTimeOnTargetFormat",
        documentation: "Ensures that the timestampFormat of date-time on the target shape works like normal timestamps",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "dateTimeOnTarget": "2014-04-29T18:30:38Z"
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
        id: "RailsJsonJsonTimestampsWithEpochSecondsFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "epochSeconds": 1398796238
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
        id: "RailsJsonJsonTimestampsWithEpochSecondsOnTargetFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds on the target shape works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "epochSecondsOnTarget": 1398796238
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
        id: "RailsJsonJsonTimestampsWithHttpDateFormat",
        documentation: "Ensures that the timestampFormat of http-date works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "httpDate": "Tue, 29 Apr 2014 18:30:38 GMT"
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
        id: "RailsJsonJsonTimestampsWithHttpDateOnTargetFormat",
        documentation: "Ensures that the timestampFormat of http-date on the target shape works",
        protocol: railsJson,
        method: "POST",
        uri: "/JsonTimestamps",
        body: """
              {
                  "httpDateOnTarget": "Tue, 29 Apr 2014 18:30:38 GMT"
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
        id: "RailsJsonJsonTimestamps",
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
        id: "RailsJsonJsonTimestampsWithDateTimeFormat",
        documentation: "Ensures that the timestampFormat of date-time works like normal timestamps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "dateTime": "2014-04-29T18:30:38Z"
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
        id: "RailsJsonJsonTimestampsWithDateTimeOnTargetFormat",
        documentation: "Ensures that the timestampFormat of date-time on the target shape works like normal timestamps",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "dateTimeOnTarget": "2014-04-29T18:30:38Z"
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
        id: "RailsJsonJsonTimestampsWithEpochSecondsFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "epochSeconds": 1398796238
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
        id: "RailsJsonJsonTimestampsWithEpochSecondsOnTargetFormat",
        documentation: "Ensures that the timestampFormat of epoch-seconds on the target shape works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "epochSecondsOnTarget": 1398796238
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
        id: "RailsJsonJsonTimestampsWithHttpDateFormat",
        documentation: "Ensures that the timestampFormat of http-date works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "httpDate": "Tue, 29 Apr 2014 18:30:38 GMT"
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
        id: "RailsJsonJsonTimestampsWithHttpDateOnTargetFormat",
        documentation: "Ensures that the timestampFormat of http-date on the target shape works",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "httpDateOnTarget": "Tue, 29 Apr 2014 18:30:38 GMT"
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
        id: "RailsJsonJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        method: "PUT",
        uri: "/JsonEnums",
        body: """
              {
                  "fooEnum1": "Foo",
                  "fooEnum2": "0",
                  "fooEnum3": "1",
                  "fooEnumList": [
                      "Foo",
                      "0"
                  ],
                  "fooEnumSet": [
                      "Foo",
                      "0"
                  ],
                  "fooEnumMap": {
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
        id: "RailsJsonJsonEnums",
        documentation: "Serializes simple scalar properties",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "fooEnum1": "Foo",
                  "fooEnum2": "0",
                  "fooEnum3": "1",
                  "fooEnumList": [
                      "Foo",
                      "0"
                  ],
                  "fooEnumSet": [
                      "Foo",
                      "0"
                  ],
                  "fooEnumMap": {
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
        id: "RailsJsonJsonIntEnums",
        documentation: "Serializes intEnums as integers",
        protocol: railsJson,
        method: "PUT",
        uri: "/JsonIntEnums",
        body: """
              {
                  "integerEnum1": 1,
                  "integerEnum2": 2,
                  "integerEnum3": 3,
                  "integerEnumList": [
                      1,
                      2,
                      3
                  ],
                  "integerEnumSet": [
                      1,
                      2
                  ],
                  "integerEnumMap": {
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
        id: "RailsJsonJsonIntEnums",
        documentation: "Serializes intEnums as integers",
        protocol: railsJson,
        code: 200,
        body: """
              {
                  "integerEnum1": 1,
                  "integerEnum2": 2,
                  "integerEnum3": 3,
                  "integerEnumList": [
                      1,
                      2,
                      3
                  ],
                  "integerEnumSet": [
                      1,
                      2
                  ],
                  "integerEnumMap": {
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
                          "recursiveMember": {
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
                          "recursiveMember": {
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
