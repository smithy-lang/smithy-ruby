# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Module' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_examples 'gem module', context
    end
  end

  context 'documentation trait' do
    include_context 'generated client gem', 'Documentation'

    def assert(expected)
      module_file = File.join(@plan.destination_root, 'lib', 'documentation.rb')
      expect(expected).to be_in_documentation(module_file, 'Documentation')
    end

    it 'generates title documentation' do
      expected = <<~DOC
        @title Documentation Test
      DOC
      assert(expected)
    end

    it 'generates module documentation' do
      expected = <<~DOC
        Service documentation
      DOC
      assert(expected)
    end

    it 'generates deprecated documentation' do
      expected = <<~DOC
        @deprecated
          Deprecated service
          Since: 1.0
      DOC
      assert(expected)
    end

    it 'generates external documentation links' do
      expected = <<~DOC
        @see https://www.example.com/ Service link
      DOC
      assert(expected)
    end

    it 'generates since documentation' do
      expected = <<~DOC
        @since 1.0
      DOC
      assert(expected)
    end

    it 'generates unstable documentation' do
      expected = <<~DOC
        @note This shape is unstable and may change in future releases.
      DOC
      assert(expected)
    end
  end
end
