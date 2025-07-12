$version: "2.0"

namespace smithy.ruby.tests

@mixin
@internal
resource MixinResource {}

resource MixedResource with [MixinResource] {}
