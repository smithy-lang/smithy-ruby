# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Extension do
      describe '.member_index' do
        let(:shape) { Shapes::StructureShape.new }
        let(:first_member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, model_name: 'wireName') }
        let(:second_member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, model_name: 'wireName') }

        it 'returns a frozen member index keyed by model_name' do
          shape.add_member(:first_member, first_member)

          expect(described_class.member_index(shape)).to eq('wireName' => [:first_member, first_member])
          expect(described_class.member_index(shape)).to be_frozen
        end

        it 'skips members without a model_name' do
          shape.add_member(:missing_name, Shapes::MemberShape.new(target: Shapes::StringShape.new))

          expect(described_class.member_index(shape)).to eq({})
        end

        it 'memoizes the index on the shape metadata' do
          shape.add_member(:first_member, first_member)

          expect(described_class.member_index(shape)).to be(described_class.member_index(shape))
        end

        it 'keeps the last member for duplicate wire names' do
          shape.add_member(:first_member, first_member)
          shape.add_member(:second_member, second_member)

          expect(described_class.member_index(shape)).to eq('wireName' => [:second_member, second_member])
        end
      end

      describe '.wire_name' do
        it 'returns the model name' do
          member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            model_name: 'wireName',
            traits: { json_name: 'jsonWireName' }
          )

          expect(described_class.wire_name(member)).to eq('wireName')
        end
      end
    end
  end
end
