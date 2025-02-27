# Smithy Ruby

[Smithy](https://awslabs.github.io/smithy/) SDK code generator for Ruby.

**WARNING: This branch is under active development.  All interfaces are subject to change.**

For previous pre-release, Java based Smithy-Ruby, see: [smithy-ruby/main](https://github.com/smithy-lang/smithy-ruby/tree/main)

[![License][apache-badge]][apache-url]

[apache-badge]: https://img.shields.io/badge/License-Apache%202.0-blue.svg

## Helpful Commands

### Smithy Build
local build using smithy cli
```
bundle exec smithy build --debug model/weather.smithy
```

local build using smithy-ruby executable:
```
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith client --gem-name weather --gem-version 1.0.0 --destination-root projections/weather <<< $(smithy ast model/weather.smithy)
```

### IRB
IRB on `weather` gem:
```
irb -I projections/weather/lib -I gems/smithy-client/lib -I gems/smithy-schema/lib -r weather
```

Create a Weather client:
```
protocol = Smithy::Client::Protocols::RPCv2.new
client = Weather::Client.new(endpoint: 'https://example.com', protocol: protocol)
client.get_city(city_id: '1')
client.get_current_time
```

### Fixtures

Build a fixture
```
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith client --gem-name fixture --gem-version 1.0.0 <<< $(cat gems/smithy/spec/fixtures/endpoints/default-values/model.json)
```

Sync and validate fixtures on smithy:
```
bundle exec rake smithy:sync-fixtures
bundle exec rake smithy:validate-fixtures
```

### Running tests on gems

To run tests on smithy gem:
```
bundle exec rake smithy:spec
```

To run tests on smithy-schema gem:
```
bundle exec rake smithy-schema:spec
```

To run tests on smithy-client gem:
```
bundle exec rake smithy-client:spec
```

To run RBS validation/tests on smithy gem:
```
bundle exec rake smithy:rbs
```

To run RBS validation/tests on smithy-schema gem:
```
bundle exec rake smithy-schema:rbs
```

To run RBS validation/tests on smithy-client gem:
```
bundle exec rake smithy-client:rbs
```
