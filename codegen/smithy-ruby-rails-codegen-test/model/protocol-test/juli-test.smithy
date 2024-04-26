$version: "2.0"

namespace smithy.ruby.protocoltests.railsjson

@http(method: "POST", uri: "/some_operation")
operation SomeOperation {
    input: SomeOperationInputOutput,
    output: SomeOperationInputOutput
}

structure SomeOperationInputOutput {
    @deprecated
    some_enum: Suit

}

enum Suit {
    DIAMOND = "DIAMOND"
    CLUB = "CLUB"
    HEART = "HEART"
    SPADE = "SPADE"
}