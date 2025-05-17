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
    include_context 'generated client gem', 'Documentation'

    def assert(expected)
      types_file = File.join(@plan.destination_root, 'lib', 'documentation', 'types.rb')
      expect(expected).to be_in_documentation(types_file, 'Documentation::Types::OperationOutput')
    end

    it 'generates deprecated documentation' do
      expected = <<~DOC
        @deprecated
          Deprecated structure
          Since: 1.0
      DOC
      assert(expected)
    end

    it 'generates structure documentation' do
      expected = <<~DOC
        Structure documentation
      DOC
      assert(expected)
    end

    it 'generates external documentation links' do
      expected = <<~DOC
        @see https://www.example.com/ Structure link
      DOC
      assert(expected)
    end

    it 'generates sensitive documentation' do
      expected = <<~DOC
        @note This shape contains sensitive data and should be treated as such.
      DOC
      assert(expected)
    end

    it 'generates since documentation' do
      expected = <<~DOC
        @since 1.0
      DOC
      assert(expected)
    end

    it 'generates attribute documentation' do
      expected = <<~DOC
        @!attribute baz
          Member documentation
          @deprecated
            Deprecated structure member
            Since: 2.0
          @see https://www.example.com/ Member link
          @note
            This shape is recommended
            Reason: This is recommended
          @since 2.0
          @return [String]
        @!attribute bar
          Shape documentation
          @return [String]
        @!attribute qux
          @return [Types::Structure]
      DOC
      assert(expected)
    end
  end
end
