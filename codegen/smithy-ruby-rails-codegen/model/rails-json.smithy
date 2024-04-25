$version: "2.0"
namespace smithy.ruby.protocols

// The protocol definition
@protocolDefinition
@trait(selector: "service")
structure railsJson {
    // If set, will use this header key to determine the error class, instead of
    // the status code and a pre-defined map..
    errorHeader: String
}

// Handles Rails' accepts_nested_attributes_for
// https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
@trait(selector: "member")
structure nestedAttributes {}

// Soft mapping of possible rails status codes to structured error shapes.
// Modeled errors exist to parse information from the body or headers.

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
