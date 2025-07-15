$version: "2.0"

namespace smithy.ruby.tests

service RenameShapes {
    operations: [Operation]
    rename: {
        "smithy.ruby.tests#OperationInput": "RenamedOperationInput",
        "smithy.ruby.tests#OperationOutput": "RenamedOperationOutput",
        "smithy.ruby.tests#Structure": "RenamedStructure"
    }
}

operation Operation {
    input: OperationInput
    output: OperationOutput
}

@input
structure OperationInput {}

@output
structure OperationOutput {
    structure: Structure
}

structure Structure {
    nested: Structure
}
