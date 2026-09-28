# Smithy Ruby

[Smithy](https://awslabs.github.io/smithy/) SDK code generator for Ruby.

**WARNING: This branch is under active development.  All interfaces are subject to change.**

For previous pre-release, Java based Smithy-Ruby, see: [smithy-ruby/main](https://github.com/smithy-lang/smithy-ruby/tree/caffeinated)

[![License][apache-badge]][apache-url]

[apache-badge]: https://img.shields.io/badge/License-Apache%202.0-blue.svg
[apache-url]: https://github.com/smithy-lang/smithy-ruby/blob/main/LICENSE

## Protocol Tests

### Syncing Tests

Sync protocol tests from the pinned `smithy-protocol-tests` Maven artifact:

```bash
bundle exec rake smithy:sync-protocol-tests
```

This does not fetch the latest upstream tests. It rebuilds from the version pinned in `gems/smithy/spec/protocol_tests/smithy-build.json`.

To pull in newer upstream protocol test cases, update the dependency versions there first, for example:

```json
{
  "maven": {
    "dependencies": [
      "software.amazon.smithy:smithy-protocol-traits:1.73.0",
      "software.amazon.smithy:smithy-protocol-tests:1.73.0"
    ]
  }
}
```

Then rerun:

```bash
bundle exec rake smithy:sync-protocol-tests
```

Available versions are published on [Maven Central](https://central.sonatype.com/artifact/software.amazon.smithy/smithy-protocol-tests/versions).

### Running Protocol Tests

Run the generated protocol-test suite with:

```bash
bundle exec rake smithy:spec:protocols
```

## Common Tasks

### Building Projections

Build the local projections using the Smithy CLI:

```bash
cd projections && bundle exec smithy build --debug
```

Build the Weather projection using the `smithy-ruby` executable:

```bash
cd projections && SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby bundle exec smithy-ruby smith client --gem-name weather --gem-version 1.0.0 --destination-root weather <<< $(smithy ast model/weather.smithy)
```

### Using the Weather Client in IRB

Load the generated Weather gem:

```bash
irb -I projections/weather/lib -I gems/smithy-client/lib -I gems/smithy-schema/lib -I gems/smithy-cbor/lib -r weather
```

Create a client:

```ruby
protocol = Smithy::Client::RpcV2Cbor.new
client = Weather::Client.new(stub_responses: true, protocol: protocol, endpoint: 'https://example.com')
client.get_city(city_id: '1')
client.get_current_time
```

### Updating Test Fixtures

Build a fixture:

```bash
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith client --gem-name fixture --gem-version 1.0.0 <<< $(cat gems/smithy/spec/fixtures/endpoints/default-values/model.json)
```

Sync and validate the fixtures:

```bash
bundle exec rake smithy:sync-fixtures
```

### Running Specs

Run the `smithy` gem unit specs:

```bash
bundle exec rake smithy:spec:unit
```

Run specs for the runtime gems:

```bash
bundle exec rake smithy-schema:spec
bundle exec rake smithy-client:spec
bundle exec rake smithy-cbor:spec
bundle exec rake smithy-json:spec
bundle exec rake smithy-xml:spec
```

### Running RBS Validation

Run all `smithy` gem RBS validation, including unit, endpoint provider, and protocol-test specs:

```bash
bundle exec rake smithy:rbs
```

Run RBS validation for the runtime gems:

```bash
bundle exec rake smithy-schema:rbs
bundle exec rake smithy-client:rbs
bundle exec rake smithy-cbor:rbs
bundle exec rake smithy-json:rbs
bundle exec rake smithy-xml:rbs
```
