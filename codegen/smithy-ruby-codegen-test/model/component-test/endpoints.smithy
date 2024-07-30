// This file defines tests to ensure that implementations support the endpoint
// trait and other features that modify the host.

$version: "2.0"

namespace smithy.ruby.tests

use smithy.rules#contextParam
use smithy.rules#staticContextParams

@endpoint(hostPrefix: "foo.")
operation EndpointOperation {}

@suppress(["UnstableTrait"])
@endpoint(hostPrefix: "foo.{labelMember}.")
@staticContextParams(Dataplane: {value: true})
operation EndpointWithHostLabelOperation {
    input: EndpointWithHostLabelOperationInput,
}

structure EndpointWithHostLabelOperationInput {
    @required
    @hostLabel
    labelMember: String,
}

@suppress(["UnstableTrait"])
@staticContextParams(Dataplane: {value: true})
operation DataplaneEndpoint {}

operation ResourceEndpoint {
    input: ResourceEndpointInput
}

structure ResourceEndpointInput {
    @suppress(["UnstableTrait"])
    @required
    @contextParam(name: "ResourceUrl")
    resourceUrl: String,
}
