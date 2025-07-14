$version: "2.0"

namespace smithy.ruby.tests

@httpBasicAuth
@httpDigestAuth
@httpBearerAuth
@auth([httpBasicAuth, httpDigestAuth])
service ServiceWithAuthTrait {
    version: "2020-01-29"
    operations: [
        OperationC
        OperationD
        OperationE
    ]
}

// This operation does not have the @auth trait and is bound to a service
// with the @auth trait. The effective set of authentication schemes it
// supports are: httpBasicAuth, httpDigestAuth
operation OperationC {}

// This operation has the @auth trait and is bound to a service
// with the @auth trait. The effective set of authentication schemes it
// supports are: httpBearerAuth
@auth([httpBearerAuth])
operation OperationD {}

// This operation has the @auth trait and is bound to a service with the
// @auth trait. This operation does not support any authentication schemes.
@auth([])
operation OperationE {}