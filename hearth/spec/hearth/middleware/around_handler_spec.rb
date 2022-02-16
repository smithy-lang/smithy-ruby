# frozen_string_literal: true

module Hearth
  module Middleware
    describe AroundHandler do
      let(:app) { double('app', call: output) }
      let(:handler) { double('handler') }

      subject do
        AroundHandler.new(
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

        it 'calls the handler with the stack' do
          expect(handler).to receive(:call)
            .with(app, input, context).ordered

          subject.call(input, context)
        end
      end
    end
  end
end
