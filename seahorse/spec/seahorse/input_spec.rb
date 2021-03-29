# frozen_string_literal: true

require 'seahorse/input'

module Seahorse
  describe Input do
    let(:type) { Struct.new(:foo, keyword_init: true) }
    let(:context) { 'params' }

    subject { Input.new(params: params, context: context) }

    describe '#validate_params!' do
      context 'params is a hash' do
        let(:params) { { foo: 'bar' } }

        it 'does not raise an error' do
          expect { subject.validate_params!(type) }.to_not raise_error
        end
      end

      context 'params is the expected type' do
        let(:params) { type.new(foo: 'bar') }

        it 'does not raise an error' do
          expect { subject.validate_params!(type) }.to_not raise_error
        end
      end

      context 'params is something else' do
        let(:params) { nil }

        it 'raises an ArgumentError' do
          expect { subject.validate_params!(type) }
            .to raise_error(
              ArgumentError,
              "Expected #{context} to be a Hash or #{type},"\
              " got #{params.class}."
            )
        end
      end
    end

    describe '#validate_required!' do
      context 'key is not set' do
        let(:params) { {} }

        it 'raises an ArgumentError' do
          expect { subject.validate_required!(:foo) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:foo] to be set."
            )
        end
      end

      context 'key is set but empty' do
        let(:params) { { foo: '' } }

        it 'raises an ArgumentError' do
          expect { subject.validate_required!(:foo) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:foo] to be non-empty."
            )
        end
      end

      context 'key is set and non-empty' do
        let(:params) { { foo: 'bar' } }

        it 'does nothing' do
          expect(subject.validate_required!(:foo)).to be_nil
        end
      end
    end

    describe '#validate_type!' do
      context 'key is set' do
        context 'value is the type' do
          let(:params) { { foo: 'bar' } }

          it 'does not raise an error' do
            expect { subject.validate_type!(:foo, String) }.to_not raise_error
          end
        end

        context 'key value is not the type' do
          let(:params) { { foo: [1, 2, 3] } }

          it 'raises an ArgumentError' do
            expect { subject.validate_type!(:foo, String) }
              .to raise_error(
                ArgumentError,
                "Expected #{context}[:foo] to be a String, got Array."
              )
          end
        end
      end

      context 'key is not set' do
        let(:params) { {} }

        it 'returns nil' do
          expect(subject.validate_type!(:foo, String)).to be_nil
        end
      end
    end

    describe '#validate_unexpected!' do
      context 'unexpected keys' do
        let(:params) { { foo: 'bar', bar: 'baz' } }

        it 'raises an ArgumentError' do
          expect { subject.validate_unexpected!(type) }
            .to raise_error(
              ArgumentError,
              "Unexpected params at #{context}, got [:bar]"
            )
        end
      end

      context 'expected keys' do
        let(:params) { { foo: 'bar' } }

        it 'does nothing' do
          expect(subject.validate_unexpected!(type)).to be_nil
        end
      end
    end
  end
end
