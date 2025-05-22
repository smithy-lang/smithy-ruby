$version: "2"

namespace smithy.ruby.tests

use smithy.waiters#waitable
use smithy.protocols#rpcv2Cbor

@rpcv2Cbor
service WaiterService {
    version: "2022-11-30",
    operations: [GetOperation]
}

@waitable(
    SuccessMatcher: {
        documentation: "Acceptor matches on successful request"
        acceptors: [
            {
                state: "success"
                matcher: {
                    success: true
                }
            }
        ]
    }
)
operation GetOperation {
    input: OperationInput,
    output: OperationOutput
}

structure OperationInput {
    stringProperty: String
}

structure OperationOutput {
    stringProperty: String
}