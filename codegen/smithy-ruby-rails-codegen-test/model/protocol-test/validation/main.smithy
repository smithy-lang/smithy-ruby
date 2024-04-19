$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson.validation

use smithy.ruby.protocols#railsJson

/// A REST JSON service that sends JSON requests and responses with validation applied
@railsJson
service RailsJsonValidation {
    version: "2021-08-19",
    operations: [
        MalformedEnum,
        MalformedLength,
        MalformedLengthOverride,
        MalformedLengthQueryString,
        MalformedPattern,
        MalformedPatternOverride,
        MalformedRange,
        MalformedRangeOverride,
        MalformedRequired,
        MalformedUniqueItems,
        RecursiveStructures,
        SensitiveValidation
    ]
}
