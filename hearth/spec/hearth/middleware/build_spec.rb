# frozen_string_literal: true

module Hearth
  module Middleware
    describe Build do
      let(:app) { double('app', call: output) }
      let(:builder) { double('builder') }

      subject do
        Build.new(
          app,
          builder: builder,
          disable_host_prefix: false
        )
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:context) do
          Context.new(
            request: request,
            response: response
          )
        end

        it 'builds then calls the next middleware' do
          expect(builder).to receive(:build)
            .with(request, input: input, disable_host_prefix: false).ordered
          expect(app).to receive(:call)
            .with(input, context).ordered

          resp = subject.call(input, context)
          expect(resp).to be output
        end
      end
    end
  end
end
