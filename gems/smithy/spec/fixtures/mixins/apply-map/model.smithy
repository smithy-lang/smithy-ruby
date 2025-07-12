$version: "2.0"

namespace smithy.ruby.tests

@mixin
map MyMixin {
    /// Generic docs
    key: String
    /// Generic docs
    value: String
}

map MyMap with [MyMixin] {}
apply MyMap$key @documentation("Specific docs")
apply MyMap$value @documentation("Specific docs")
