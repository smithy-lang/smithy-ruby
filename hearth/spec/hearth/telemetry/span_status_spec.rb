# frozen_string_literal: true

module Hearth
  module Telemetry
    describe SpanStatus do
      describe '.unset' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.unset
          expect(status.code).to eq(Hearth::Telemetry::SpanStatus::UNSET)
        end
      end

      describe '.ok' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.ok
          expect(status.code).to eq(Hearth::Telemetry::SpanStatus::OK)
        end
      end

      describe '.error' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.error
          expect(status.code).to eq(Hearth::Telemetry::SpanStatus::ERROR)
        end
      end
    end
  end
end
