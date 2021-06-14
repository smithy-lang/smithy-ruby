# frozen_string_literal: true

module Seahorse
  describe Validator do
    let(:input_type) { Struct.new(:foo, keyword_init: true) }
    let(:input) { input_type.new(params) }
    let(:context) { 'input' }

    subject { Validator.new(input, context: context) }

    describe '#validate_type!' do
      context 'value is the type' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect { subject.validate_type!(:foo, String) }.to_not raise_error
        end
      end

      context 'value is a sub type' do
        let(:params) { { foo: 1 } }

        it 'does not raise an error' do
          expect { subject.validate_type!(:foo, Numeric) }.to_not raise_error
        end
      end

      context 'value is not the type' do
        let(:params) { { foo: [1, 2, 3] } }

        it 'raises an ArgumentError' do
          expect { subject.validate_type!(:foo, String) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:foo] to be in [String], got Array."
            )
        end
      end

      context 'value is not set' do
        let(:params) { {} }

        it 'returns nil' do
          expect(subject.validate_type!(:foo, String)).to be_nil
        end
      end

      context 'multiple types' do
        let(:params) { { foo: false } }

        it 'checks value against multiple args' do
          expect do
            subject.validate_type!(:foo, TrueClass, FalseClass)
          end.to_not raise_error
        end
      end
    end
  end
end
