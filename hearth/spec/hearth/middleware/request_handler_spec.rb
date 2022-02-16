# frozen_string_literal: true

module Hearth
  module Middleware
    describe RequestHandler do
      let(:app) { double('app', call: output) }
      let(:handler) { double('handler') }

      subject do
        RequestHandler.new(
          app,
          handler: handler
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

        it 'calls the handler then the next middleware' do
          expect(handler).to receive(:call)
            .with(input, context).ordered

          expect(app).to receive(:call)
            .with(input, context).ordered

          resp = subject.call(input, context)
          expect(resp).to be output
        end
      end
    end
  end
end
