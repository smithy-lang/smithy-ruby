# TODO

helpful commands

run tests:
`bundle exec rake smithy:spec`

local build using smithy cli
`bundle exec smithy build --debug model/weather.smithy`

local build using smithy-ruby executable
```
export SMITHY_PLUGIN_DIR=build/smithy/source/smithy-ruby
bundle exec smithy-ruby smith types --gem-name some_organization-weather --gem-version 1.0.0 <<< $(smithy ast model/weather.smithy)
```

IRB on weather gem
```
irb -I build/smithy/weather/smithy-ruby/lib -I gems/smithy-client/lib -r weather
```