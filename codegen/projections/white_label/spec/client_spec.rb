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
                      retry_strategy: config.retry_strategy,
                      error_inspector_class: anything)
                .and_call_original

        client.kitchen_sink
      end

      it 'uses logger' do
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(logger: config.logger))
                .and_call_original

        expect(Hearth::Context)
          .to receive(:new)
                .with(hash_including(logger: config.logger))
                .and_call_original

        client.kitchen_sink
      end

      it 'uses http_wire_trace from config' do
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(http_wire_trace: config.http_wire_trace))
                .and_call_original

        client.kitchen_sink
      end

      it 'uses http_wire_trace from options' do
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(http_wire_trace: true))
                .and_call_original

        client.kitchen_sink({}, http_wire_trace: true)
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
