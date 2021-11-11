$version: "1.0"

namespace protocoltests.RailsJson

use smithy.rails#RailsJson
use smithy.rails#errorOn
use smithy.test#httpRequestTests
use smithy.test#httpResponseTests


@RailsJson
@title("Sample RailsJson Protocol Service")
service RailsJsonProtocol {
    version: "2018-01-01",
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
        PutAndGetInlineDocuments
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