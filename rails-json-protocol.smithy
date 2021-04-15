$version: "1.0"
namespace smithy.rails

@trait(selector: "service")
structure RailsJson {}

@trait(selector: ":is(service,operation)")
structure errorOn {
    location: String,
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

// @trait(selector: "structure > member")
// structure NestedAttributes {}
