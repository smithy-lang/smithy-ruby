# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:config) { Config.new(stub_responses: true) }
    let(:client) { Client.new(config) }

    describe '#kitchen_sink' do
      it 'uses validate_input' do
        expect(Hearth::Middleware::Validate)
          .to receive(:new)
                .with(anything, validate_input: config.validate_input, validator: anything)
                .and_call_original

        client.kitchen_sink
      end

      it 'uses retry_strategy' do
        expect(Hearth::Middleware::Retry)
          .to receive(:new)
                .with(anything,
                      retry_strategy: instance_of(Hearth::Retry::Standard),
                      error_inspector_class: anything)
                .and_call_original

        client.kitchen_sink
      end

      it 'uses logger' do
        expect(Hearth::Context)
          .to receive(:new)
                .with(hash_including(logger: instance_of(Logger)))
                .and_call_original

        client.kitchen_sink
      end

      it 'uses endpoint from config' do
        expect(Hearth::HTTP::Request)
          .to receive(:new)
                .with(hash_including(uri: URI(config.endpoint)))
                .and_call_original

        client.kitchen_sink
      end

      it 'uses endpoint from options' do
        expect(Hearth::HTTP::Request)
          .to receive(:new)
                .with(hash_including(uri: URI('endpoint')))
                .and_call_original

        client.kitchen_sink({}, endpoint: 'endpoint')
      end
    end
  end
end
