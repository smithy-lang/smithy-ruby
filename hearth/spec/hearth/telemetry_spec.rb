# frozen_string_literal: true

module Hearth
  module Telemetry
    describe NoOpTelemetryProvider do
      describe '#initialize' do
        it 'sets up no-op provider' do
          expect(subject.tracer_provider).to be_a(Hearth::Telemetry::NoOpTracerProvider)
        end
      end
    end

    describe NoOpTracerProvider do
      describe '#tracer' do
        it 'returns an instance of no-op tracer' do
          expect(subject.tracer).to be_an_instance_of(Hearth::Telemetry::NoOpTracer)
        end
      end
    end

    describe NoOpTracer do
      describe '#in_span' do
        it 'yields an instance of no-op span' do
          subject.in_span('wrapper') do | span|
            expect(span).to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
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
          expect(subject.finish).to be_an_instance_of(Hearth::Telemetry::NoOpSpan)
        end
      end
    end

  end
end