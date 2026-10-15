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
      "software.amazon.smithy:smithy-protocol-traits:1.74.0",
      "software.amazon.smithy:smithy-protocol-tests:1.74.0"
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

## Development Setup

All gems support Ruby 3.1 or newer. CI runs specs on Ruby 3.1, 3.2, 3.3, 3.4, 4.0, and JRuby 9.4/10.0. Use a Ruby version supported by your installed development tools. CI uses Ruby 4.0 for RBS and lint checks.

Work from a source checkout. The root Gemfile loads the generator and runtime gems together from this repository. Run setup and Rake commands from the repository root.

### Full Setup

Using a Ruby version compatible with the installed RBS and other development dependencies, install the full bundle and external RBS signatures:

```bash
bundle install
bundle exec rbs collection install
```

### Specs on Ruby 3.1 or JRuby

For spec-only work, you can skip the RBS group when installing dependencies, as CI does. The Gemfile constrains RDoc below 8 on JRuby, so local installs and CI use the same dependency constraint.

```bash
bundle config set --local without rbs
bundle install
```

This setting is saved in `.bundle/config` and also applies to subsequent test commands. To run RBS checks, use a Ruby version supported by the RBS tools and restore the full bundle:

```bash
bundle config unset --local without
unset BUNDLE_WITHOUT
bundle install
bundle exec rbs collection install
```

### Smithy CLI

Install Smithy CLI 1.74.0, the version used by CI, to build projections or sync fixtures and upstream protocol tests. Existing checked-in JSON models can be used to run specs without syncing them first.

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

Run the generator unit, endpoint, and protocol suites, plus all runtime suites. `CI=true` includes the slow client tests that are skipped by default locally:

```bash
CI=true bundle exec rake smithy:spec smithy-schema:spec smithy-client:spec smithy-cbor:spec smithy-json:spec smithy-xml:spec
```

Run only the `smithy` gem unit specs:

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

### Running Lint

Run lint from the repository root:

```bash
bundle exec rake rubocop
```

### Running RBS Validation

Run RBS checks on one compatible Ruby version in your development environment, using the full setup above, including `rbs collection install`. CI uses Ruby 4.0, but local checks do not require that exact version. These checks validate type signatures; the spec matrix checks compatibility across supported Ruby versions.

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
