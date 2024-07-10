# frozen_string_literal: true

module Hearth
  module Telemetry
    describe SpanStatus do
      describe '.unset' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.unset
          expect(status.code).to eq(1)
        end
      end

      describe '.ok' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.ok
          expect(status.code).to eq(0)
        end
      end

      describe '.error' do
        it 'returns the correct expected code' do
          status = Hearth::Telemetry::SpanStatus.error
          expect(status.code).to eq(2)
        end
      end
    end
  end
end
