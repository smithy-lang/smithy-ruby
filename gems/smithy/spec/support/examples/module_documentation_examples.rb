# frozen_string_literal: true

RSpec.shared_examples 'gem module documentation' do |context|
  context 'documentation' do
    include_context context, 'Documentation'

    let(:module_name) { "documentation#{'-schema' if context.include?('schema')}" }

    def assert(expected)
      module_file = File.join(@plan.destination_root, 'lib', "#{module_name}.rb")
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
