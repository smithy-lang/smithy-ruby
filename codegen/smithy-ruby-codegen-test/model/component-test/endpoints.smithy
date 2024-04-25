// This file defines tests to ensure that implementations support the endpoint
// trait and other features that modify the host.

$version: "2.0"

namespace smithy.ruby.tests

use smithy.rules#contextParam
use smithy.rules#staticContextParams

@endpoint(hostPrefix: "foo.")
@http(method: "POST", uri: "/endpoint_operation")
operation EndpointOperation {}

@suppress(["UnstableTrait"])
@staticContextParams(Dataplane: {value: true})
@http(method: "POST", uri: "/dataplane_operation")
operation DataplaneOperation {}

@http(method: "POST", uri: "/endpoint_operation_with_resource")
operation EndpointOperationWithResource {
    input: EndpointResourceInput
}

structure EndpointResourceInput {
    @suppress(["UnstableTrait"])
    @required
    @contextParam(name: "ResourceUrl")
    resourceUrl: String,
}

@suppress(["UnstableTrait"])
@endpoint(hostPrefix: "foo.{labelMember}.")
@staticContextParams(Dataplane: {value: true})
@http(method: "POST", uri: "/endpoint_operation_with_host_label")
operation EndpointWithHostLabelOperation {
    input: HostLabelInput,
}

structure HostLabelInput {
    @required
    @hostLabel
    labelMember: String,
}