// This file defines tests to ensure that implementations support the endpoint
// trait and other features that modify the host.

$version: "2.0"

namespace smithy.ruby.tests

use smithy.rules#contextParam
use smithy.rules#staticContextParams

@endpoint(hostPrefix: "foo.")
@http(method: "POST", uri: "/endpoint")
operation Endpoint {}

@suppress(["UnstableTrait"])
@staticContextParams(Dataplane: {value: true})
@http(method: "POST", uri: "/dataplane_endpoint")
operation DataplaneEndpoint {}

@http(method: "POST", uri: "/resource_endpoint")
operation ResourceEndpoint {
    input: ResourceEndpointInput
}

structure ResourceEndpointInput {
    @suppress(["UnstableTrait"])
    @required
    @contextParam(name: "ResourceUrl")
    resourceUrl: String,
}

@suppress(["UnstableTrait"])
@endpoint(hostPrefix: "foo.{labelMember}.")
@staticContextParams(Dataplane: {value: true})
@http(method: "POST", uri: "/host_label_endpoint")
operation HostLabelEndpoint {
    input: HostLabelEndpointInput,
}

structure HostLabelEndpointInput {
    @required
    @hostLabel
    labelMember: String,
}
