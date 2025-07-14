$version: "2.0"

namespace smithy.ruby.tests

operation OperationA {
    input: OperationAInput
    output: OperationAOutput
}

structure OperationAInput {}
structure OperationAOutput {}

@mixin
service A {
    version: "A"
    operations: [OperationA]
}

operation OperationB {
    input: OperationBInput
}

structure OperationBInput {}

@mixin
service B with [A] {
    version: "B"
    rename: {
        "smithy.ruby.tests#OperationAInput": "OperationARequest"
        "smithy.ruby.tests#OperationAOutput": "OperationAResult"
    }
    operations: [OperationB]
}

operation OperationC {}

service C with [B] {
    version: "C"
    rename: {
        "smithy.ruby.tests#OperationAOutput": "OperationAResponse"
        "smithy.ruby.tests#OperationBInput": "OperationBRequest"
    }
    operations: [OperationC]
}
