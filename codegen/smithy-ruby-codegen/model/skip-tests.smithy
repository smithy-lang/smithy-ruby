$version: "1.0"
namespace smithy.ruby

@trait(selector: "operation")
list skipTests {
    member: skipTest
}

structure skipTest {
    id: String,
    reason: String
}
