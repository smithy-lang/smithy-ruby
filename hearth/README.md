# Hearth

## What is it
Hearth is a base dependency for Ruby SDK API Clients built by
[smithy-ruby][smithy-ruby] using a [Smithy][Smithy] model. Hearth provides an
implementation of the components necessary to make requests and handle responses
from a service. Hearth is only intended to be used with clients that were code
generated using smithy-ruby, but it may be used for any service client
implementation.

## Components
Hearth contains reusable components that are used by code generated Ruby SDKs.
Such components include, but are not limited to: transport clients, request and
response objects, middleware, serialization and deserialization helpers for JSON
and XML, error classes and parsers, stubbing modules, etc.

### Middleware
Hearth uses middleware to handle the request and response cycle for service
operations. Middleware is used for building requests, parsing responses, sending
requests, and everything in-between.

#### Interface
All middleware must conform to the same interface. Middleware must have an
`#initialize` method that takes `app` as a positional parameter and any number
of keyword arguments that the middleware will use. Middleware must also have a
`#call` method that takes `input` (a Struct) and `context` (`Hearth::Context`)
as positional parameters. The method must return the result of the next
middleware call (`@app.call(input, context)`) which ultimately handles an
`Output` object.

```ruby

def initialize(app, _some_option:)
   @app = app
   # ...
end

def call(input, context)
   # do a thing
   # inspect or modify input or context.request
   output = @app.call(input, context)
   # do another thing
   # inspect or modify output or context.response
   output
end
```

#### Context
Middleware shares a context object (`Hearth::Context`) which allows middleware
to share state. The context object contains a logger, the request, the response,
the operation name, and a metadata hash for arbitrary data.

#### List of Middleware

Hearth implements the following protocol agnostic Middleware interfaces:

* `Auth`: Resolves the auth scheme and the identity used for signing a request.
* `Build`: Populates a protocol specific request object using input with a
   builder class.
* `Endpoint`: Resolves the endpoint for the request using an endpoint resolver.
   The request may also be updated to have different headers and auth
   properties.
* `HostPrefix`: Prefixes the host with a label before sending the request.
* `Initialize`: No-op middleware that provides hooks into the request/response
   lifecycle.
* `Parse`: Populates the output using a protocol specific response object with
   both a data parser and error parser class.
* `Retry`: Retries any networking errors or modeled retry-able errors.
* `Send`: Handles sending a transport specific request and populating a
   transport specific response object using a client. It may also facilitate
   stubbing instead of sending a request.
* `Sign`: Signs the request using a signer class.
* `Validate`: Validates Ruby types from input against the modeled types using a
   validator class.

For HTTP, Hearth implements:

* `ContentLength` Sets the `Content-Length` header to the body's size.
* `ContentMD5` Calculates the MD5 hash of the body and sets the `Content-MD5`
   header.
* `RequestCompression` Compresses the body and sets the `Content-Encoding`
   header.

### Protocol Clients

#### HTTP
Hearth includes a basic HTTP client implemented on `Net::HTTP`. In Smithy
code generated clients, it is used by `Hearth::Middleware::Send` by default.
It can be configured to debug wire trace information using a configured logger,
as well as configure proxy and SSL related values.

#### HTTP 2
Not yet supported.

### Request and Response objects
Hearth includes request and response objects for protocols, such as
`Hearth::HTTP::Request` and `Hearth::HTTP::Response`. These objects contain
raw HTTP request and response information, such as a URL, headers, body, status,
etc.

### XML and JSON Protocols
Hearth includes serialization and deserialization helpers for JSON and XML
based protocols. `Hearth::JSON` can be used to dump and load JSON strings and
`Hearth::XML` can be used to build XML strings and parse XML documents.

### Stubbing
Hearth includes a `Hearth::Stubs` class that can hold stub data used by the
client's `stub_responses` method. The `stub_responses` method is defined in the
`Hearth::ClientStubs` module.

### Errors
Hearth defines a base `Hearth::ApiError` that can be inherited by protocol
specific errors such as `Hearth::HTTP::ApiError`. Code generated clients will
inherit from these protocol specific error classes.

## License

This project is licensed under the Apache-2.0 License.

<!--- Links -->
[smithy-ruby]: https://github.com/smithy-lang/smithy-ruby
[Smithy]: https://awslabs.github.io/smithy/
