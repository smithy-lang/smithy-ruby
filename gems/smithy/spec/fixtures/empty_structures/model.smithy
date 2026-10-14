$version: "2.0"

namespace smithy.ruby.tests

use smithy.rules#endpointRuleSet

@endpointRuleSet({
    version: "1.0",
    parameters: {},
    rules: [{
        conditions: [],
        type: "endpoint",
        endpoint: {url: "https://example.com"}
    }]
})
service EmptyStructures {
    version: "1.0"
    operations: [Operation]
}

operation Operation {
    input: Populated
    output: Empty
}

structure Populated {
    value: String
}

structure Empty {}
