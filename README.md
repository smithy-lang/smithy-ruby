# Smithy Ruby

[Smithy](https://awslabs.github.io/smithy/) SDK code generators for Ruby and
SDK core libraries.

**WARNING: All interfaces are subject to change.**

[![License][apache-badge]][apache-url]

[apache-badge]: https://img.shields.io/badge/License-Apache%202.0-blue.svg
[apache-url]: LICENSE

## Generating an SDK for a [Rails JSON](https://github.com/awslabs/smithy-ruby/wiki/Rails-JSON-Protocol) API
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
    implementation("software.amazon.smithy.ruby:smithy-ruby-rails-codegen:0.1.0")
}
```
4. Add your smithy model. under `<project_root>/model`.
5. Create a [smithy-build.json](https://awslabs.github.io/smithy/1.0/guides/building-models/build-config.html) file
   that defines how Smithy should build your SDK. It must define a section under `plugins` for `ruby-codegen`. For
   reference see: [rails json test smithy-build.json](https://github.com/awslabs/smithy-ruby/blob/main/codegen/smithy-ruby-rails-codegen-test/smithy-build.json).

6. Execute the gradle `build` task.
   This will generate the SDK from your model using the settings from your
   smithy-build.json file.  
   The generated SDK will be available under the build/smithyprojections/<project_name>/<service-name>/ruby-codegen folder.

## License

This project is licensed under the Apache-2.0 License.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## Development

[Design Documentation (WIP)](https://github.com/awslabs/smithy-ruby/wiki)

### Troubleshooting

Many Gradle issues can be fixed by stopping the daemon by running `./gradlew --stop`

### Testing

#### Running codegen integration tests
Codegen integration tests are written as ruby rspec tests (under smithy-ruby-codegentest/integration-specs).  The gradle `:smithy-ruby-codegen-test:build` target will create a `sample_service_real` directory and copy the specs into it.  From that directory, run `rspec` (assuming you have required dependencies installed).

These tests run against the generated test sdk defined by the high-score model in the smithy-ruby-codegen-test project.

#### Running seahorse unit tests.
Seahorse has a full suite of rspec tests which can be run from the seahorse directory with: `rspec`.

#### Manual Testing
The `sample-service` directory defines a rails service that can be run with `rails s`.  You can then test manually by adding seahorse and the generated sdk client to your library path with:
```sh
irb -I 'seahorse/lib' -I 'sample_service/lib'
```

And test with:
```Ruby
require 'sample_service'

c = SampleService::Client.new(endpoint: 'http://127.0.0.1:3000')
c.get_high_score(id: '1')
```
