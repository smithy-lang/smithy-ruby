# frozen_string_literal: true

RSpec.shared_examples 'types module documentation' do |context|
  context 'documentation' do
    include_context context, 'Documentation'

    let(:module_name) { "documentation#{'-schema' if context.include?('schema')}" }
    let(:types_file) { File.join(@plan.destination_root, 'lib', module_name, 'types.rb') }

    context 'structures' do
      def assert(expected)
        expect(expected).to be_in_documentation(types_file, 'Documentation::Types::Structure')
      end

      it 'generates deprecated documentation' do
        expected = <<~DOC
          @deprecated
            Deprecated structure
            Since: 1.0
        DOC
        assert(expected)
      end

      it 'generates documentation' do
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

      it 'generates unstable documentation' do
        expected = <<~DOC
          @note This shape is unstable and may change in future releases.
        DOC
        assert(expected)
      end

      it 'generates attribute documentation' do
        expected = <<~DOC
          @!attribute documented_member
            Structure member documentation
            @deprecated
              Deprecated structure member
              Since: 2.0
            @see https://www.example.com/ Structure member link
            @note
              This shape is recommended
              Reason: This is recommended
            @since 2.0
            @note This shape is unstable and may change in future releases.
            @return [String]
          @!attribute undocumented_member
            Shape documentation
            @return [String]
        DOC
        assert(expected)
      end
    end

    context 'unions' do
      def assert(expected)
        expect(expected).to be_in_documentation(types_file, 'Documentation::Types::Union')
      end

      it 'generates deprecated documentation' do
        expected = <<~DOC
          @deprecated
            Deprecated union
            Since: 1.0
        DOC
        assert(expected)
      end

      it 'generates documentation' do
        expected = <<~DOC
          Union documentation
        DOC
        assert(expected)
      end

      it 'generates external documentation links' do
        expected = <<~DOC
          @see https://www.example.com/ Union link
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

      it 'generates unstable documentation' do
        expected = <<~DOC
          @note This shape is unstable and may change in future releases.
        DOC
        assert(expected)
      end

      it 'generates attribute documentation' do
        expected = <<~DOC
          @!attribute documented_member
            Union member documentation
            @deprecated
              Deprecated union member
              Since: 2.0
            @see https://www.example.com/ Union member link
            @since 2.0
            @note This shape is unstable and may change in future releases.
            @return [String]
          @!attribute undocumented_member
            Shape documentation
            @return [String]
        DOC
        assert(expected)
      end
    end
  end
end
