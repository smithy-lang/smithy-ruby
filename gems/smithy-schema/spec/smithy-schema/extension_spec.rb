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

          expected_values = [:some_member, member]
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

          expected_values = ['wireName', member]
          expect(described_class.member_index(shape)).to eq(some_member: expected_values)
        end
      end

      describe '.sparse?' do
        it 'returns whether the sparse trait is present' do
          expect(described_class.sparse?(Shapes::ListShape.new)).to be(false)
          expect(described_class.sparse?(Shapes::ListShape.new(traits: { 'smithy.api#sparse' => {} }))).to be(true)
        end
      end

      describe '.error_index' do
        it 'indexes operation errors by their target shape name' do
          error_shape = Shapes::StructureShape.new(name: 'ExampleError')
          error_member = Shapes::MemberShape.new(target: error_shape)
          operation = Shapes::OperationShape.new(errors: [error_member])

          expect(described_class.error_index(operation)).to eq('ExampleError' => error_member)
        end
      end

      describe 'generic shape metadata' do
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

      end
    end
  end
end
