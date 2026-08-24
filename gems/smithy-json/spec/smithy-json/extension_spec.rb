# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Extension do
      let(:json_named_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          name: 'modelName',
          traits: { 'smithy.api#jsonName' => 'wireName' }
        )
      end

      let(:plain_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          name: 'plainName'
        )
      end
      describe '.member_index' do
        it 'indexes members by jsonName when present' do
          shape = Schema::Shapes::StructureShape.new
          shape.add_member(:plain_name, plain_member)
          shape.add_member(:json_named, json_named_member)

          expect(described_class.member_index(shape)).to eq(
            'plainName' => [:plain_name, plain_member],
            'wireName' => [:json_named, json_named_member]
          )
          expect(described_class.member_index(shape)).to be_frozen
        end
      end

      describe '.wire_name' do
        it 'returns jsonName when present' do
          expect(described_class.wire_name(json_named_member)).to eq('wireName')
        end

        it 'falls back to the member name' do
          expect(described_class.wire_name(plain_member)).to eq('plainName')
        end
      end
    end
  end
end
