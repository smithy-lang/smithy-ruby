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

      before do
        processor = otel_export::SimpleSpanProcessor.new(otel_exporter)
        OpenTelemetry::SDK.configure do |c|
          c.add_span_processor(processor)
        end
      end

      let(:client) do
        Client.new(
          telemetry_provider: otel_provider,
          retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
        )
      end

      let(:body) { 'AAAAA' }
      let(:finished_send_span) do
        otel_exporter
          .finished_spans
          .find { |span| span.name == 'Middleware.Send' }
      end

      let(:finished_op_span) do
        otel_exporter
          .finished_spans
          .find { |span| span.name == 'WhiteLabel.TelemetryTest' }
      end

      let(:expected_op_attrs) do
        {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'TelemetryTest',
          'code.function' => 'telemetry_test',
          'code.namespace' => 'WhiteLabel::Client'
        }
      end

      let(:expected_send_attrs) do
        {
          'http.method' => 'POST',
          'net.protocol.name' => 'http',
          'net.protocol.version' => '1.1',
          'net.peer.name' => 'whitelabel.com',
          'net.peer.port' => 443,
          'http.status_code' => 200
        }
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
        stub_request(:post, 'https://whitelabel.com')
        client.telemetry_test

        expect(finished_send_span).not_to be_nil
        expect(finished_op_span).not_to be_nil
        expect(finished_send_span.attributes).to eq(expected_send_attrs)
        expect(finished_op_span.attributes).to eq(expected_op_attrs)
        expect(finished_send_span.kind).to eq(:internal)
        expect(finished_op_span.kind).to eq(:client)
        expect(finished_send_span.parent_span_id)
          .to eq(finished_op_span.span_id)
      end

      it 'applies content-length span attributes when applicable' do
        stub_request(:post, 'https://whitelabel.com')
          .to_return(
            body: body,
            headers: { 'Content-Length' => body.size }
          )
        # these span attributes should exist when content-length is in the headers
        expected_send_attrs['http.request_content_length'] = body.size.to_s
        expected_send_attrs['http.response_content_length'] = body.size.to_s
        client.telemetry_test(body: body)

        expect(finished_send_span.attributes).to eq(expected_send_attrs)
      end

      it 'populates span data with error when it occurs' do
        stub_request(:post, 'https://whitelabel.com')
          .to_return(status: 500)
        begin
          client.telemetry_test
        rescue StandardError
          # Ignored
        end
        # TODO: need to update span to record_exceptions
      end

      context 'stub_responses' do
        let(:finished_stub_span) do
          otel_exporter
            .finished_spans
            .find { |span| span.name == 'Middleware.Stub' }
        end

        let(:expected_stub_attrs) do
          {
            'http.method' => 'POST',
            'net.protocol.name' => 'http',
            'net.protocol.version' => '1.1',
            'net.peer.name' => 'localhost',
            'net.peer.port' => 80,
            'http.status_code' => 200
          }
        end

        it 'creates a stub span with all the supplied parameters' do
          client = Client.new(
            stub_responses: true,
            telemetry_provider: otel_provider
          )
          client.telemetry_test
          expect(finished_stub_span).not_to be_nil
          expect(finished_stub_span.attributes).to eq(expected_stub_attrs)
          expect(finished_stub_span.kind).to eq(:internal)
          expect(finished_stub_span.parent_span_id)
            .to eq(finished_op_span.span_id)
        end
      end
    end
  end
end
