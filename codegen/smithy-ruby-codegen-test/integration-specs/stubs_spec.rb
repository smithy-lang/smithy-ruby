# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses: true) }
    let(:stub_error) { StandardError.new('Stubbed error') }

    describe '#initialize' do
      it 'can configure stubs on initialize' do
        client = Client.new(
          stub_responses: true,
          stubs: Hearth::Stubs.new(kitchen_sink: [stub_error])
        )
        expect do
          client.kitchen_sink
        end.to raise_error(stub_error)
      end
    end

    describe '#stub_responses' do
      it 'can configure stubs with stub_responses' do
        client.stub_responses(:kitchen_sink, [stub_error])
        expect do
          client.kitchen_sink
        end.to raise_error(stub_error)
      end
    end

    describe '#kitchen_sink' do
      it 'configuring stubs on operations is not allowed' do
        expect do
          client.kitchen_sink({}, stubs: [stub_error])
        end.to raise_error(ArgumentError, /not allowed/)
      end
    end
  end
end
