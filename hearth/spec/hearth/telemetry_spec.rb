# frozen_string_literal: true

require 'opentelemetry-sdk'

module Hearth
  module Telemetry
    describe '.otel_loaded?' do
      before { Hearth::Telemetry.instance_variable_set(:@use_otel, nil) }

      it 'is true when opentelemetry-sdk is available' do
        expect(Hearth::Telemetry).to receive(:require)
          .with('opentelemetry-sdk')
          .and_return(true)
        expect(Hearth::Telemetry.send(:otel_loaded?))
          .to be_truthy
      end

      it 'returns false when opentelemetry-sdk is not available' do
        expect(Hearth::Telemetry).to receive(:require)
          .with('opentelemetry-sdk')
          .and_raise(LoadError)
        expect(Hearth::Telemetry.send(:otel_loaded?))
          .to be_falsey
      end

      it 'memoizes its status' do
        expect(Hearth::Telemetry).to receive(:require)
          .once
          .with('opentelemetry-sdk')
          .and_raise(LoadError)
        Hearth::Telemetry.send(:otel_loaded?)
        # second call should not call require again
        Hearth::Telemetry.send(:otel_loaded?)
      end
    end

    describe NoOpTelemetryProvider do
      describe '#initialize' do
        it 'sets up no-op provider' do
          expect(subject.tracer_provider)
            .to be_a(Hearth::Telemetry::NoOpTracerProvider)
        end
      end
    end

    describe NoOpTracerProvider do
      describe '#tracer' do
        it 'returns an instance of no-op tracer' do
          expect(subject.tracer)
            .to be_an_instance_of(Hearth::Telemetry::NoOpTracer)
        end
      end
    end

    describe NoOpTracer do
      describe '#in_span' do
        it 'yields an instance of no-op span' do
          subject.in_span('wrapper') do |span|
            expect(span)
              .to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
          end
        end
      end
    end

    describe NoOpSpan do
      describe '#set_attribute' do
        it 'returns itself' do
          expect(subject.set_attribute('some_attribute', 'some_value'))
            .to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
        end
      end

      describe '#add_event' do
        it 'returns itself' do
          expect(subject.add_event('some_event', attributes: {}))
            .to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
        end
      end

      describe '#finish' do
        it 'returns itself' do
          expect(subject.finish)
            .to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
        end
      end
    end

    describe OTelProvider do
      before do
        allow(Hearth::Telemetry).to receive(:otel_loaded?)
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
