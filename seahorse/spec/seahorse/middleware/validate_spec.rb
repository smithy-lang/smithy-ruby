# frozen_string_literal: true

require 'seahorse/middleware/validate'

module Seahorse
  module Middleware
    describe Validate do
      let(:app) { double('app') }
      let(:validator) { double('validator') }
      let(:params) { { foo: 'bar' } }

      subject do
        Validate.new(
          app,
          validator: validator,
          params: params,
          validate_params: validate_params
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        context 'validate_params is true' do
          let(:validate_params) { true }

          it 'validates the request then calls the next middleware' do
            expect(validator).to receive(:validate)
              .with(params: params, context: 'params').ordered
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

        context 'validate_params is false' do
          let(:validate_params) { false }

          it 'calls the next middleware' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            )

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
end
