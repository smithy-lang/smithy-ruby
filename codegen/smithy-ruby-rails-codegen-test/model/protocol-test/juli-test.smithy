$version: "2.0"
namespace smithy.ruby.protocoltests.railsjson

@http(uri: "/HeaderListOperation", method: "POST")
operation HeaderListOperation {
    input: HeaderListOperationInput
}

structure HeaderListOperationInput {
    @httpHeader("X-StringList")
    headerStringList: MyStringList,
}

list MyStringList {
    member: MyString,
}

string MyString


//@http(method: "POST", uri: "/some_operation")
//operation EnumOperation {
//    input: EnumOperationInput
//}
//
//structure EnumOperationInput {
//    some_enum: Suit,
//}
//
//enum Suit {
//    DIAMOND = "DIAMOND",
//    CLUB = "CLUB",
//    HEART = "HEART",
//    SPADE = "SPADE"
//}