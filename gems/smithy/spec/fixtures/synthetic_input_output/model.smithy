$version: "2"

namespace smithy.ruby.tests

service ShapeService {
    operations: [
        Operation,
        OperationWithInputOutputTraits
    ]
}

operation Operation {
    input: Structure
    output: Structure
}

operation OperationWithInputOutputTraits {
    input: OperationInput
    output: OperationOutput
}

structure Structure {
    string: String
}

@input
structure OperationInput {
    string: String
}

@output
structure OperationOutput {
    string: String
}
