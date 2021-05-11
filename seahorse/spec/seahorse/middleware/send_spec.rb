# frozen_string_literal: true

require 'seahorse/middleware/send'

module Seahorse
  module Middleware

    describe Send do
      let(:app) { double('app') }
      let(:client) { double('client') }
      let(:stub_responses) { false }
      let(:stub_class) { double('stub_class') }
      let(:stubs) { Seahorse::Stubbing::Stubs.new }

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_class: stub_class,
          stubs: stubs
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }

        it 'sends the request and returns an output object' do
          expect(client).to receive(:transmit).with(
            request: request,
            response: response
          )

          expect(
            subject.call(
              request: request,
              response: response,
              context: context
            )
          ).to be_a Seahorse::Output
        end

        context 'stub_responses is true' do
          let(:stub_responses) { true }

          it 'todo'
        end
      end
    end

  end
end
