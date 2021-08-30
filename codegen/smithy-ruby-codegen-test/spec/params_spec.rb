$LOAD_PATH.unshift File.expand_path('../../../seahorse/lib', __dir__)
require 'seahorse'

# The module name is not yet defined, so need to use string
describe 'Params' do

  before :all do
    puts "Running before all!"
    model =  <<-EOF
$version: "1.0"
namespace example.rails

use smithy.rails#RailsJson
use smithy.rails#errorOn

/// Rails High Score example from their generator docs
@RailsJson
@errorOn(location: "header", name: "x-smithy-error")
service SampleService {
    version: "2021-02-15",
    operations: [Operation1],
}

@http(method: "PUT", uri: "/operation1/{id}")
operation Operation1 {
    input: Operation1Input,
    output: Operation1Output
}

structure Operation1Input {
    @required
    @httpLabel
    id: String,
    simpleList: SimpleList
}

structure Operation1Output {
  simpleList: SimpleList
}

list SimpleList {
    member: String
}
    EOF

    smithy_build = <<-EOF
{
  "version": "1.0",
  "plugins": {
    "ruby-codegen": {
      "service": "example.rails#SampleService",
      "module": "SampleService",
      "gemspec": {
        "gemName": "sample_service",
        "gemVersion": "0.0.1",
        "gemSummary": "Sample Rails Service"
      }
    }
  }
}
    EOF

    File.open('model/spec_model.smithy', 'w') { |file| file.write(model) }
    File.open('smithy-build.json', 'w') { |file| file.write(smithy_build) }

    puts "Wrote files, generating SDK...."
    Dir.chdir('../') do
      res = `./gradlew :smithy-ruby-codegen-test:build --info`
      puts "Finished building"
    end
    # TODO: These all need to be unique namespace/location to allow for multiple tests...
    $LOAD_PATH.unshift File.expand_path('../build/smithyprojections/smithy-ruby-codegen-test/source/ruby-codegen/sample_service/lib', __dir__)
    require 'sample_service'

  end

  it 'runs' do
    puts SampleService::Types::Operation1Input
  end

  describe 'SimpleList' do
    it 'raises when not an array' do
      expect do
        SampleService::Params::SimpleList.build({}, context: 'params')
      end.to raise_error(ArgumentError, 'Expected params to be in [Array], got Hash.')
    end

    it 'builds all of the members' do
      shape = SampleService::Params::SimpleList.build(['a', 'b', 'c'], context: 'params')
      expect(shape).to be_a(Array)
      expect(shape).to eq ['a', 'b', 'c']
    end
  end
end