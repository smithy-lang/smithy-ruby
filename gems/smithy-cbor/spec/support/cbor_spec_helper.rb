# frozen_string_literal: true

# Helpers shared by the smithy-cbor specs:
#
# * CborSpecHelper.schema_shapes: the sample schema plus a sparse list, a map of unions and a 25-member structure.
# * CborSpecHelper.encode_cbor: generic CBOR for a Ruby value, through Encoder#add.
# * CborSpecHelper.cbor_bytes: a literal byte String, for fixtures that must not depend on the Encoder.
module CborSpecHelper
  class << self
    def schema_shapes
      SchemaHelper.sample_shapes.merge(
        'smithy.ruby.tests#SparseList' => {
          'type' => 'list', 'member' => { 'target' => 'smithy.api#String' },
          'traits' => { 'smithy.api#sparse' => {} }
        },
        'smithy.ruby.tests#UnionMap' => {
          'type' => 'map', 'key' => { 'target' => 'smithy.api#String' },
          'value' => { 'target' => 'smithy.ruby.tests#Union' }
        },
        'smithy.ruby.tests#Wide' => {
          'type' => 'structure',
          'members' => (1..25).to_h { |i| ["w#{i}", { 'target' => 'smithy.api#String' }] }
        }
      ).tap do |all|
        structure = all['smithy.ruby.tests#Structure']
        all['smithy.ruby.tests#Structure'] = structure.merge(
          'members' => structure['members'].merge(
            'sparseList' => { 'target' => 'smithy.ruby.tests#SparseList' },
            'unionMap' => { 'target' => 'smithy.ruby.tests#UnionMap' },
            'wide' => { 'target' => 'smithy.ruby.tests#Wide' }
          )
        )
      end
    end

    def encode_cbor(value)
      Smithy::Cbor::Encoder.new.add(value).bytes
    end

    # Joins byte values and the bytes of Strings into one binary String.
    def cbor_bytes(*parts)
      parts.flat_map { |part| part.is_a?(String) ? part.bytes : part }.pack('C*').force_encoding(Encoding::BINARY)
    end
  end
end
