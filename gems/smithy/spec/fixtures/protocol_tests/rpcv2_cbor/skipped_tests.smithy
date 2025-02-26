$version: "2.0"

namespace smithy.protocoltests.rpcv2Cbor
use smithy.ruby#skipTests

apply OperationWithDefaults @skipTests([
  { id: "RpcV2CborClientPopulatesDefaultValuesInInput", reason: "Defaults not Implemented yet.", type: "request" }
  { id: "RpcV2CborClientPopulatesDefaultsValuesWhenMissingInResponse", reason: "Defaults not Implemented yet.", type: "response" }
])
//
//apply GreetingWithErrors @skipTests([
//  { id: "RpcV2CborComplexError", reason: "Error handling not Implemented yet.", type: "response" }
//  { id: "RpcV2CborEmptyComplexError", reason: "Error handling not Implemented yet.", type: "response" }
//  { id: "RpcV2CborInvalidGreetingError", reason: "Error handling not Implemented yet.", type: "response" }
//])
