# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Extension do
      describe '.member_index' do
        let(:shape) { Shapes::StructureShape.new }
        let(:member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName') }

        it 'returns a frozen member index keyed by member name' do
          shape.add_member(:some_member, member)

          expect(described_class.member_index(shape)).to eq('wireName' => [:some_member, member])
          expect(described_class.member_index(shape)).to be_frozen
        end

        it 'ignores members that do not have a modeled member name' do
          shape.add_member(:missing_name, Shapes::MemberShape.new(target: Shapes::StringShape.new))

          expect(described_class.member_index(shape)).to eq({})
        end

        it 'memoizes the index on the shape metadata' do
          shape.add_member(:some_member, member)

          expect(described_class.member_index(shape)).to be(described_class.member_index(shape))
        end

      end

      describe '.wire_name' do
        it 'returns the model name' do
          member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'wireName',
            traits: { 'smithy.api#jsonName' => 'jsonWireName' }
          )

          expect(described_class.wire_name(member)).to eq('wireName')
        end
      end

      describe '.sparse?' do
        it 'returns true when the sparse trait is present' do
          shape = Shapes::ListShape.new(traits: { 'smithy.api#sparse' => {} })

          expect(described_class.sparse?(shape)).to be(true)
        end

        it 'returns false when the sparse trait is absent' do
          expect(described_class.sparse?(Shapes::ListShape.new)).to be(false)
        end
      end
    end
  end
end
