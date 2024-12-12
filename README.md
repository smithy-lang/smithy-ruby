# TODO

## Helpful Commands

Run `smithy` gem tests:
```
bundle exec rake smithy:spec
```

Run `smithy-client` gem tests:
```
bundle exec rake smithy-client:spec
```

Local build using Smithy CLI:
```
bundle exec smithy build --debug model/weather.smithy
```

Local build using smithy-ruby executable:
```
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith types --gem-name some_organization-weather --gem-version 1.0.0 <<< $(smithy ast model/weather.smithy)
```

IRB on `weather` gem:
```
irb -I build/smithy/source/smithy-ruby/lib -I gems/smithy-client/lib -r weather
```