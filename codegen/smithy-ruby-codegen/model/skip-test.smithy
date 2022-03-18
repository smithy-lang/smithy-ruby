$version: "1.0"
namespace smithy.ruby

@trait(selector: "operation")
structure skipTest {
    id: String,
    reason: String
}
