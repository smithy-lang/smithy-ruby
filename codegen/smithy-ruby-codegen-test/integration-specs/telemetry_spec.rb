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

  describe Client do
    context 'no-op telemetry provider' do
      let(:client) { Client.new(stub_responses: true) }

      it 'does not raise error when calling an operation' do
        expect { client.kitchen_sink }.not_to raise_error
      end
    end

    context 'otel provider' do
      let(:otel_provider) { Hearth::Telemetry::OTelProvider.new }
      let(:client) { Client.new(stub_responses: true, telemetry_provider: otel_provider) }
      let(:otel_exporter) { OpenTelemetry::SDK::Trace::Export::InMemorySpanExporter.new }
      let(:otel_config_setup) do
        otel_span_processor = OpenTelemetry::SDK::Trace::Export::SimpleSpanProcessor.new(otel_exporter)
        OpenTelemetry::SDK.configure do |c|
          c.add_span_processor(otel_span_processor)
        end
      end

      it 'raises error when an otel dependency was not required' do
        allow(Hearth::Telemetry).to receive(:otel_loaded?).and_return(false)
        expect { otel_provider }
          .to raise_error(
            ArgumentError,
            'Requires the `opentelemetry-sdk` gem to use OTel Provider.'
          )
      end

      it 'creates spans with all the supplied parameters' do
        expected_attributes = {
          'rpc.service'=> 'WhiteLabel',
          'rpc.method'=> 'KitchenSink',
          'code.function'=> 'kitchen_sink',
          'code.namespace'=> 'WhiteLabel::Client'
        }
        otel_config_setup
        client.kitchen_sink
        expect(otel_exporter.finished_spans[0].name).to eq('WhiteLabel.KitchenSink')
        expect(otel_exporter.finished_spans[0].attributes).to eq(expected_attributes)
        expect(otel_exporter.finished_spans[0].kind).to eq(:client)
      end
    end
  end
end
