$version: "2.0"

namespace smithy.ruby.tests

@mixin
structure MyMixin {
    /// Generic docs
    mixinMember: String
}

structure MyStruct with [MyMixin] {
    /// Specific docs
    mixinMember: String
}
