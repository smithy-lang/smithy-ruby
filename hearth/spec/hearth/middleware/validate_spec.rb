# frozen_string_literal: true

module Hearth
  module Middleware
    describe Validate do
      let(:app) { double('app') }
      let(:validator) { double('validator') }
      let(:input) { double('input') }

      subject do
        Validate.new(
          app,
          validator: validator,
          validate_input: validate_input
        )
      end

      describe '#call' do
        let(:logger) { Logger.new(IO::NULL) }
        let(:context) do
          Hearth::Context.new(logger: logger)
        end

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
