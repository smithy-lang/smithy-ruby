$version: "1.0"
namespace smithy.railsjson

@protocolDefinition(
    traits: [ ErrorName ]
)
@trait(selector: "service")
structure RailsJson { }

@trait(selector: "structure [trait|error]")
structure ErrorName {
    @required
    errorText: String
}

@trait(selector: "member")
structure NestedAttributes {
}