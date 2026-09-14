# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Extension do
      describe '.wire_index' do
        let(:shape) { Shapes::StructureShape.new }
        let(:member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName') }

        it 'returns a frozen member index keyed by member name' do
          shape.add_member(:some_member, member)

          expected_values = [:some_member, member, described_class::SHAPE_STRING]
          expect(described_class.wire_index(shape)).to eq('wireName' => expected_values)
          expect(described_class.wire_index(shape)).to be_frozen
        end

        it 'ignores members that do not have a modeled member name' do
          shape.add_member(:missing_name, Shapes::MemberShape.new(target: Shapes::StringShape.new))

          expect(described_class.wire_index(shape)).to eq({})
        end

        it 'memoizes the index on the shape metadata' do
          shape.add_member(:some_member, member)

          expect(described_class.wire_index(shape)).to be(described_class.wire_index(shape))
        end
      end

      describe '.member_index' do
        it 'returns a frozen member index keyed by Ruby member name' do
          member = Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName')
          shape = Shapes::StructureShape.new
          shape.add_member(:some_member, member)

          expected_values = ['wireName', member, described_class::SHAPE_STRING]
          expect(described_class.member_index(shape)).to eq(some_member: expected_values)
        end
      end

      describe '.legacy_wire_name' do
        it 'returns the model name' do
          member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'wireName',
            traits: { 'smithy.api#jsonName' => 'jsonWireName' }
          )

          expect(described_class.legacy_wire_name(member)).to eq('wireName')
        end
      end

      describe '.sparse?' do
        it 'returns whether the sparse trait is present' do
          expect(described_class.sparse?(Shapes::ListShape.new)).to be(false)
          expect(described_class.sparse?(Shapes::ListShape.new(traits: { 'smithy.api#sparse' => {} }))).to be(true)
        end
      end

      describe 'generic shape metadata' do
        it 'classifies target shapes' do
          expect(described_class.target_shape(Shapes::BlobShape.new)).to eq(described_class::SHAPE_BLOB)
          expect(described_class.target_shape(Shapes::FloatShape.new)).to eq(described_class::SHAPE_FLOAT)
          expect(described_class.target_shape(Shapes::ListShape.new)).to eq(described_class::SHAPE_LIST)
        end

        it 'caches collection members and sparse metadata' do
          list = Shapes::ListShape.new(traits: { 'smithy.api#sparse' => {} })
          member = Shapes::MemberShape.new(target: Shapes::StringShape.new)
          list.add_member(:member, member)

          expect(described_class.list_member(list)).to eq([member, described_class::SHAPE_STRING, true])
        end

        it 'resolves a member timestamp format before its target format' do
          timestamp = Shapes::TimestampShape.new(
            traits: { 'smithy.api#timestampFormat' => 'date-time' }
          )
          member = Shapes::MemberShape.new(
            target: timestamp,
            traits: { 'smithy.api#timestampFormat' => 'http-date' }
          )

          expect(described_class.timestamp_format(member)).to eq('http-date')
          expect(described_class.timestamp_format(Shapes::TimestampShape.new)).to eq(:default)
        end

        it 'caches a modeled media type using the Smithy trait key' do
          shape = Shapes::BlobShape.new(
            traits: { 'smithy.api#mediaType' => 'application/custom' }
          )

          expect(described_class.media_type(shape)).to eq('application/custom')
        end

        it 'caches an unknown union member type when present' do
          union = Shapes::UnionShape.new
          unknown_type = Class.new
          union.add_member(:unknown, unknown_type, Shapes::MemberShape.new)

          expect(described_class.unknown_member_type(union)).to be(unknown_type)
        end
      end
    end
  end
end
