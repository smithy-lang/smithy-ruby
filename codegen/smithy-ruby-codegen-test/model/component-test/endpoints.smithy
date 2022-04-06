// This file defines tests to ensure that implementations support the endpoint
// trait and other features that modify the host.

$version: "1.0"

namespace smithy.ruby.tests

@endpoint(hostPrefix: "foo.")
operation EndpointOperation {}

@endpoint(hostPrefix: "foo.{labelMember}.")
operation EndpointWithHostLabelOperation {
    input: HostLabelInput,
}

structure HostLabelInput {
    @required
    @hostLabel
    labelMember: String,
}