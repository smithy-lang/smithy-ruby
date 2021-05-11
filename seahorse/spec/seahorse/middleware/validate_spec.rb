# frozen_string_literal: true

require 'seahorse/middleware/validate'

module Seahorse
  module Middleware

    describe Validate do
      let(:app) { double('app') }
      let(:validator) { double('validator') }
      let(:input) { { foo: 'bar' } }

      subject do
        Validate.new(
          app,
          validator: validator,
          input: input,
          validate_input: validate_input
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }

        context 'validate_input is true' do
          let(:validate_input) { true }

          it 'validates the request then calls the next middleware' do
            expect(validator).to receive(:validate!)
              .with(input: input, context: 'input').ordered
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

        context 'validate_input is false' do
          let(:validate_input) { false }

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
