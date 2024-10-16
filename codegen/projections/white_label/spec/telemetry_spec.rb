# frozen_string_literal: true

require_relative 'spec_helper'
require 'webmock/rspec'
require 'opentelemetry-sdk'

module WhiteLabel
  describe Config do
    context 'telemetry_provider' do
      let(:custom_class) do
        Class.new(Hearth::Telemetry::TelemetryProviderBase)
      end

      let(:custom_provider) { custom_class.new }

      it 'raises error when given an invalid input', rbs_test: :skip do
        expect { Config.new(telemetry_provider: 'foo').validate! }
          .to raise_error(
            ArgumentError,
            'Expected config[:telemetry_provider] to be in ' \
            '[Hearth::Telemetry::TelemetryProviderBase], got String.'
          )
      end

      it 'does not raise error when given an otel provider' do
        otel_provider = Hearth::Telemetry::OTelProvider.new
        expect { Config.new(telemetry_provider: otel_provider).validate! }
          .not_to raise_error
      end

      it 'does not raise error when given a custom provider' do
        expect { Config.new(telemetry_provider: custom_provider).validate! }
          .not_to raise_error
      end
    end
  end

  describe Client do
    context 'no-op telemetry provider' do
      it 'does not raise error when calling an operation' do
        client = Client.new(stub_responses: true)
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

      after { reset_opentelemetry_sdk }

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

      it 'raises error when an otel dependency was not required' do
        allow_any_instance_of(Hearth::Telemetry::OTelProvider)
          .to receive(:require).with('opentelemetry-sdk').and_raise(LoadError)
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
        expect(finished_send_span.attributes)
          .to include(
            'http.method' => 'POST',
            'net.protocol.name' => 'http',
            'net.protocol.version' => '1.1',
            'net.peer.name' => 'whitelabel.com',
            'net.peer.port' => 443,
            'http.status_code' => 200
          )
        expect(finished_op_span.attributes)
          .to include(
            'rpc.service' => 'WhiteLabel',
            'rpc.method' => 'TelemetryTest',
            'code.function' => 'telemetry_test',
            'code.namespace' => 'WhiteLabel::Telemetry'
          )
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
        client.telemetry_test(body: body)

        expect(finished_send_span.attributes)
          .to include(
            'http.request_content_length' => body.size.to_s,
            'http.response_content_length' => body.size.to_s
          )
      end

      it 'populates span data with error when it occurs' do
        stub_request(:post, 'https://whitelabel.com')
          .to_return(status: 500)
        begin
          client.telemetry_test
        rescue WhiteLabel::Errors::ApiServerError
          # Ignored
        end
        expect(finished_op_span.status.code).to eq(2) # err code
        expect(finished_op_span.events[0].name).to eq('exception')
        expect(finished_op_span.events[0].attributes['exception.type'])
          .to eq('WhiteLabel::Errors::ApiServerError')
      end

      context 'stub_responses' do
        it 'creates a stub span with all the supplied parameters' do
          client = Client.new(
            stub_responses: true,
            telemetry_provider: otel_provider
          )
          client.telemetry_test
          expect(finished_send_span).not_to be_nil
          expect(finished_send_span.attributes)
            .to include(
              'http.method' => 'POST',
              'net.protocol.name' => 'http',
              'net.protocol.version' => '1.1'
            )
          expect(finished_send_span.kind).to eq(:internal)
          expect(finished_send_span.parent_span_id)
            .to eq(finished_op_span.span_id)
        end
      end
    end
  end
end

# clears opentelemetry-sdk configuration state between specs
# https://github.com/open-telemetry/opentelemetry-ruby/blob/main/test_helpers/lib/opentelemetry/test_helpers.rb#L18
def reset_opentelemetry_sdk
  OpenTelemetry.instance_variable_set(
    :@tracer_provider,
    OpenTelemetry::Internal::ProxyTracerProvider.new
  )
  OpenTelemetry.error_handler = nil
  OpenTelemetry.propagation = nil
end
