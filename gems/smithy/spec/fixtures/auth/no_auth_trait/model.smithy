$version: "2"

namespace smithy.ruby.tests

@httpBasicAuth
@httpDigestAuth
@httpBearerAuth
service ServiceWithNoAuthTrait {
    version: "2020-01-29"
    operations: [
        OperationA
        OperationB
    ]
}

// This operation does not have the @auth trait and is bound to a service
// without the @auth trait. The effective set of authentication schemes it
// supports are: httpBasicAuth, httpDigestAuth and httpBearerAuth
operation OperationA {}

// This operation does have the @auth trait and is bound to a service
// without the @auth trait. The effective set of authentication schemes it
// supports are: httpDigestAuth.
@auth([httpDigestAuth])
operation OperationB {}
