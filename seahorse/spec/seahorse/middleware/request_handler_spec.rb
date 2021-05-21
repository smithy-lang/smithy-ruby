# frozen_string_literal: true

module Seahorse
  module Middleware

    describe RequestHandler do
      let(:app) { double('app') }
      let(:handler) { double('handler') }

      subject do
        RequestHandler.new(
          app,
          handler: handler
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        it 'calls the handler then the next middleware' do
          expect(handler).to receive(:call).with(
            request,
            response,
            context
          ).ordered

          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
          ).and_return(output).ordered

          subject.call(
            request: request,
            response: response,
            context: context
          )
        end
      end
    end

  end
end
