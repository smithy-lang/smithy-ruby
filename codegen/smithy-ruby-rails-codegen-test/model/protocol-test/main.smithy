$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson

use smithy.test#httpRequestTests
use smithy.test#httpResponseTests

@railsJson(errorLocation: "header")
@title("RailsJson Protocol Test Service")
service RailsJson {
    version: "2018-01-01",
    // Ensure that generators are able to handle renames.
    rename: {
        "aws.protocoltests.restjson.nested#GreetingStruct": "RenamedGreeting",
    },
    operations: [
        KitchenSinkOperation,
        EndpointOperation,
        EndpointWithHostLabelOperation,
        EmptyOperation,
        JsonEnums,
        GreetingWithErrors,
        OperationWithOptionalInputOutput,
        NullOperation,
        JsonUnions,
        JsonMaps,
        DocumentType,
        DocumentTypeAsPayload,
        InputAndOutputWithHeaders,
        NullAndEmptyHeadersClient,
        TimestampFormatHeaders,
        MediaTypeHeader,
        HttpRequestWithLabels,
        HttpRequestWithFloatLabels,
        HttpRequestWithLabelsAndTimestampFormat,
        HttpRequestWithGreedyLabelInPath,
        HttpPayloadTraits,
        HttpPayloadTraitsWithMediaType,
        HttpPayloadWithStructure,
        HttpPrefixHeaders,
        HttpPrefixHeadersInResponse,
        AllQueryStringTypes,
        ConstantQueryString,
        ConstantAndVariableQueryString,
        IgnoreQueryParamsInResponse,
        OmitsNullSerializesEmptyString,
        QueryParamsAsStringListMap,
        QueryIdempotencyTokenAutoFill,
        HttpResponseCode,
        __789BadName,
        NestedAttributesOperation,
        StreamingOperation
    ],
}

structure EmptyStruct {}

structure SimpleStruct {
    Value: String,
}

structure StructWithLocationName {
    @jsonName("RenamedMember")
    Value: String,
}

list ListOfListOfStrings {
    member: ListOfStrings,
}

list ListOfMapsOfStrings {
    member: MapOfStrings,
}

list ListOfStrings {
    member: String,
}

list ListOfStructs {
    member: SimpleStruct,
}

map MapOfListsOfStrings {
    key: String,
    value: ListOfStrings,
}

map MapOfMapOfStrings {
    key: String,
    value: MapOfStrings,
}

map MapOfStrings {
    key: String,
    value: String,
}

map MapOfStructs {
    key: String,
    value: SimpleStruct,
}

@mediaType("application/json")
string JsonValue