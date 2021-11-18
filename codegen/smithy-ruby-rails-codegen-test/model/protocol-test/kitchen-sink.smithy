$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson

use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@httpRequestTests([
    {
        id: "rails_json_rails_json_serializes_string_shapes",
        protocol: railsJson,
        documentation: "Serializes string shapes",
        body: "{\"string\":\"abc xyz\"}",
        headers: {"Content-Type": "application/json"},
        bodyMediaType: "application/json",
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            String: "abc xyz",
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_string_shapes_with_jsonvalue_trait",
        protocol: railsJson,
        documentation: "Serializes string shapes with jsonvalue trait",
        body: "{\"json_value\":\"{\\\"string\\\":\\\"value\\\",\\\"number\\\":1234.5,\\\"boolTrue\\\":true,\\\"boolFalse\\\":false,\\\"array\\\":[1,2,3,4],\\\"object\\\":{\\\"key\\\":\\\"value\\\"},\\\"null\\\":null}\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            JsonValue: "{\"string\":\"value\",\"number\":1234.5,\"boolTrue\":true,\"boolFalse\":false,\"array\":[1,2,3,4],\"object\":{\"key\":\"value\"},\"null\":null}",
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_integer_shapes",
        protocol: railsJson,
        documentation: "Serializes integer shapes",
        body: "{\"integer\":1234}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Integer: 1234,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_long_shapes",
        protocol: railsJson,
        documentation: "Serializes long shapes",
        body: "{\"long\":999999999999}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Long: 999999999999,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_float_shapes",
        protocol: railsJson,
        documentation: "Serializes float shapes",
        body: "{\"float\":1234.5}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Float: 1234.5,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_double_shapes",
        protocol: railsJson,
        documentation: "Serializes double shapes",
        body: "{\"double\":1234.5}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Double: 1234.5,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_blob_shapes",
        protocol: railsJson,
        documentation: "Serializes blob shapes",
        body: "{\"blob\":\"YmluYXJ5LXZhbHVl\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Blob: "binary-value",
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_boolean_shapes_true",
        protocol: railsJson,
        documentation: "Serializes boolean shapes (true)",
        body: "{\"boolean\":true}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Boolean: true,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_boolean_shapes_false",
        protocol: railsJson,
        documentation: "Serializes boolean shapes (false)",
        body: "{\"boolean\":false}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Boolean: false,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_timestamp_shapes",
        protocol: railsJson,
        documentation: "Serializes timestamp shapes",
        body: "{\"timestamp\":\"2000-01-02T20:34:56.000Z\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Timestamp: 946845296,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_timestamp_shapes_with_iso8601_timestampformat",
        protocol: railsJson,
        documentation: "Serializes timestamp shapes with iso8601 timestampFormat",
        body: "{\"iso8601_timestamp\":\"2000-01-02T20:34:56.000Z\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            Iso8601Timestamp: 946845296,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_timestamp_shapes_with_httpdate_timestampformat",
        protocol: railsJson,
        documentation: "Serializes timestamp shapes with httpdate timestampFormat",
        body: "{\"httpdate_timestamp\":\"Sun, 02 Jan 2000 20:34:56 GMT\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            HttpdateTimestamp: 946845296,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_timestamp_shapes_with_unixtimestamp_timestampformat",
        protocol: railsJson,
        documentation: "Serializes timestamp shapes with unixTimestamp timestampFormat",
        body: "{\"unix_timestamp\":946845296}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            UnixTimestamp: 946845296,
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_list_shapes",
        protocol: railsJson,
        documentation: "Serializes list shapes",
        body: "{\"list_of_strings\":[\"abc\",\"mno\",\"xyz\"]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            ListOfStrings: [
                "abc",
                "mno",
                "xyz",
            ],
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_empty_list_shapes",
        protocol: railsJson,
        documentation: "Serializes empty list shapes",
        body: "{\"list_of_strings\":[]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            ListOfStrings: [],
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_list_of_map_shapes",
        protocol: railsJson,
        documentation: "Serializes list of map shapes",
        body: "{\"list_of_maps_of_strings\":[{\"foo\":\"bar\"},{\"abc\":\"xyz\"},{\"red\":\"blue\"}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            ListOfMapsOfStrings: [
                {
                    foo: "bar",
                },
                {
                    abc: "xyz",
                },
                {
                    red: "blue",
                },
            ],
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_list_of_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes list of structure shapes",
        body: "{\"list_of_structs\":[{\"value\":\"abc\"},{\"value\":\"mno\"},{\"value\":\"xyz\"}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            ListOfStructs: [
                {
                    Value: "abc",
                },
                {
                    Value: "mno",
                },
                {
                    Value: "xyz",
                },
            ],
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_list_of_recursive_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes list of recursive structure shapes",
        body: "{\"recursive_list\":[{\"recursive_list\":[{\"recursive_list\":[{\"integer\":123}]}]}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            RecursiveList: [
                {
                    RecursiveList: [
                        {
                            RecursiveList: [
                                {
                                    Integer: 123,
                                },
                            ],
                        },
                    ],
                },
            ],
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_map_shapes",
        protocol: railsJson,
        documentation: "Serializes map shapes",
        body: "{\"map_of_strings\":{\"abc\":\"xyz\",\"mno\":\"hjk\"}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            MapOfStrings: {
                abc: "xyz",
                mno: "hjk",
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_empty_map_shapes",
        protocol: railsJson,
        documentation: "Serializes empty map shapes",
        body: "{\"map_of_strings\":{}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            MapOfStrings: {},
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_map_of_list_shapes",
        protocol: railsJson,
        documentation: "Serializes map of list shapes",
        body: "{\"map_of_lists_of_strings\":{\"abc\":[\"abc\",\"xyz\"],\"mno\":[\"xyz\",\"abc\"]}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            MapOfListsOfStrings: {
                abc: [
                    "abc",
                    "xyz",
                ],
                mno: [
                    "xyz",
                    "abc",
                ],
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_map_of_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes map of structure shapes",
        body: "{\"map_of_structs\":{\"key1\":{\"value\":\"value-1\"},\"key2\":{\"value\":\"value-2\"}}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            MapOfStructs: {
                key1: {
                    Value: "value-1",
                },
                key2: {
                    Value: "value-2",
                },
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_map_of_recursive_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes map of recursive structure shapes",
        body: "{\"recursive_map\":{\"key1\":{\"recursive_map\":{\"key2\":{\"recursive_map\":{\"key3\":{\"boolean\":false}}}}}}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            RecursiveMap: {
                key1: {
                    RecursiveMap: {
                        key2: {
                            RecursiveMap: {
                                key3: {
                                    Boolean: false,
                                },
                            },
                        },
                    },
                },
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes structure shapes",
        body: "{\"simple_struct\":{\"value\":\"abc\"}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            SimpleStruct: {
                Value: "abc",
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_structure_members_with_locationname_traits",
        protocol: railsJson,
        documentation: "Serializes structure members with locationName traits",
        body: "{\"struct_with_location_name\":{\"RenamedMember\":\"some-value\"}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            StructWithLocationName: {
                Value: "some-value",
            },
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_empty_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes empty structure shapes",
        body: "{\"simple_struct\":{}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            SimpleStruct: {},
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_structure_which_have_no_members",
        protocol: railsJson,
        documentation: "Serializes structure which have no members",
        body: "{\"empty_struct\":{}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            EmptyStruct: {},
        },
        method: "POST",
        uri: "/",
    },
    {
        id: "rails_json_serializes_recursive_structure_shapes",
        protocol: railsJson,
        documentation: "Serializes recursive structure shapes",
        body: "{\"string\":\"top-value\",\"boolean\":false,\"recursive_struct\":{\"string\":\"nested-value\",\"boolean\":true,\"recursive_list\":[{\"string\":\"string-only\"},{\"recursive_struct\":{\"map_of_strings\":{\"color\":\"red\",\"size\":\"large\"}}}]}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        requireHeaders: [
            "Content-Length"
        ],
        params: {
            String: "top-value",
            Boolean: false,
            RecursiveStruct: {
                String: "nested-value",
                Boolean: true,
                RecursiveList: [
                    {
                        String: "string-only",
                    },
                    {
                        RecursiveStruct: {
                            MapOfStrings: {
                                color: "red",
                                size: "large",
                            },
                        },
                    },
                ],
            },
        },
        method: "POST",
        uri: "/",
    },
])
@httpResponseTests([
    {
        id: "rails_json_parses_operations_with_empty_json_bodies",
        protocol: railsJson,
        documentation: "Parses operations with empty JSON bodies",
        body: "{}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        code: 200,
    },
    {
        id: "rails_json_parses_string_shapes",
        protocol: railsJson,
        documentation: "Parses string shapes",
        body: "{\"string\":\"string-value\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            String: "string-value",
        },
        code: 200,
    },
    {
        id: "rails_json_parses_integer_shapes",
        protocol: railsJson,
        documentation: "Parses integer shapes",
        body: "{\"integer\":1234}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Integer: 1234,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_long_shapes",
        protocol: railsJson,
        documentation: "Parses long shapes",
        body: "{\"long\":1234567890123456789}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Long: 1234567890123456789,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_float_shapes",
        protocol: railsJson,
        documentation: "Parses float shapes",
        body: "{\"float\":1234.5}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Float: 1234.5,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_double_shapes",
        protocol: railsJson,
        documentation: "Parses double shapes",
        body: "{\"double\":123456789.12345679}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Double: 123456789.12345679,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_boolean_shapes_true",
        protocol: railsJson,
        documentation: "Parses boolean shapes (true)",
        body: "{\"boolean\":true}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Boolean: true,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_boolean_false",
        protocol: railsJson,
        documentation: "Parses boolean (false)",
        body: "{\"boolean\":false}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Boolean: false,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_blob_shapes",
        protocol: railsJson,
        documentation: "Parses blob shapes",
        body: "{\"blob\":\"YmluYXJ5LXZhbHVl\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Blob: "binary-value",
        },
        code: 200,
    },
    {
        id: "rails_json_parses_timestamp_shapes",
        protocol: railsJson,
        documentation: "Parses timestamp shapes",
        body: "{\"timestamp\":\"2000-01-02T20:34:56.000Z\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Timestamp: 946845296,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_iso8601_timestamps",
        protocol: railsJson,
        documentation: "Parses iso8601 timestamps",
        body: "{\"iso8601_timestamp\":\"2000-01-02T20:34:56.000Z\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            Iso8601Timestamp: 946845296,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_httpdate_timestamps",
        protocol: railsJson,
        documentation: "Parses httpdate timestamps",
        body: "{\"httpdate_timestamp\":\"Sun, 02 Jan 2000 20:34:56.000 GMT\"}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            HttpdateTimestamp: 946845296,
        },
        code: 200,
    },
    {
        id: "rails_json_parses_list_shapes",
        protocol: railsJson,
        documentation: "Parses list shapes",
        body: "{\"list_of_strings\":[\"abc\",\"mno\",\"xyz\"]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            ListOfStrings: [
                "abc",
                "mno",
                "xyz",
            ],
        },
        code: 200,
    },
    {
        id: "rails_json_parses_list_of_map_shapes",
        protocol: railsJson,
        documentation: "Parses list of map shapes",
        body: "{\"list_of_maps_of_strings\":[{\"size\":\"large\"},{\"color\":\"red\"}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            ListOfMapsOfStrings: [
                {
                    size: "large",
                },
                {
                    color: "red",
                },
            ],
        },
        code: 200,
    },
    {
        id: "rails_json_parses_list_of_list_shapes",
        protocol: railsJson,
        documentation: "Parses list of list shapes",
        body: "{\"list_of_lists\":[[\"abc\",\"mno\",\"xyz\"],[\"hjk\",\"qrs\",\"tuv\"]]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            ListOfLists: [
                [
                    "abc",
                    "mno",
                    "xyz",
                ],
                [
                    "hjk",
                    "qrs",
                    "tuv",
                ],
            ],
        },
        code: 200,
    },
    {
        id: "rails_json_parses_list_of_structure_shapes",
        protocol: railsJson,
        documentation: "Parses list of structure shapes",
        body: "{\"list_of_structs\":[{\"value\":\"value-1\"},{\"value\":\"value-2\"}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            ListOfStructs: [
                {
                    Value: "value-1",
                },
                {
                    Value: "value-2",
                },
            ],
        },
        code: 200,
    },
    {
        id: "rails_json_parses_list_of_recursive_structure_shapes",
        protocol: railsJson,
        documentation: "Parses list of recursive structure shapes",
        body: "{\"recursive_list\":[{\"recursive_list\":[{\"recursive_list\":[{\"string\":\"value\"}]}]}]}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            RecursiveList: [
                {
                    RecursiveList: [
                        {
                            RecursiveList: [
                                {
                                    String: "value",
                                },
                            ],
                        },
                    ],
                },
            ],
        },
        code: 200,
    },
    {
        id: "rails_json_parses_map_shapes",
        protocol: railsJson,
        documentation: "Parses map shapes",
        body: "{\"map_of_strings\":{\"size\":\"large\",\"color\":\"red\"}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            MapOfStrings: {
                size: "large",
                color: "red",
            },
        },
        code: 200,
    },
    {
        id: "rails_json_parses_map_of_list_shapes",
        protocol: railsJson,
        documentation: "Parses map of list shapes",
        body: "{\"map_of_lists_of_strings\":{\"sizes\":[\"large\",\"small\"],\"colors\":[\"red\",\"green\"]}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            MapOfListsOfStrings: {
                sizes: [
                    "large",
                    "small",
                ],
                colors: [
                    "red",
                    "green",
                ],
            },
        },
        code: 200,
    },
    {
        id: "rails_json_parses_map_of_map_shapes",
        protocol: railsJson,
        documentation: "Parses map of map shapes",
        body: "{\"map_of_maps\":{\"sizes\":{\"large\":\"L\",\"medium\":\"M\"},\"colors\":{\"red\":\"R\",\"blue\":\"B\"}}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            MapOfMaps: {
                sizes: {
                    large: "L",
                    medium: "M",
                },
                colors: {
                    red: "R",
                    blue: "B",
                },
            },
        },
        code: 200,
    },
    {
        id: "rails_json_parses_map_of_structure_shapes",
        protocol: railsJson,
        documentation: "Parses map of structure shapes",
        body: "{\"map_of_structs\":{\"size\":{\"value\":\"small\"},\"color\":{\"value\":\"red\"}}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            MapOfStructs: {
                size: {
                    Value: "small",
                },
                color: {
                    Value: "red",
                },
            },
        },
        code: 200,
    },
    {
        id: "rails_json_parses_map_of_recursive_structure_shapes",
        protocol: railsJson,
        documentation: "Parses map of recursive structure shapes",
        body: "{\"recursive_map\":{\"key-1\":{\"recursive_map\":{\"key-2\":{\"recursive_map\":{\"key-3\":{\"string\":\"value\"}}}}}}}",
        bodyMediaType: "application/json",
        headers: {"Content-Type": "application/json"},
        params: {
            RecursiveMap: {
                "key-1": {
                    RecursiveMap: {
                        "key-2": {
                            RecursiveMap: {
                                "key-3": {
                                    String: "value",
                                },
                            },
                        },
                    },
                },
            },
        },
        code: 200,
    },
    {
        id: "rails_json_parses_the_request_id_from_the_response",
        protocol: railsJson,
        documentation: "Parses the request id from the response",
        body: "{}",
        bodyMediaType: "application/json",
        headers: {
            "X-Amzn-Requestid": "amazon-uniq-request-id",
            "Content-Type": "application/json"
        },
        code: 200,
    },
])
@http(method: "POST", uri: "/")
operation KitchenSinkOperation {
    input: KitchenSink,
    output: KitchenSink,
    errors: [
        ErrorWithMembers,
        ErrorWithoutMembers,
    ],
}

@error("client")
structure ErrorWithMembers {
    Code: String,
    ComplexData: KitchenSink,
    IntegerField: Integer,
    ListField: ListOfStrings,
    MapField: MapOfStrings,
    Message: String,
    /// abc
    StringField: String,
}

@error("server")
structure ErrorWithoutMembers {}

structure KitchenSink {
    Blob: Blob,
    Boolean: Boolean,
    Double: Double,
    EmptyStruct: EmptyStruct,
    Float: Float,
    @timestampFormat("http-date")
    HttpdateTimestamp: Timestamp,
    Integer: Integer,
    @timestampFormat("date-time")
    Iso8601Timestamp: Timestamp,
    JsonValue: JsonValue,
    ListOfLists: ListOfListOfStrings,
    ListOfMapsOfStrings: ListOfMapsOfStrings,
    ListOfStrings: ListOfStrings,
    ListOfStructs: ListOfStructs,
    Long: Long,
    MapOfListsOfStrings: MapOfListsOfStrings,
    MapOfMaps: MapOfMapOfStrings,
    MapOfStrings: MapOfStrings,
    MapOfStructs: MapOfStructs,
    RecursiveList: ListOfKitchenSinks,
    RecursiveMap: MapOfKitchenSinks,
    RecursiveStruct: KitchenSink,
    SimpleStruct: SimpleStruct,
    String: String,
    StructWithLocationName: StructWithLocationName,
    Timestamp: Timestamp,
    @timestampFormat("epoch-seconds")
    UnixTimestamp: Timestamp,
}

list ListOfKitchenSinks {
    member: KitchenSink,
}

map MapOfKitchenSinks {
    key: String,
    value: KitchenSink,
}