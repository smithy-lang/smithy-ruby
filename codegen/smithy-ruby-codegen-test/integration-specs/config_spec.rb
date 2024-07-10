# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Config do
    describe '#initialize' do
      it 'sets member values' do
        config_keys = {
          disable_host_prefix: true,
          endpoint: 'test',
          http_client: Hearth::HTTP::Client.new,
          logger: Logger.new($stdout),
          retry_strategy: Hearth::Retry::Adaptive.new,
          stub_responses: true,
          validate_input: false,
          telemetry_provider: Hearth::Telemetry::NoOpTelemetryProvider.new
        }
        config = Config.new(**config_keys)

        config_keys.each do |key, value|
          expect(config.send(key)).to eq(value)
        end
      end

      it 'uses defaults' do
        config = Config.new
        expect(config.interceptors).to be_a(Hearth::InterceptorList)
        expect(config.logger).to be_a(Logger)
        expect(config.plugins).to be_a(Hearth::PluginList)
        expect(config.request_min_compression_size_bytes).to be_a(Integer)
        expect(config.telemetry_provider)
          .to be_a(Hearth::Telemetry::TelemetryProvider)
      end

      it 'validates types' do
        config = Config.new(logger: 'foo')
        expect { config.validate! }
          .to raise_error(ArgumentError, /config\[:logger\]/)
      end

      it 'raises on unknown keys' do
        expect { Config.new(foo: 'bar') }
          .to raise_error(ArgumentError, /unknown keywords: foo/)
      end
    end
  end
end
