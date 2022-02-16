# frozen_string_literal: true

module Hearth
  module Middleware
    describe Validate do
      let(:app) { double('app') }
      let(:validator) { double('validator') }
      let(:data) { { foo: 'bar' } }
      let(:input) { double('Type::OperationInput') }

      subject do
        Validate.new(
          app,
          validator: validator,
          validate_input: validate_input
        )
      end

      describe '#call' do
        let(:request) { Hearth::HTTP::Request.new }
        let(:context) { {} }

        context 'validate_input is true' do
          let(:validate_input) { true }

          it 'validates the request then calls the next middleware' do
            expect(validator).to receive(:validate!)
              .with(input, context: 'input').ordered
            expect(app).to receive(:call).with(input, context)

            subject.call(input, context)
          end
        end

        context 'validate_input is false' do
          let(:validate_input) { false }

          it 'calls the next middleware' do
            expect(validator).not_to receive(:validate!)
            expect(app).to receive(:call).with(input, context)

            subject.call(input, context)
          end
        end
      end
    end
  end
end
