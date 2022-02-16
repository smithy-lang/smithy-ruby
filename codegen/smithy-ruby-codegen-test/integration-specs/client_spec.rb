# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do

    describe '#initialize' do
      let(:logger) { double('logger') }
      it 'sets member values' do
        client = Client.new(
          endpoint: 'endpoint',
          http_wire_trace: true,
          log_level: :debug,
          logger: logger,
          stub_responses: true,
          validate_input: false
        )
        expect(client.instance_variable_get('@endpoint')).to eq('endpoint')
        expect(client.instance_variable_get('@http_wire_trace')).to eq(true)
        expect(client.instance_variable_get('@log_level')).to eq(:debug)
        expect(client.instance_variable_get('@logger')).to eq(logger)
        expect(client.instance_variable_get('@stub_responses')).to eq(true)
        expect(client.instance_variable_get('@validate_input')).to eq(false)
      end
    end

    describe '#kitchen_sink' do
      let(:logger) { Logger.new($stdout) }

      it 'uses validate_input from initialize' do
        client = Client.new(validate_input: false, stub_responses: true)
        expect(Hearth::Middleware::Validate)
          .to receive(:new)
                .with(anything, validator: Validators::KitchenSinkInput, validate_input: false)
                .and_call_original

        client.kitchen_sink
      end

      it 'uses validate_input from options' do
        client = Client.new(stub_responses: true)
        expect(Hearth::Middleware::Validate)
          .to receive(:new)
                .with(anything, validator: Validators::KitchenSinkInput, validate_input: false)
                .and_call_original

        client.kitchen_sink({}, validate_input: false)
      end

      it 'uses http_wire_trace from initialize' do
        client = Client.new(http_wire_trace: true, stub_responses: true)
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(http_wire_trace: true))
                .and_call_original

        client.kitchen_sink
      end

      it 'uses http_wire_trace from options' do
        client = Client.new(stub_responses: true)
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(http_wire_trace: true))
                .and_call_original

        client.kitchen_sink({}, http_wire_trace: true)
      end

      it 'uses logger' do
        client = Client.new(logger: logger, stub_responses: true)
        expect(Hearth::HTTP::Client)
          .to receive(:new)
                .with(hash_including(logger: logger))
                .and_call_original

        expect(Hearth::Context)
          .to receive(:new)
                .with(hash_including(logger: logger))
                .and_call_original

        client.kitchen_sink
      end

      context 'block is provided' do
        let(:block_io) { double("BlockIO") }
        it 'creates and uses a blockIO as the body' do
          client = Client.new(stub_responses: true)

          expect(Hearth::BlockIO).to receive(:new).and_return(block_io)

          expect(Hearth::HTTP::Response)
            .to receive(:new)
                  .with(hash_including(body: block_io))
                  .and_call_original

          client.kitchen_sink { |resp| resp }
        end
      end

      context 'output_stream is set' do
        let(:output_stream) { double("OutputStream") }
        it 'uses the output_stream as the body' do
          client = Client.new(stub_responses: true)

          expect(Hearth::HTTP::Response)
            .to receive(:new)
                  .with(hash_including(body: output_stream))
                  .and_call_original

          client.kitchen_sink({}, output_stream: output_stream)
        end
      end
    end
  end
end
