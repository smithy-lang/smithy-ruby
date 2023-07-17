# frozen_string_literal: true

module Hearth
  describe Validator do
    let(:input_type) { Struct.new(:foo, keyword_init: true) }
    let(:input) { input_type.new(params) }
    let(:context) { 'input' }

    subject { Validator }

    describe '.validate_types!' do
      context 'value is the type' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect do
            subject.validate_types!(input[:foo], String, context: context)
          end.to_not raise_error
        end
      end

      context 'value is a sub type' do
        let(:params) { { foo: 1 } }

        it 'does not raise an error' do
          expect do
            subject.validate_types!(input[:foo], Numeric, context: context)
          end.to_not raise_error
        end
      end

      context 'value is not the type' do
        let(:params) { { foo: [1, 2, 3] } }

        it 'raises an ArgumentError' do
          expect do
            subject.validate_types!(input[:foo], String, context: context)
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be in [String], got Array."
          )
        end
      end

      context 'value is not set' do
        let(:params) { {} }

        it 'does not raise an error' do
          expect do
            subject.validate_types!(input[:foo], String, context: context)
          end.to_not raise_error
        end
      end

      context 'multiple types' do
        let(:params) { { foo: false } }

        it 'checks value against multiple args' do
          expect do
            subject.validate_types!(
              input[:foo],
              TrueClass, FalseClass,
              context: context
            )
          end.to_not raise_error
        end
      end
    end

    describe '.validate_required!' do
      context 'value exists' do
        let(:params) { { foo: '' } }

        it 'does not raise an error' do
          expect do
            subject.validate_required!(input[:foo], context: context)
          end.to_not raise_error
        end
      end

      context 'value does not exist' do
        let(:params) { {} }

        it 'raises an ArgumentError' do
          expect do
            subject.validate_required!(input[:foo], context: context)
          end.to raise_error(
            ArgumentError,
            "Expected #{context} to be set."
          )
        end
      end
    end

    describe '.validate_unknown!' do
      let(:struct_class) { Struct.new(:foo, :bar, keyword_init: true) }
      let(:struct) { struct_class.new }

      context 'all members are known' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect do
            subject.validate_unknown!(struct, params, context: context)
          end.to_not raise_error
        end
      end

      context 'some members are unknown' do
        let(:params) { { foo: 'bar', baz: 'qux' } }

        it 'raises an ArgumentError' do
          expect do
            subject.validate_unknown!(struct, params, context: context)
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
            subject.validate_unknown!(struct, params, context: context)
          end.to raise_error(
            ArgumentError,
            'Unexpected members: [input[:baz], input[:qux]]'
          )
        end
      end
    end
  end
end
