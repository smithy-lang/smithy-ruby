# Generating an example Rails JSON API SDK
Demo of Smithy Ruby generating a High Score Service, presented at Ruby Kaigi 2024

https://github.com/mullermp/rubykaigi2024

## Sample Service
The sample service lives in the `high_score_service` directory. The following commands will get the service running:

```
cd high_score_service
bundle install
rails s
```

Note: You may also need to run `rails db:migrate` if the db file has been purged.

## Install Smithy CLI

See: https://smithy.io/2.0/guides/smithy-cli/cli_installation.html

## Building the SDK

Running `smithy clean && smithy build` will build the SDK into a build folder using the `smithy-build.json` configuration.

## Install Dependencies

The SDK is powered by a core dependency called `hearth`. It is currently in pre-release status.

```
gem install hearth -v 1.0.0.pre2
```

## Run IRB

```
cd build/smithy/high-score-service/ruby-codegen/high_score_service/
irb -I lib/ -r high_score_service
```

## Demo!

You can create a Client and experiment with the features.

```
client = HighScoreService::Client.new(endpoint: 'http://127.0.0.1:3000')
# do more awesome stuff
```

For documentation on Smithy Ruby, see: https://github.com/smithy-lang/smithy-ruby/wiki
