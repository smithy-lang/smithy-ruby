# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Config do
    describe '#build' do
      it 'sets member values' do
        config_keys = {
          disable_host_prefix: true,
          endpoint: 'test',
          http_client: Hearth::HTTP::Client.new,
          log_level: :debug,
          logger: Logger.new($stdout, level: :debug),
          retry_strategy: Hearth::Retry::Adaptive.new,
          stub_responses: false,
          validate_input: false
        }

        config = Config.new(**config_keys)

        config_keys.each do |key, value|
          expect(config.send(key)).to eq(value)
        end
      end

      it 'uses defaults' do
        config = Config.new
        expect(config.logger).to be_a(Logger)
        expect(config.logger.info?).to be true
      end

      it 'validates types' do
        expect { Config.new(logger: 'foo') }
          .to raise_error(ArgumentError, /options\[:logger\]/)
      end
    end
  end
end
