// This file defines tests to ensure that implementations support the endpoint
// trait and other features that modify the host.

$version: "1.0"

namespace smithy.ruby.protocoltests.railsjson

use smithy.ruby.protocols#railsJson
use smithy.test#httpRequestTests

@httpRequestTests([
    {
        id: "RailsJsonEndpointTrait",
        documentation: """
                Operations can prepend to the given host if they define the
                endpoint trait.""",
        protocol: railsJson,
        method: "POST",
        uri: "/endpoint",
        host: "example.com",
        resolvedHost: "foo.example.com",
    }
])
@http(method: "POST", uri: "/endpoint")
@endpoint(hostPrefix: "foo.")
operation EndpointOperation {}


@httpRequestTests([
    {
        id: "RailsJsonEndpointTraitWithHostLabel",
        documentation: """
                Operations can prepend to the given host if they define the
                endpoint trait, and can use the host label trait to define
                further customization based on user input.""",
        protocol: railsJson,
        method: "POST",
        uri: "/endpointwithhostlabel",
        body: "{\"label\": \"bar\"}",
        bodyMediaType: "application/json",
        host: "example.com",
        resolvedHost: "foo.bar.example.com",
        params: {
            label: "bar",
        },
    }
])
@http(method: "POST", uri: "/endpointwithhostlabel")
@endpoint(hostPrefix: "foo.{label}.")
operation EndpointWithHostLabelOperation {
    input: HostLabelInput,
}

structure HostLabelInput {
    @required
    @hostLabel
    label: String,
}