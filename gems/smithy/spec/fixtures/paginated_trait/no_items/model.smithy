$version: "2"

namespace smithy.ruby.tests

service Example {
    version: "2019-06-27"
    operations: [GetFoos]
}

@readonly
@paginated(inputToken: "nextToken", outputToken: "nextToken",
           pageSize: "maxResults")
operation GetFoos {
    input: GetFoosInput
    output: GetFoosOutput
}

@input
structure GetFoosInput {
    maxResults: Integer
    nextToken: String
}

@output
structure GetFoosOutput {
    nextToken: String

    @required
    foos: StringList
}

list StringList {
    member: String
}
