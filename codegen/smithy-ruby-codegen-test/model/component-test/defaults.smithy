$version: "1.0"
namespace smithy.ruby.tests

operation DefaultsTest {
    input: DefaultsTestInputOutput,
    output: DefaultsTestInputOutput,
}

structure DefaultsTestInputOutput {
    // simple member
    String: String,

    // boxed
    boxedNumber: BoxedInteger,

    // members with defaults (unboxed)
    defaultNumber: DefaultInteger,
    defaultBool: DefaultBool
}

integer DefaultInteger
boolean DefaultBool

@box
integer BoxedInteger