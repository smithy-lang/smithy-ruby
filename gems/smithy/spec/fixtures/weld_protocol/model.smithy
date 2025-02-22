$version: "2"

namespace smithy.ruby.tests

@trait
@protocolDefinition
structure weldProtocol {}

@weldProtocol
service WeldProtocolService {}
