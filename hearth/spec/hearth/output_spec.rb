# frozen_string_literal: true

module Hearth
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
  end
end
