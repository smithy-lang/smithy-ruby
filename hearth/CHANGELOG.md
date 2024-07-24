Unreleased Changes
------------------

* Issue - Remove `Struct` from generated Types, Config, and other places to allow for better RBS typing as well as less reserved words.
* Feature - Add `Hearth::Cbor.encode` and `Hearth::Cbor.decode`.
* Issue - Fix query param `to_s` for empty arrays.
* Feature - [Breaking Change] Add `config` to `Hearth::Context` and refactor `logger` and `interceptors` inside of it.
* Feature - [Breaking Change] Add `config` to `InterceptorContext` which contains the request config.
* Issue - Add custom `inspect` method to `Hearth::Client`.

1.0.0.pre3 (2024-05-01)
------------------

* Feature - Third initial public pre-release for Smithy Ruby SDKs.

1.0.0.pre2 (2023-12-19)
------------------

* Feature - Second initial public pre-release for Smithy Ruby SDKs.

1.0.0.pre1 (2022-01-10)
------------------

* Feature - Initial public pre-release for Smithy Ruby SDKs.