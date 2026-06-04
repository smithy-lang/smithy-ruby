# frozen_string_literal: true

require_relative '../spec_helper'

context 'Renamed Shapes' do
  ['generated client gem',
   'generated schema gem',
   'generated client from source code',
   'generated schema from source code'].each do |context|
    context context do
      include_context context, 'RenameShapes'

      it 'renames type classes' do
        expect(defined?(RenameShapes::Types::RenamedStructure)).to_not be nil
        expect(defined?(RenameShapes::Types::Structure)).to be nil
      end

      it 'renames schema classes' do
        expect(defined?(RenameShapes::Schema::RenamedStructure)).to_not be nil
        expect(defined?(RenameShapes::Schema::Structure)).to be nil
      end

      it 'preserves the original shape id' do
        expect(RenameShapes::Schema::RenamedStructure.id).to eq('smithy.ruby.tests#Structure')
      end

      it 'renames type references in the schema' do
        expect(RenameShapes::Schema::RenamedStructure.type).to eq(RenameShapes::Types::RenamedStructure)
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'RenameShapes'

      it 'assigns renamed shapes to operation inputs and outputs' do
        client = RenameShapes::Client.new
        operation = client.config.service.operation(:operation)
        expect(operation.input.type).to eq(RenameShapes::Types::RenamedOperationInput)
        expect(operation.output.type).to eq(RenameShapes::Types::RenamedOperationOutput)
      end
    end
  end

  context 'generated client gem' do
    include_context 'generated client gem', 'RenameShapes'

    it 'includes renamed shapes in the types return documentation' do
      expected = <<~DOC
        @return [Types::RenamedStructure]
      DOC
      types_file = File.join(@plan.destination_root, 'lib', 'rename_shapes', 'types.rb')
      expect(expected).to be_in_documentation(types_file, 'RenameShapes::Types::RenamedStructure')
    end

    it 'includes renamed shapes in the operation param documentation' do
      expected = <<~DOC
        @param [Hash, Types::RenamedOperationInput] params
      DOC
      client_file = File.join(@plan.destination_root, 'lib', 'rename_shapes', 'client.rb')
      expect(expected).to be_in_documentation(client_file, 'RenameShapes::Client', method: 'operation')
    end

    it 'includes renamed shapes in the operation return documentation' do
      expected = <<~DOC
        @return [Types::RenamedOperationOutput]
      DOC
      client_file = File.join(@plan.destination_root, 'lib', 'rename_shapes', 'client.rb')
      expect(expected).to be_in_documentation(client_file, 'RenameShapes::Client', method: 'operation')
    end
  end

  context 'generated schema gem' do
    include_context 'generated schema gem', 'RenameShapes'

    it 'includes renamed shapes in the types documentation' do
      types_file = File.join(@plan.destination_root, 'lib', 'rename_shapes-schema', 'types.rb')
      expected = <<~DOC
        @!attribute nested
          @return [Types::RenamedStructure]
      DOC
      expect(expected).to be_in_documentation(types_file, 'RenameShapes::Types::RenamedStructure')
    end
  end
end
