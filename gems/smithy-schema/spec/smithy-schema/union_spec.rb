# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Union do
      let(:union) do
        Struct.new(:string_value, :integer_value, keyword_init: true) do
          include Union
        end
      end
      let(:string_value) { Class.new(union) }
      let(:integer_value) { Class.new(union) }

      it 'is a Structure' do
        expect(subject).to include(Structure)
      end

      describe '#member' do
        it 'returns the first non-nil member' do
          union = integer_value.new(integer_value: 1)
          expect(union.member).to eq(:integer_value)
        end
      end

      describe '#value' do
        it 'returns the first non-nil value' do
          union = integer_value.new(integer_value: 1)
          expect(union.value).to eq(1)
        end
      end
    end
  end
end
