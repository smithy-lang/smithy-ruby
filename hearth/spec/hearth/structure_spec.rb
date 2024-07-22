# frozen_string_literal: true

module Hearth
  class TestStructure
    include Hearth::Structure

    MEMBERS = %i[
      struct_value
      array_value
      hash_value
      value
      union_value
      some_object
      default_value
    ].freeze

    attr_accessor(*MEMBERS)

    private

    def _defaults
      {
        default_value: 'default'
      }
    end
  end

  describe Structure do
    subject do
      TestStructure.new(
        struct_value: TestStructure.new(value: 'foo'),
        array_value: [
          TestStructure.new(value: 'foo'),
          TestStructure.new(value: 'bar')
        ],
        hash_value: { key: TestStructure.new(value: 'value') },
        value: 'value',
        union_value: TestUnion::StringValue.new('union'),
        some_object: Object.new
      )
    end

    describe '#initialize' do
      it 'initializes with defaults' do
        expect(subject.default_value).to eq('default')
      end
    end

    describe '#to_hash' do
      it 'serializes nested structs to a hash' do
        expected = {
          struct_value: { value: 'foo', default_value: 'default' },
          array_value: [
            { value: 'foo', default_value: 'default' },
            { value: 'bar', default_value: 'default' }
          ],
          hash_value: {
            key: { value: 'value', default_value: 'default' }
          },
          value: 'value',
          union_value: { string_value: 'union' },
          some_object: subject.some_object,
          default_value: 'default'
        }
        expect(subject.to_h).to eq expected
      end
    end
  end
end
