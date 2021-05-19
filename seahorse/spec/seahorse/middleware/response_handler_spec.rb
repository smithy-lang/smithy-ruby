# frozen_string_literal: true

require 'seahorse/middleware/response_handler'

module Seahorse
  module Middleware

    describe ResponseHandler do
      let(:app) { double('app') }
      let(:handler) { double('handler') }

      subject do
        ResponseHandler.new(
          app,
          handler: handler
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        it 'calls the next middleware and then the handler' do
          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
          ).and_return(output).ordered

          expect(handler).to receive(:call).with(
            request,
            response,
            context
          ).ordered

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
