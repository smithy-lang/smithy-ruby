# frozen_string_literal: true

require 'seahorse/output'

module Seahorse
  describe Output do
    let(:error) { StandardError.new }
    let(:data) { double('Struct') }
    let(:context) { { key: 'value' } }

    subject { Output.new(error: error, data: data, context: context) }

    describe '#initialize' do
      it 'sets empty defaults' do
        output = Output.new
        expect(output.error).to be_nil
        expect(output.data).to be_nil
        expect(output.context).to eq({})
      end
    end

    describe '#error' do
      it 'gets the error field' do
        expect(subject.error).to be error
      end
    end

    describe '#data' do
      it 'gets the data field' do
        expect(subject.data).to be data
      end
    end

    describe '#context' do
      it 'gets the context field' do
        expect(subject.context).to be context
      end
    end
  end
end
