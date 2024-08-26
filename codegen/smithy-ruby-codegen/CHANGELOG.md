Unreleased Changes
------------------

* Issue - Make generated Errors module transport agnostic.
* Feature - Add support for Event Streams.
* Issue - Add `to_s` to `Structure`.
* Issue - Remove `Struct` from generated Types, Config, and other places to allow for better RBS typing as well as less reserved words.
* Feature - Add support for stringArray Endpoint parameters + operationContextParams binding.
* Issue - Update reserved member names for new Struct methods.
* Feature - Add support for Smithy RPC v2 CBOR protocol.
* Issue - Use `strict_encode64` instead of `encode64`.
* Issue - Fix builders when `uri` contains empty query parameter.
* Issue - Resolve `ClientConfig` from integrations first.
* Issue - Rename config `defaults` method to avoid name conflicts.
* Issue - Add support for skipping error tests.
* Feature - [Breaking Change] Add `config` to `Hearth::Context` and refactor `logger` and `interceptors` inside of it.
* Issue - Fix issue in `GenerationContext` where Endpoint built-ins were added as config.

0.3.0 (2024-05-01)
------------------

* Feature - Third initial public pre-release for Smithy Ruby SDKs.

0.2.0 (2023-12-18)
------------------

* Feature - Second initial public pre-release for Smithy Ruby SDKs.

0.1.0 (2022-01-10)
------------------

* Feature - Initial public pre-release for Smithy Ruby SDKs.