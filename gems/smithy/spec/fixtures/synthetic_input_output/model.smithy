$version: "2"

namespace smithy.ruby.tests

service SyntheticInputOutput {
    operations: [
        Operation,
        OperationWithInputAndOutputTraits,
        OperationWithNamingConflict
    ]
}

operation Operation {
    input: Structure
    output: Structure
}

structure Structure {
    member: String
}

operation OperationWithInputAndOutputTraits {
    input: OperationWithInputAndOutputTraitsInput
    output: OperationWithInputAndOutputTraitsOutput
}

@input
structure OperationWithInputAndOutputTraitsInput {
    member: String
}

@output
structure OperationWithInputAndOutputTraitsOutput {
    member: String
}

operation OperationWithNamingConflict {
    input: OperationWithNamingConflictInput
    output: OperationWithNamingConflictOutput
}

structure OperationWithNamingConflictInput {
    member: String
}

structure OperationWithNamingConflictOutput {
    member: String
}
