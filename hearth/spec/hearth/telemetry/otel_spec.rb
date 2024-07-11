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

      describe '#initialize' do
        it 'raises ArgumentError when otel dependency fails to load' do
          allow(Hearth::Telemetry).to receive(:otel_loaded?).and_return(false)
          expect { otel_provider }.to raise_error(ArgumentError)
        end

        it 'sets up tracer provider and context manager' do
          expect(otel_provider.tracer_provider)
            .to be_a(OpenTelemetry::Trace::TracerProvider)
          expect(otel_provider.context_manager)
            .to be_a(Hearth::Telemetry::ContextManager)
        end
      end

      describe ':context_manager' do
        after { OpenTelemetry::Context.clear }
        let(:subject) { otel_provider.context_manager }
        let(:tracer_provider) { otel_provider.tracer_provider }
        let(:root_context) { OpenTelemetry::Context::ROOT }
        let(:new_context) do
          OpenTelemetry::Context.empty.set_value('foo', 'bar')
        end

        describe '#current' do
          it 'returns the current context' do
            expect(subject.current).to eq(root_context)
          end
        end

        describe '#current_span' do
          it 'returns the current span' do
            wrapper_span = tracer_provider.tracer.in_span('some_span') do |span|
              span.set_attribute('foo', 'bar')
            end
            expect(subject.current_span).to eq(wrapper_span)
          end
        end

        describe '#attach' do
          it 'sets the current context' do
            subject.attach(new_context)
            expect(subject.current).to eq(new_context)
          end
        end

        describe '#detach' do
          it 'detaches the previously set context' do
            token = subject.attach(new_context)
            expect(subject.current).to eq(new_context)
            subject.detach(token)
            expect(subject.current).to eq(root_context)
          end
        end
      end

      describe ':tracer_provider' do
        let(:subject) { otel_provider.tracer_provider }

        it 'returns a tracer instance' do
          expect(subject.tracer).to be_a(OpenTelemetry::Trace::Tracer)
        end

        context 'tracer' do
          let(:tracer) { subject.tracer('foo') }

          # some test case that tests all the functionality under no-op span
          # it '....' do
          #   tracer.in_span('foo') do |span|
          #     # ...
          #   end
          # end
        end
      end
    end
  end
end
