$version: "1.0"
namespace smithy.rails

@protocolDefinition(
    traits: [ ErrorName ]
)
@trait(selector: "service")
structure RailsJson {}

@trait(selector: ":is(service,operation)")
structure errorOn {
    location: ErrorLocation,
    name: String
}
@enum([
    {
        value: "status_code",
        name: "STATUS_CODE"
    },
    {
        value: "header",
        name: "HEADER"
    },
    {
        value: "body",
        name: "BODY"
    }
])
string ErrorLocation


@trait(selector: "structure [trait|error]")
structure ErrorName {
    @required
    errorText: String
}

@trait(selector: "member")
structure NestedAttributes {}