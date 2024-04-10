# Smithy Ruby

[Smithy](https://awslabs.github.io/smithy/) SDK code generators for Ruby and
SDK core libraries.

**WARNING: All interfaces are subject to change.**

[![License][apache-badge]][apache-url]

[apache-badge]: https://img.shields.io/badge/License-Apache%202.0-blue.svg
[apache-url]: LICENSE

## Generating an SDK for a [Rails JSON](https://github.com/smithy-lang/smithy-ruby/wiki/Rails-JSON-Protocol) API

### Using Smithy CLI (recommended)

1. [Install Smithy CLI](https://smithy.io/2.0/guides/smithy-cli/cli_installation.html)
2. Add your smithy model under `<project_root>/model`.
3. Create a [smithy-build.json](https://smithy.io/2.0/guides/smithy-build-json.html) file
   that defines how Smithy should build your SDK. It must define a section under `plugins` for `ruby-codegen`.
   It must also add a maven dependencies block and depend on `software.amazon.smithy.ruby:smithy-ruby-rails-codegen` or `software.amazon.smithy.ruby:smithy-ruby-codegen`.
   For reference see: [rails json test smithy-build.json](https://github.com/smithy-lang/smithy-ruby/blob/main/codegen/smithy-ruby-rails-codegen-test/smithy-build.json).
4. Run `smithy build`

### Using Gradle

Instead of the Smithy CLI, you can instead create a gradle project. Doing so allows further customization of the build process if necessary, or implementing your own protocol.

1. Create a new gradle project
2. Add smithy to the plugins list (Note, you can find the latest plugin version at: https://plugins.gradle.org/plugin/software.amazon.smithy)
```kotlin
plugins {
    id("software.amazon.smithy").version("0.6.0")
}
```
3. Add the smithy-ruby-rails-codegen as a dependency:
```kotlin
dependencies {
    implementation("software.amazon.smithy.ruby:smithy-ruby-rails-codegen:0.2.0")
}
```
4. Add your smithy model under `<project_root>/model`.
5. Create a [smithy-build.json](https://smithy.io/2.0/guides/smithy-build-json.html) file
   that defines how Smithy should build your SDK. It must define a section under `plugins` for `ruby-codegen`.
   For reference see: [rails json test smithy-build.json](https://github.com/smithy-lang/smithy-ruby/blob/main/codegen/smithy-ruby-rails-codegen-test/smithy-build.json).
6. Execute the gradle `build` task.
   This will generate the SDK from your model using the settings from your smithy-build.json file.  
   The generated SDK will be available under the build/smithyprojections/<project_name>/<service-name>/ruby-codegen folder.

## Using the SDK

For an overview of SDK features, see the wiki: https://github.com/smithy-lang/smithy-ruby/wiki

## License

This project is licensed under the Apache-2.0 License.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

### Troubleshooting

Many Gradle issues can be fixed by stopping the daemon by running `./gradlew --stop`

### Testing
There is a top level `Rakefile` that defines tasks for testing, checking style and checking types for both Hearth and all parts of the codgen.

To run all checks and validations on all sub-projects run:

```
bundle exec rake
```

Or to run checks on the individual projects:

```
bundle exec rake check:hearth
bundle exex rake check:codegen
```

#### Setup/Dependencies
Java 17 is required to run gradle and the smithy/java based code generation.  The `Rakefile` provides tasks for running codegeneration using gradle and it will verify that the correct version of java is configured.  To setup java, either set the `JAVA_HOME` on the environment or use [jenv](https://www.jenv.be) to manage versions.

You will also need to run `bundle install` from the top level directory.

#### Running codegen integration tests
Codegen integration tests are written as ruby rspec tests (under smithy-ruby-codegentest/integration-specs).  

You can run all codegen integration tests with:

```
bundle exec rake codegen:build # runs build on codegen first
bundle exec rake test:white_label 
```

#### Running hearth unit tests.
Hearth has a full suite of rspec tests which can be run from the hearth directory with: `rspec`. Or by running `bundle exec rake test:hearth` from the top level directory.

#### Manual Testing
The `sample-service` directory defines a rails service that can be run with `rails s`.  You can then test manually by adding hearth and the generated sdk client to your library path with:
```sh
irb -I 'hearth/lib' -I 'codegen/projections/high_score_service/lib'
```

And test with:
```Ruby
require 'high_score_service'

c = HighScoreService::Client.new(endpoint: 'http://127.0.0.1:3000')
c.get_high_score(id: '1')
```
