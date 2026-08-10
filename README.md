# Smithy Ruby

[Smithy](https://awslabs.github.io/smithy/) SDK code generator for Ruby.

**WARNING: This branch is under active development.  All interfaces are subject to change.**

For previous pre-release, Java based Smithy-Ruby, see: [smithy-ruby/main](https://github.com/smithy-lang/smithy-ruby/tree/caffeinated)

[![License][apache-badge]][apache-url]

[apache-badge]: https://img.shields.io/badge/License-Apache%202.0-blue.svg
[apache-url]: https://github.com/smithy-lang/smithy-ruby/blob/main/LICENSE

## Helpful Commands

### Building Projections

local build using smithy cli
```bash
cd projections && bundle exec smithy build --debug
```

local build using smithy-ruby executable:
```bash
cd projections && SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby bundle exec smithy-ruby smith client --gem-name weather --gem-version 1.0.0 --destination-root weather <<< $(smithy ast model/weather.smithy)
```

### IRB

IRB on `weather` gem:
```bash
irb -I projections/weather/lib -I gems/smithy-client/lib -I gems/smithy-schema/lib -I gems/smithy-cbor/lib -r weather
```

Create a Weather client:
```ruby
protocol = Smithy::Client::RpcV2Cbor.new
client = Weather::Client.new(stub_responses: true, protocol: protocol, endpoint: 'https://example.com')
client.get_city(city_id: '1')
client.get_current_time
```

### Test Data

#### Fixtures

Build a fixture
```bash
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith client --gem-name fixture --gem-version 1.0.0 <<< $(cat gems/smithy/spec/fixtures/endpoints/default-values/model.json)
```

Sync and validate fixtures on smithy (validation runs inline as part of sync):
```bash
bundle exec rake smithy:sync-fixtures
```

#### Protocol Tests

Sync protocol tests from the pinned `smithy-protocol-tests` Maven artifact:
```bash
bundle exec rake smithy:sync-protocol-tests
```
This does not fetch the latest upstream tests - it rebuilds from whatever version is pinned in `gems/smithy/spec/protocol_tests/smithy-build.json`. 

To pull in newer upstream protocol test cases, bump the version there first, e.g.:
```json
"maven": {
  "dependencies": [
    "software.amazon.smithy:smithy-protocol-traits:1.60.3",
    "software.amazon.smithy:smithy-protocol-tests:1.60.3"
  ]
}
```
Then, rerun `bundle exec rake smithy:sync-protocol-tests`. 

Available versions:
[smithy-protocol-tests on Maven Central](https://central.sonatype.com/artifact/software.amazon.smithy/smithy-protocol-tests/versions).

### Running Tests

#### Specs

To run tests on smithy gem:
```bash
bundle exec rake smithy:spec:unit
```

To run tests on smithy-schema, smithy-client, smithy-cbor, smithy-json, or smithy-xml gems:
```bash
bundle exec rake smithy-schema:spec
bundle exec rake smithy-client:spec
bundle exec rake smithy-cbor:spec
bundle exec rake smithy-json:spec
bundle exec rake smithy-xml:spec
```

#### RBS

To run RBS validation/tests on smithy gem (unit, endpoint provider, and protocol test specs):
```bash
bundle exec rake smithy:rbs
```

To run RBS validation/tests on smithy-schema, smithy-client, smithy-cbor, smithy-json, or smithy-xml gems:
```bash
bundle exec rake smithy-schema:rbs
bundle exec rake smithy-client:rbs
bundle exec rake smithy-cbor:rbs
bundle exec rake smithy-json:rbs
bundle exec rake smithy-xml:rbs
```
