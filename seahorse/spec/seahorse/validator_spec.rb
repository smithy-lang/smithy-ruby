# frozen_string_literal: true

require 'seahorse/validator'

module Seahorse
  describe Validator do

    let(:input_type) { Struct.new(:member, keyword_init: true) }
    let(:input) { input_type.new(params) }
    let(:context) { 'input' }

    subject { Validator.new(input: input, context: context) }

    describe '#validate_enum!' do
      let(:enums) { %w[cool enum] }

      context 'value is in the enum list' do
        let(:params) { { member: 'cool' } }

        it 'does not raise' do
          expect(subject.validate_enum!(:member, enums: enums)).to be_nil
        end
      end

      context 'value is not in the enum list' do
        let(:params) { { member: 'not_cool' } }

        it 'raises an ArgumentError' do
          expect { subject.validate_enum!(:member, enums: enums) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be in #{enums}."
            )
        end
      end
    end

    describe '#validate_length!' do
      context 'value is too small' do
        let(:params) { { member: '' } }
        let(:min) { 1 }

        it 'raises an ArgumentError' do
          expect { subject.validate_length!(:member, min: min) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be longer than #{min}."
            )
        end
      end

      context 'value is too large' do
        let(:params) { { member: 'this is a long string' } }
        let(:max) { 10 }

        it 'raises an ArgumentError' do
          expect { subject.validate_length!(:member, max: max) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be shorter than #{max}."
            )
        end
      end

      context 'value is just right' do
        let(:params) { { member: 'cool' } }

        it 'does not raise' do
          expect(subject.validate_length!(:member, min: 1, max: 10)).to be_nil
        end
      end
    end

    describe '#validate_pattern!' do
      let(:pattern) { '\\w+' }

      context 'value matches the pattern' do
        let(:params) { { member: 'cool' } }

        it 'does not raise' do
          expect(subject.validate_pattern!(:member, pattern: pattern)).to be_nil
        end
      end

      context 'value does not match the pattern' do
        let(:params) { { member: '&' } }

        it 'raises an ArgumentError' do
          expect { subject.validate_pattern!(:member, pattern: pattern) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to match #{pattern}."
            )
        end
      end
    end

    describe '#validate_range!' do
      context 'value is too small' do
        let(:params) { { member: 0 } }
        let(:min) { 1 }

        it 'raises an ArgumentError' do
          expect { subject.validate_range!(:member, min: min) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be larger than #{min}."
            )
        end
      end

      context 'value is too large' do
        let(:params) { { member: 11 } }
        let(:max) { 10 }

        it 'raises an ArgumentError' do
          expect { subject.validate_range!(:member, max: max) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be smaller than #{max}."
            )
        end
      end

      context 'value is just right' do
        let(:params) { { member: 5 } }

        it 'does not raise' do
          expect(subject.validate_range!(:member, min: 1, max: 10)).to be_nil
        end
      end
    end

    describe '#validate_required!' do
      context 'value is not set' do
        let(:params) { {} }

        it 'raises an ArgumentError' do
          expect { subject.validate_required!(:member) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be set."
            )
        end
      end

      context 'value is set but empty' do
        let(:params) { { member: '' } }

        it 'raises an ArgumentError' do
          expect { subject.validate_required!(:member) }
            .to raise_error(
              ArgumentError,
              "Expected #{context}[:member] to be non-empty."
            )
        end
      end

      context 'value is set and non-empty' do
        let(:params) { { member: 'bar' } }

        it 'does not raise' do
          expect(subject.validate_required!(:member)).to be_nil
        end
      end
    end

    describe '#validate_unique_items!' do
      context 'value has unique items' do
        let(:params) { { member: %w[cool beans] } }

        it 'does not raise' do
          expect(subject.validate_unique_items!(:member)).to be_nil
        end
      end

      context 'value has duplicates' do
        let(:params) { { member: %w[cool cool] } }

        it 'raises an ArgumentError' do
          expect { subject.validate_unique_items!(:member) }
            .to raise_error(
              ArgumentError,
              "Expected items in #{context}[:member] to be unique."
            )
        end
      end
    end

  end
end
