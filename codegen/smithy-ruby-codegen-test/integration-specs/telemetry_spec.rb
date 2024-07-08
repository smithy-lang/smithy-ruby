# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Config do
    context 'telemetry_provider' do
      it 'raises error when given an invalid input' do
        expect { Config.new(telemetry_provider: 'foo').validate! }
          .to raise_error(
            ArgumentError,
            'Expected config[:telemetry_provider] to be in ' \
            '[Hearth::Telemetry::TelemetryProvider], got String.'
          )
      end

      it 'does not raise error when given an otel provider' do
        otel_provider = Hearth::Telemetry::OTelProvider.new
        expect { Config.new(telemetry_provider: otel_provider).validate! }
          .not_to raise_error
      end

      it 'does not raise error when given a custom provider' do
        custom_provider = Hearth::Telemetry::TelemetryProvider.new(
          tracer_provider: Hearth::Telemetry::NoOpTracerProvider.new,
          context_manager: Hearth::Telemetry::NoOpContextManager.new
        )
        expect { Config.new(telemetry_provider: custom_provider).validate! }
          .not_to raise_error
      end



    end
  end





end