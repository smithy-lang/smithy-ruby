# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Synthetic Input and Output' do
  ['generated client gem',
   'generated schema gem',
   'generated client from source code',
   'generated schema from source code'].each do |context|
    context context do
      include_context context, 'SyntheticInputOutput'

      it 'creates synthetic input and output types' do
        expect(defined?(SyntheticInputOutput::Types::OperationInput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::OperationOutput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::Structure)).to be nil
      end

      it 'preserves input and output types on the operation with the input and output trait' do
        expect(defined?(SyntheticInputOutput::Types::OperationWithInputAndOutputTraitsInput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::OperationWithInputAndOutputTraitsOutput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::Structure)).to be nil
      end

      it 'handles naming conflicts by inserting Operation between the operation name and the suffix' do
        expect(defined?(SyntheticInputOutput::Types::OperationWithNamingConflictOperationInput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::OperationWithNamingConflictOperationOutput)).to_not be nil
        expect(defined?(SyntheticInputOutput::Types::Structure)).to be nil
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'SyntheticInputOutput'

      it 'assigns synthetic input and output shapes to the operation' do
        client = SyntheticInputOutput::Client.new
        operation = client.config.service.operation(:operation)
        expect(operation.input.shape.type).to eq(SyntheticInputOutput::Types::OperationInput)
        expect(operation.output.shape.type).to eq(SyntheticInputOutput::Types::OperationOutput)
      end

      it 'preserves input and output shapes on the operation with the input and output trait' do
        client = SyntheticInputOutput::Client.new
        operation = client.config.service.operation(:operation_with_input_and_output_traits)
        expect(operation.input.shape.type).to eq(SyntheticInputOutput::Types::OperationWithInputAndOutputTraitsInput)
        expect(operation.output.shape.type).to eq(SyntheticInputOutput::Types::OperationWithInputAndOutputTraitsOutput)
      end

      it 'handles naming conflicts by inserting Operation between the operation name and the suffix' do
        client = SyntheticInputOutput::Client.new
        operation = client.config.service.operation(:operation_with_naming_conflict)
        expect(operation.input.shape.type).to eq(SyntheticInputOutput::Types::OperationWithNamingConflictOperationInput)
        expect(operation.output.shape.type).to eq(SyntheticInputOutput::Types::OperationWithNamingConflictOperationOutput)
      end
    end
  end
end
