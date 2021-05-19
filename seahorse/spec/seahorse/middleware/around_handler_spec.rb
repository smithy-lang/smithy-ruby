# frozen_string_literal: true

module Seahorse
  module Middleware

    describe AroundHandler do
      let(:app) { double('app') }
      let(:handler) { double('handler') }

      subject do
        AroundHandler.new(
          app,
          handler: handler
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }

        it 'calls the handler with the stack' do
          expect(handler).to receive(:call).with(
            app,
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
