$version: "2"

namespace example.plugins

service Plugins {
    operations: [HTTPOperation]
}

@http(method: "GET", uri: "/")
operation HTTPOperation {}
