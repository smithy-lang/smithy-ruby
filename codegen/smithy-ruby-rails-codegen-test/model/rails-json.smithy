$version: "1.0"
namespace smithy.ruby.protocols

// The protocol definition
@protocolDefinition
@trait(selector: "service")
structure railsJson {
    // errorLocation property allows for configuring how errors are determined.
    errorLocation: ErrorLocation
}

// Handles Rails' accepts_nested_attributes_for
// https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
@trait(selector: "member")
structure nestedAttributes {}

// Configurable error locations.
// Status code - Reads HTTP status code and raises an error from a pre-defined map.
// Header - Raise the error from a specified header key
@enum([
    {
        value: "status_code",
        name: "STATUS_CODE"
    },
    {
        value: "header",
        name: "HEADER"
    }
])
string ErrorLocation

// Soft mapping of possible rails status codes to error shapes
// https://github.com/rails/rails/blob/2dfd4fcd73ae7c4b40114f2447c7ef9d4c0790b4/guides/source/layouts_and_rendering.md?plain=1#L337-L411

@error("client")
@httpError(404)
structure NotFoundError {}

@error("client")
@httpError(422)
structure UnprocessableEntityError {
    @httpPayload
    errors: AttributeErrors
}

map AttributeErrors {
    key: String,
    value: ErrorMessages
}

list ErrorMessages {
    member: String
}
