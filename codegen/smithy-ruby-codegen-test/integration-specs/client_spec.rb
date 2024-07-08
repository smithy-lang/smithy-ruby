# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses: true) }

    it 'uses logger' do
      expect(client.config.logger)
        .to receive(:debug)
        .with(anything)
        .at_least(:once)
      expect(client.config.logger)
        .to receive(:info)
        .with(anything)
        .at_least(:once)

      client.kitchen_sink
    end

    it 'validates config' do
      expect do
        Client.new(stub_responses: 'false')
      end.to raise_error(ArgumentError, /config\[:stub_responses\]/)
    end

    context 'global config' do
      after { Hearth.config = {} }

      it 'allows for global configuration' do
        logger = Logger.new(IO::NULL, level: :debug)
        Hearth.config[:logger] = logger
        expect(client.config.logger).to eq(logger)
      end

      it 'validates global config values' do
        Hearth.config[:logger] = 'logger'
        expect do
          Client.new
        end.to raise_error(ArgumentError, /config\[:logger\]/)
      end

      it 'is overridden by client config' do
        Hearth.config[:logger] = Logger.new(IO::NULL, level: :debug)
        logger = Logger.new(IO::NULL, level: :info)
        client = Client.new(logger: logger)
        expect(client.config.logger).to eq(logger)
      end
    end

    context 'operation overrides' do
      it 'validates config' do
        expect do
          client.kitchen_sink({}, endpoint: 1)
        end.to raise_error(ArgumentError, /config\[:endpoint\]/)
      end

      it 'uses config from options' do
        operation_config = { endpoint: 'https://example.com' }
        expect_any_instance_of(Config).to receive(:freeze)
        expect_any_instance_of(Config)
          .to receive(:merge).with(operation_config)
          .and_call_original
        client.kitchen_sink({}, operation_config)
      end

      it 'raises when given stubs or stub responses' do
        expect do
          client.kitchen_sink({}, stub_responses: true)
        end.to raise_error(ArgumentError, /stubs or stub_responses/)
      end
    end
  end
end
