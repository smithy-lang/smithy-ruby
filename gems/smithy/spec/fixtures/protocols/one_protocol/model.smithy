$version: "2"

namespace smithy.ruby.tests

@trait
@protocolDefinition
structure fakeProtocol {}

@fakeProtocol
service ProtocolService {}
