# frozen_string_literal: true

require 'seahorse/middleware/sign'

module Seahorse
  module Middleware
    describe Sign do
      let(:app) { double('app') }
      let(:signer) { double('signer') }

      subject do
        Sign.new(
          app,
          signer: signer
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        it 'signs the request then calls the next middleware' do
          expect(signer).to receive(:sign_request).with(request).ordered
          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
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
