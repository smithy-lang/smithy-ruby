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

          expect(described_class.wire_index(shape)).to eq('wireName' => [:some_member, member])
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
        let(:shape) { Shapes::StructureShape.new }
        let(:member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName') }

        it 'returns a frozen build index keyed by Ruby member name' do
          shape.add_member(:some_member, member)

          expect(described_class.member_index(shape)).to eq(some_member: ['wireName', member])
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

      describe '.timestamp_format' do
        it 'prefers the member trait' do
          member = Shapes::MemberShape.new(
            target: Shapes::TimestampShape.new(
              traits: { 'smithy.api#timestampFormat' => 'http-date' }
            ),
            traits: { 'smithy.api#timestampFormat' => 'date-time' }
          )

          expect(described_class.timestamp_format(member)).to eq('date-time')
        end

        it 'falls back to the target shape trait' do
          member = Shapes::MemberShape.new(
            target: Shapes::TimestampShape.new(
              traits: { 'smithy.api#timestampFormat' => 'http-date' }
            )
          )

          expect(described_class.timestamp_format(member)).to eq('http-date')
        end

        it 'returns :default when no explicit format is modeled' do
          member = Shapes::MemberShape.new(target: Shapes::TimestampShape.new)

          expect(described_class.timestamp_format(member)).to eq(:default)
        end

        it 'memoizes the resolved format on the shape metadata' do
          member = Shapes::MemberShape.new(target: Shapes::TimestampShape.new)

          expect(described_class.timestamp_format(member)).to be(described_class.timestamp_format(member))
        end
      end

    end
  end
end
