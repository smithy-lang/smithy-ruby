## My Project

TODO: Fill this README out!

Be sure to:

* Change the title in this README
* Edit your repository description on GitHub

## License

This project is licensed under the Apache-2.0 License.

## Fixing issues
```
./gradlew --stop
```

## Testing

### Running codegen integration tests
Codegen integration tests are written as ruby rspec tests (under smithy-ruby-codegentest/integration-specs).  The gradle `:smithy-ruby-codegen-test:build` target will create a `sample_service_real` directory and copy the specs into it.  From that directory, run `rspec` (assuming you have required dependencies installed).

These tests run against the generated test sdk defined by the high-score model in the smithy-ruby-codegen-test project.

### Running seahorse unit tests.
Seahorse has a full suite of rspec tests which can be run from the seahorse directory with: `rspec`.

### Manual Testing
The `sample-service` directory defines a rails service that can be run with `rails s`.  You can then test manually by adding seahorse and the generated sdk client to your library path with:
```sh
irb -I 'seahorse/lib' -I 'sample_service_real/lib'
```

And test with:
```Ruby
require 'sample_service_real'

c = SampleService::Client.new(endpoint: 'http://127.0.0.1:3000')
c.get_high_score(id: '1')
```
