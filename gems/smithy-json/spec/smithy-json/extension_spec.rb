# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Extension do
      describe '.json_index' do
        let(:shape) { Schema::Shapes::StructureShape.new }
        let(:plain_member) do
          Schema::Shapes::MemberShape.new(target: Schema::Shapes::StringShape.new, model_name: 'plainName')
        end
        let(:json_named_member) do
          Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StringShape.new,
            model_name: 'modelName',
            traits: { json_name: 'wireName' }
          )
        end

        it 'indexes members by jsonName when present' do
          shape.add_member(:plain_name, plain_member)
          shape.add_member(:json_named, json_named_member)

          expect(described_class.json_index(shape)).to eq(
            'plainName' => [:plain_name, plain_member],
            'wireName' => [:json_named, json_named_member]
          )
          expect(described_class.json_index(shape)).to be_frozen
        end
      end

      describe '.wire_name' do
        it 'memoizes jsonName on the member metadata' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StringShape.new,
            model_name: 'modelName',
            traits: { json_name: 'wireName' }
          )

          expect(described_class.wire_name(member)).to eq('wireName')
          expect(described_class.wire_name(member)).to be(described_class.wire_name(member))
        end

        it 'falls back to the model_name' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StringShape.new,
            model_name: 'modelName'
          )

          expect(described_class.wire_name(member)).to eq('modelName')
        end
      end
    end
  end
end
