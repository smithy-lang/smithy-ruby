$version: "2.0"

namespace smithy.protocoltests.rpcv2Cbor
use smithy.ruby#skipTests

apply OperationWithDefaults @skipTests([
    { id: "RpcV2CborClientPopulatesDefaultValuesInInput", reason: "Incorrect body in protocol test. Patch: https://github.com/smithy-lang/smithy/pull/2320", type: "request" }
])
