# frozen_string_literal: true

require 'opentelemetry-sdk'

module Hearth
  module Telemetry
    describe OTelProvider do
      let(:otel_provider) { OTelProvider.new }
      let(:context_manager) { otel_provider.context_manager }
      let(:tracer_provider) { otel_provider.tracer_provider }

      describe '#initialize' do
        it 'raises ArgumentError when otel dependency fails to load' do
          allow_any_instance_of(Hearth::Telemetry::OTelProvider)
            .to receive(:require).with('opentelemetry-sdk').and_raise(LoadError)
          expect { otel_provider }.to raise_error(ArgumentError)
        end

        it 'sets up tracer provider and context manager' do
          expect(tracer_provider).to be_a(Hearth::Telemetry::OTelTracerProvider)
          expect(context_manager).to be_a(Hearth::Telemetry::OTelContextManager)
        end
      end

      describe OTelContextManager do
        after { OpenTelemetry::Context.clear }
        let(:root_context) { OpenTelemetry::Context::ROOT }
        let(:new_context) do
          OpenTelemetry::Context.empty.set_value('new', 'context')
        end

        describe '#current' do
          it 'returns the current context' do
            expect(context_manager.current).to eq(root_context)
          end
        end

        describe '#attach' do
          it 'sets the current context' do
            context_manager.attach(new_context)
            expect(context_manager.current).to eq(new_context)
          end
        end

        describe '#detach' do
          it 'detaches the previously set context' do
            token = context_manager.attach(new_context)
            expect(context_manager.current).to eq(new_context)
            context_manager.detach(token)
            expect(context_manager.current).to eq(root_context)
          end
        end
      end

      describe OTelTracerProvider do
        let(:tracer) { tracer_provider.tracer('some_tracer') }

        it 'returns a tracer instance' do
          expect(tracer).to be_a(Hearth::Telemetry::OTelTracer)
        end

        describe OTelTracer do
          let(:otel_export) { OpenTelemetry::SDK::Trace::Export }
          let(:otel_exporter) { otel_export::InMemorySpanExporter.new }
          let(:finished_span) { otel_exporter.finished_spans[0] }

          before do
            processor = otel_export::SimpleSpanProcessor.new(otel_exporter)
            OpenTelemetry::SDK.configure do |c|
              c.add_span_processor(processor)
            end
          end

          after { reset_opentelemetry_sdk }

          describe '#start_span' do
            it 'returns a valid span with supplied parameters' do
              span = tracer.start_span('some_span')
              span.set_attribute('apple', 'pie')
              span.add_event('pizza party')
              span.status = Hearth::Telemetry::SpanStatus.ok
              span.finish
              expect(finished_span.name).to eq('some_span')
              expect(finished_span.attributes).to include('apple' => 'pie')
              expect(finished_span.events[0].name).to eq('pizza party')
              expect(finished_span.status)
                .to be_an_instance_of(Hearth::Telemetry::SpanStatus)
            end
          end

          describe '#in_span' do
            let(:error) { StandardError.new('foo') }

            it 'returns a valid span with supplied parameters' do
              tracer.in_span('foo') do |span|
                span['meat'] = 'pie'
                span.add_attributes('durian' => 'pie')
                span.status = Hearth::Telemetry::SpanStatus.error
                span.record_exception(error, attributes: { 'burnt' => 'pie' })
              end
              expect(finished_span.name).to eq('foo')
              expect(finished_span.attributes)
                .to include(
                  'meat' => 'pie',
                  'durian' => 'pie'
                )
              expect(finished_span.status.code).to eq(2)
              expect(finished_span.events.size).to eq(1)
              expect(finished_span.events[0].name).to eq('exception')
              expect(finished_span.events[0].attributes['exception.type'])
                .to eq(error.class.to_s)
              expect(finished_span.events[0].attributes['exception.message'])
                .to eq(error.message)
              expect(finished_span.events[0].attributes['burnt']).to eq('pie')
            end
          end

          describe '#current_span' do
            it 'returns the current span' do
              tracer.in_span('foo') do |span|
                span['blueberry'] = 'pie'
                expect(tracer.current_span.instance_variable_get(:@span))
                  .to eq(span.instance_variable_get(:@span))
              end
            end
          end
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
