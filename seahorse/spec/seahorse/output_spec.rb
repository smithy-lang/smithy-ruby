# frozen_string_literal: true

module Seahorse
  describe Output do
    let(:error) { StandardError.new }
    let(:data) { double('Struct') }

    subject { Output.new(error: error, data: data) }

    describe '#initialize' do
      it 'sets empty defaults' do
        output = Output.new
        expect(output.error).to be_nil
        expect(output.data).to be_nil
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
  end
end
