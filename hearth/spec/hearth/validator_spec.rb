# frozen_string_literal: true

module Hearth
  describe Validator do
    let(:input_type) { Struct.new(:foo, keyword_init: true) }
    let(:input) { input_type.new(params) }
    let(:context) { 'input' }

    subject { Validator }

    describe '.validate!' do
      context 'value is the type' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect { subject.validate!(input[:foo], String, context: context) }
            .to_not raise_error
        end
      end

      context 'value is a sub type' do
        let(:params) { { foo: 1 } }

        it 'does not raise an error' do
          expect { subject.validate!(input[:foo], Numeric, context: context) }
            .to_not raise_error
        end
      end

      context 'value is not the type' do
        let(:params) { { foo: [1, 2, 3] } }

        it 'raises an ArgumentError' do
          expect { subject.validate!(input[:foo], String, context: context) }
            .to raise_error(
              ArgumentError,
              "Expected #{context} to be in [String], got Array."
            )
        end
      end

      context 'value is not set' do
        let(:params) { {} }

        it 'returns nil' do
          expect(subject.validate!(input[:foo], String, context: context))
            .to be_nil
        end
      end

      context 'multiple types' do
        let(:params) { { foo: false } }

        it 'checks value against multiple args' do
          expect do
            subject.validate!(
              input[:foo],
              TrueClass, FalseClass,
              context: context
            )
          end.to_not raise_error
        end
      end
    end
  end
end
