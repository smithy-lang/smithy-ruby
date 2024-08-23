# frozen_string_literal: true

module Hearth
  describe InterceptorContext do
    let(:input) { double('input') }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:output) { double('output') }
    let(:telemetry_provider) { Hearth::Telemetry::NoOpTelemetryProvider.new }
    let(:config) { double('config', telemetry_provider: telemetry_provider) }

    subject do
      InterceptorContext.new(
        input: input,
        request: request,
        response: response,
        output: config,
        config: config
      )
    end

    describe '#telemetry_provider' do
      it 'returns telemetry provider' do
        expect(subject.telemetry_provider)
          .to be_a(Hearth::Telemetry::NoOpTelemetryProvider)
      end
    end
  end
end
