# frozen_string_literal: true

require 'seahorse/middleware/build'

module Seahorse
  module Middleware
    describe Build do
      let(:app) { double('app') }
      let(:builder) { double('builder') }
      let(:params) { { foo: 'bar' } }

      subject do
        Build.new(
          app,
          builder: builder,
          params: params
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }

        it 'builds then calls the next middleware' do
          expect(builder).to receive(:build)
            .with(request, params: params).ordered
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
