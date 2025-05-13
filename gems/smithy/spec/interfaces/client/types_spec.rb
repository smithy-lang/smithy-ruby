# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Types', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_examples 'types module', context
    end
  end

  context 'documentation trait' do
    include_context 'generated client gem', 'DocumentationTrait'

    it 'generates type documentation' do
      expected = <<~DOC
        Structure documentation
        @!attribute baz
          Member documentation
          @return [String]
        @!attribute bar
          Shape documentation
          @return [String]
        @!attribute qux
          @return [String]
      DOC
      client_file = File.join(@plan.destination_root, 'lib', 'documentation_trait', 'types.rb')
      expect(expected).to be_in_documentation(client_file, 'DocumentationTrait::Types::OperationOutput')
    end
  end
end
