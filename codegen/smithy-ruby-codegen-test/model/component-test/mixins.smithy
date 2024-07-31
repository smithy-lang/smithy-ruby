$version: "2.0"

namespace smithy.ruby.tests

operation MixinTest {
    // The generated shape name is GetUserInput
    input := {
        userId: String
    }

    // The generated shape name is GetUserOutput
    output := {
        username: String
        userId: String
    }
}
