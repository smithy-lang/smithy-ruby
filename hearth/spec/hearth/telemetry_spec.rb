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
  end
end
