# frozen_string_literal: true

require_relative 'spec_helper'
require 'webmock/rspec'

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
        expect { client.telemetry_test }.not_to raise_error
      end
    end

    context 'otel provider' do
      let(:otel_provider) { Hearth::Telemetry::OTelProvider.new }
      let(:otel_export) { OpenTelemetry::SDK::Trace::Export }
      let(:otel_exporter) { otel_export::InMemorySpanExporter.new }
      let(:otel_config_setup) do
        processor = otel_export::SimpleSpanProcessor.new(otel_exporter)
        OpenTelemetry::SDK.configure do |c|
          c.add_span_processor(processor)
        end
      end
      let(:client) { Client.new(telemetry_provider: otel_provider) }
      let(:expected_operation_attributes) do
        {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'TelemetryTest',
          'code.function' => 'telemetry_test',
          'code.namespace' => 'WhiteLabel::Client'
        }
      end
      let(:expected_send_attributes) do
        {
          'http.method' => 'POST',
          'net.protocol.name' => 'http',
          'net.protocol.version' => '1.1',
          'net.peer.name' => 'whitelabel.com',
          'net.peer.port' => 443,
          'http.status_code' => 200
        }
      end
      let(:body) { 'AAAAA' }

      it 'raises error when an otel dependency was not required' do
        allow(Hearth::Telemetry).to receive(:otel_loaded?).and_return(false)
        expect { otel_provider }
          .to raise_error(
            ArgumentError,
            'Requires the `opentelemetry-sdk` gem to use OTel Provider.'
          )
      end

      it 'creates spans with all the supplied parameters' do
        stub_request(:post, 'https://whitelabel.com')
        otel_config_setup
        client.telemetry_test
        expect(otel_exporter.finished_spans.count).to eq(2)

        pp otel_exporter.finished_spans
        child_span = otel_exporter.finished_spans[0]
        parent_span = otel_exporter.finished_spans[1]
        expect(child_span.name).to eq('Middleware.Send')
        expect(child_span.attributes).to eq(expected_send_attributes)
        expect(child_span.kind).to eq(:internal)
        expect(parent_span.name).to eq('WhiteLabel.TelemetryTest')
        expect(parent_span.attributes).to eq(expected_operation_attributes)
        expect(parent_span.kind).to eq(:client)
        expect(child_span.parent_span_id).to eq(parent_span.span_id)
      end

      it 'applies content-length span attributes when applicable' do
        stub_request(:post, 'https://whitelabel.com')
          .to_return(
            status: 200,
            body: body,
            headers: { 'Content-Length' => body.size }
          )

      end

      it 'populates span data with error when it occurs' do
      end


      context 'stub' do
        it '' do

        end
      end
    end
  end
end

