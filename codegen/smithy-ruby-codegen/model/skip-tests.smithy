$version: "1.0"
namespace smithy.ruby

@trait(selector: "operation")
list skipTests {
    member: skipTest
}

structure skipTest {
    id: String,
    reason: String,
    type: TestType
}
@enum([
    {
        value: "request",
        name: "REQUEST"
    },
    {
        value: "response",
        name: "RESPONSE"
    }
])
string TestType
