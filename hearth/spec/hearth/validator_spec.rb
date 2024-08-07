# frozen_string_literal: true

module Hearth
  class TestValidatorInput
    include Hearth::Structure

    MEMBERS = %i[foo].freeze

    attr_accessor(*MEMBERS)
  end

  describe Validator do
    let(:input) { TestValidatorInput.new(params) }
    let(:context) { 'input' }

    describe '.validate_range!' do
      context 'value is the within the expected range' do
        let(:params) { { foo: 10 } }

        it 'does not raise an error' do
          expect do
            Validator.validate_range!(
              input.foo,
              min: 0,
              max: 10,
              context: context
            )
          end.to_not raise_error
        end
      end

      context 'value is outside of the expected range' do
        let(:params) { { foo: -1 } }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_range!(
              input.foo,
              min: 0,
              max: 10,
              context: context
            )
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be between 0 to 10, got -1."
          )
        end
      end
    end

    describe '.validate_required!' do
      context 'value exists' do
        let(:params) { { foo: '' } }

        it 'does not raise an error' do
          expect do
            Validator.validate_required!(input.foo, context: context)
          end.to_not raise_error
        end
      end

      context 'value does not exist' do
        let(:params) { {} }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_required!(input.foo, context: context)
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be set."
          )
        end
      end
    end

    describe '.validate_responds_to!' do
      context 'value responds to the method' do
        let(:params) { { foo: '' } }

        it 'does not raise an error' do
          expect do
            Validator.validate_responds_to!(
              input.foo,
              :empty?,
              context: context
            )
          end.to_not raise_error
        end
      end

      context 'value does not respond to the method' do
        let(:params) { { foo: '' } }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_responds_to!(
              input.foo,
              :non_existent_method,
              context: context
            )
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to respond to " \
            '[non_existent_method], got String.'
          )
        end
      end
    end

    describe '.validate_types!' do
      context 'value is the type' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect do
            Validator.validate_types!(input.foo, String, context: context)
          end.to_not raise_error
        end
      end

      context 'value is a sub type' do
        let(:params) { { foo: 1 } }

        it 'does not raise an error' do
          expect do
            Validator.validate_types!(input.foo, Numeric, context: context)
          end.to_not raise_error
        end
      end

      context 'value is not the type' do
        let(:params) { { foo: [1, 2, 3] } }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_types!(input.foo, String, context: context)
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be in [String], got Array."
          )
        end
      end

      context 'value is a boolean' do
        let(:params) { { foo: false } }

        it 'raises an ArgumentError when type is non-boolean' do
          expect do
            Validator.validate_types!(input.foo, String, context: context)
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be in [String], got FalseClass."
          )
        end
      end

      context 'value is not set' do
        let(:params) { {} }

        it 'does not raise an error' do
          expect do
            Validator.validate_types!(input.foo, String, context: context)
          end.to_not raise_error
        end
      end

      context 'multiple types' do
        let(:params) { { foo: false } }

        it 'checks value against multiple args' do
          expect do
            Validator.validate_types!(
              input.foo,
              TrueClass, FalseClass,
              context: context
            )
          end.to_not raise_error
        end
      end
    end

    describe '.validate_unknown!' do
      let(:input) { TestValidatorInput.new }

      context 'all members are known' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect do
            Validator.validate_unknown!(input, params, context: context)
          end.to_not raise_error
        end
      end

      context 'some members are unknown' do
        let(:params) { { foo: 'bar', baz: 'qux' } }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_unknown!(input, params, context: context)
          end.to raise_error(
            ArgumentError,
            'Unexpected members: [input[:baz]]'
          )
        end
      end

      context 'all members are unknown' do
        let(:params) { { baz: 'qux', qux: 'baz' } }

        it 'raises an ArgumentError' do
          expect do
            Validator.validate_unknown!(input, params, context: context)
          end.to raise_error(
            ArgumentError,
            'Unexpected members: [input[:baz], input[:qux]]'
          )
        end
      end
    end
  end
end
