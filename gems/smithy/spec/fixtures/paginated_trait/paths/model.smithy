$version: "2"

namespace smithy.ruby.tests

service Example {
    version: "2019-06-27"
    operations: [GetFoos]
}

@readonly
@paginated(inputToken: "nextToken", outputToken: "result.nextToken",
           pageSize: "maxResults", items: "result.foos")
operation GetFoos {
    input: GetFoosInput,
    output: GetFoosOutput
}

@input
structure GetFoosInput {
    maxResults: Integer,
    nextToken: String
}

@output
structure GetFoosOutput {
    @required
    result: ResultWrapper
}

structure ResultWrapper {
    nextToken: String,

    @required
    foos: StringList,
}

list StringList {
    member: String
}
