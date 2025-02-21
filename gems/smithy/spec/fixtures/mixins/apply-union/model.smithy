$version: "2"

namespace smithy.ruby.tests

@mixin
union MyMixin {
    /// Generic docs
    mixinMember: String
}

union MyUnion with [MyMixin] {}
apply MyUnion$mixinMember @documentation("Specific docs")
