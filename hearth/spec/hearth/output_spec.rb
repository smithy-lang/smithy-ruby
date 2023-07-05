# frozen_string_literal: true

module Hearth
  describe Output do
    let(:error) { StandardError.new }
    let(:data) { double('Struct') }
    let(:context) { double('Context') }
    let(:metadata) { {} }

    subject do
      Output.new(
        error: error, data: data, context: context, metadata: metadata
      )
    end

    describe '#initialize' do
      it 'sets empty defaults' do
        output = Output.new
        expect(output.error).to be_nil
        expect(output.data).to be_nil
        expect(output.context).to be_nil
        expect(output.metadata).to eq({})
      end

      it 'uses provided values' do
        expect(subject.error).to eq(error)
        expect(subject.data).to eq(data)
        expect(subject.context).to eq(context)
        expect(subject.metadata).to eq(metadata)
      end
    end
  end
end
