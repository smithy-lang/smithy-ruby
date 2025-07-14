$version: "2.0"

namespace smithy.ruby.tests

@mixin
list MyMixin {
    /// Generic docs
    member: String
}

list MyList with [MyMixin] {}
apply MyList$member @documentation("Specific docs")
