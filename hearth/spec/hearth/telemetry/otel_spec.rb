# frozen_string_literal: true

require 'opentelemetry-sdk'

module Hearth
  module Telemetry
    describe OTelProvider do
      before do
        allow(Hearth::Telemetry)
          .to receive(:otel_loaded?)
          .and_return(true)
      end

      let(:otel_provider) { OTelProvider.new }
      let(:context_manager) { otel_provider.context_manager }
      let(:tracer_provider) { otel_provider.tracer_provider }
      let(:tracer) { tracer_provider.tracer('some_tracer') }

      describe '#initialize' do
        it 'raises ArgumentError when otel dependency fails to load' do
          allow(Hearth::Telemetry).to receive(:otel_loaded?).and_return(false)
          expect { otel_provider }.to raise_error(ArgumentError)
        end

        it 'sets up tracer provider and context manager' do
          expect(tracer_provider).to be_a(OpenTelemetry::Trace::TracerProvider)
          expect(context_manager).to be_a(Hearth::Telemetry::ContextManager)
        end
      end

      describe ':context_manager' do
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

        describe '#current_span' do
          it 'returns the current span' do
            wrapper_span = tracer.start_span('foo')
            expect(context_manager.current_span).to eq(wrapper_span)
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

      describe ':tracer_provider' do
        it 'returns a tracer instance' do
          expect(tracer).to be_a(OpenTelemetry::Trace::Tracer)
        end

        context 'tracer' do
          let(:otel_export) { OpenTelemetry::SDK::Trace::Export }
          let(:otel_exporter) { otel_export::InMemorySpanExporter.new }
          before do
            processor = otel_export::SimpleSpanProcessor.new(otel_exporter)
            OpenTelemetry::SDK.configure do |c|
              c.add_span_processor(processor)
            end
          end

          describe '#start_span' do
            it 'returns a valid span with supplied parameters' do
              span = tracer.start_span('some_span')
              span.set_attribute('apple', 'pie')
              span.status = Hearth::Telemetry::SpanStatus.ok
              span.finish
              expect(otel_exporter.finished_spans[0].name)
                .to eq('some_span')
              expect(otel_exporter.finished_spans[0].attributes)
                .to eq('apple' => 'pie')
              expect(otel_exporter.finished_spans[0].status)
                .to be_an_instance_of(Hearth::Telemetry::SpanStatus)
            end
          end

          describe '#in_span' do
            it 'returns a valid span with supplied parameters' do
              tracer.in_span('foo') do |span|
                span['meat'] = 'pie'
                span.add_event('pizza party')
              end
              expect(otel_exporter.finished_spans[0].name)
                .to eq('foo')
              expect(otel_exporter.finished_spans[0].attributes)
                .to eq('meat' => 'pie')
              expect(otel_exporter.finished_spans[0].events[0].name)
                .to eq('pizza party')
            end
          end
        end
      end
    end
  end
end
