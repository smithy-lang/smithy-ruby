$version: "2.0"

namespace smithy.ruby.tests

service ServiceWithNoAuth {
    version: "2020-01-29"
    operations: [
        OperationH
        OperationI
    ]
}

// This operation does not have the @auth trait and is bound to a service
// without auth. This operation does not support any authentication schemes.
operation OperationH {}

// This operation has the @optionalAuth trait and is bound to a service
// without auth. This operation does not support any authentication schemes.
@optionalAuth
operation OperationI {}