# frozen_string_literal: true

module Hearth
  describe Output do
    let(:error) { StandardError.new }
    let(:data) { double('Struct') }
    let(:metadata) { {} }

    subject { Output.new(error: error, data: data, metadata: metadata) }

    describe '#initialize' do
      it 'sets empty defaults' do
        output = Output.new
        expect(output.error).to be_nil
        expect(output.data).to be_nil
        expect(output.metadata).to eq({})
      end

      it 'uses provided values' do
        expect(subject.error).to eq(error)
        expect(subject.data).to eq(data)
        expect(subject.metadata).to eq(metadata)
      end
    end
  end
end
