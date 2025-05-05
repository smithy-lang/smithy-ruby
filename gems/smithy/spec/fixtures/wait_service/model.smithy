$version: "2"

namespace smithy.ruby.tests

use smithy.waiters#waitable

service WaitService {
    version: "2022-11-30",
    operations: [GetOperation]
}

@waitable(
    SuccessMatcher: {
        documentation: "Acceptor matches on successful request"
        acceptors: [
            {
                state: "success"
                matcher: {
                    success: true
                }
            }
        ]
    }
)
operation GetOperation {
    input: OperationInput,
    output: OperationOutput
    errors: [MyError]
}

structure OperationInput {
    stringProperty: String
    stringArrayProperty: StringArray
    booleanProperty: Boolean
    booleanArrayProperty: BooleanArray
    children: ChildArray
    dataMap: DataMap
}

structure OperationOutput {
    stringProperty: String
    stringArrayProperty: StringArray
    booleanProperty: Boolean
    booleanArrayProperty: BooleanArray
    children: ChildArray
    dataMap: DataMap
}

structure DeletedWidgetOutput {
    stringProperty: String
}

structure Child {
    grandchildren: GrandchildArray
}

structure Grandchild {
    name: String
    number: Integer
}

list StringArray{
    member: String
}

list BooleanArray{
    member: Boolean
}

list ChildArray {
    member: Child
}

list GrandchildArray {
    member: Grandchild
}

map DataMap {
    key: String
    value: String
}

@error("client")
structure MyError {
    message: String
}
