$version: "2.0"

namespace smithy.ruby.tests

@paginated(inputToken: "inputToken", outputToken: "outputToken", pageSize: "pageSize")
service PaginatedService {
    operations: [
      InheritedTraitOperation,
      MergedTraitOperation
    ]
}

operation InheritedTraitOperation {
    input: OperationInputOutput
    output: OperationInputOutput
}

@paginated(inputToken: "outputToken", outputToken: "inputToken", items: "items")
operation MergedTraitOperation {
    input: OperationInputOutput
    output: OperationInputOutput
}

structure OperationInputOutput {
    inputToken: String
    outputToken: String
    pageSize: Integer
    items: Items
}

list Items {
    member: String
}
