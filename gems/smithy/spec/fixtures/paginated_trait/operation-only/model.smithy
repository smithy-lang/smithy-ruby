$version: "2.0"

namespace smithy.ruby.tests

service PaginatedService {
    operations: [
      PaginatedOperation,
      UnpaginatedOperation
    ]
}

@paginated(inputToken: "inputToken", outputToken: "outputToken")
operation PaginatedOperation {
    input: OperationInputOutput
    output: OperationInputOutput
}

operation UnpaginatedOperation {
    input: OperationInputOutput
    output: OperationInputOutput
}

structure OperationInputOutput {
    inputToken: String
    outputToken: String
}
