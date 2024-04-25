$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

/// A REST JSON service that sends JSON requests and responses.
@railsJson(errorHeader: "X-Amzn-Errortype")
@title("Sample Rails Json Protocol Service")
service RailsJson {
    version: "2019-12-16",
    // Ensure that generators are able to handle renames.
    rename: {
        "smithy.ruby.protocoltests.railsjson.nested#GreetingStruct": "RenamedGreeting",
    },
    operations: [
        // Basic input and output tests
        NoInputAndNoOutput,
        NoInputAndOutput,
        EmptyInputAndEmptyOutput,
        UnitInputAndOutput,

        // @httpHeader tests
        InputAndOutputWithHeaders,
        NullAndEmptyHeadersClient,
        NullAndEmptyHeadersServer,
        TimestampFormatHeaders,
        MediaTypeHeader,

        // @httpLabel tests
        HttpRequestWithLabels,
        HttpRequestWithLabelsAndTimestampFormat,
        HttpRequestWithGreedyLabelInPath,
        HttpRequestWithFloatLabels,
        HttpRequestWithRegexLiteral,

        // @httpQuery and @httpQueryParams tests
        AllQueryStringTypes,
        ConstantQueryString,
        ConstantAndVariableQueryString,
        IgnoreQueryParamsInResponse,
        OmitsNullSerializesEmptyString,
        OmitsSerializingEmptyLists,
        QueryIdempotencyTokenAutoFill,
        QueryPrecedence,
        QueryParamsAsStringListMap,

        // @httpPrefixHeaders tests
        HttpPrefixHeaders,
        HttpPrefixHeadersInResponse,

        // @httpPayload tests
        HttpPayloadTraits,
        HttpPayloadTraitsWithMediaType,
        HttpPayloadWithStructure,
        HttpEnumPayload,
        HttpStringPayload,
        HttpPayloadWithUnion,

        // @httpResponseCode tests
        HttpResponseCode,

        // @streaming tests
        StreamingTraits,
        StreamingTraitsRequireLength,
        StreamingTraitsWithMediaType,

        // Errors
        GreetingWithErrors,

        // Synthesized JSON document body tests
        SimpleScalarProperties,
        JsonTimestamps,
        JsonEnums,
        JsonIntEnums,
        RecursiveShapes,
        JsonLists,
        SparseJsonLists,
        JsonMaps,
        SparseJsonMaps,
        JsonBlobs,

        // Documents
        DocumentType,
        DocumentTypeAsPayload,
        DocumentTypeAsMapValue,

        // Unions
        JsonUnions,
        PostPlayerAction,
        PostUnionWithJsonName,

        // @endpoint and @hostLabel trait tests
        EndpointOperation,
        EndpointWithHostLabelOperation,

        // custom endpoints with paths
        HostWithPathOperation,

        // checksum(s)
        HttpChecksumRequired,

        // request body and content-type handling
        TestBodyStructure,
        TestPayloadStructure,
        TestPayloadBlob,
        TestNoPayload,

        // client-only timestamp parsing tests
        DatetimeOffsets,
        FractionalSeconds,

        // requestCompression trait tests
        PutWithContentEncoding
    ]
}
