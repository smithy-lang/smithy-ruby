# frozen_string_literal: true

# Schema and byte helpers shared by the Builder and Parser specs for input types, wide structures and malformed bodies.
module EdgeCaseHelper
  class << self
    def shapes
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
  end

  def cbor(value)
    Smithy::Cbor::Encoder.new.add(value).bytes
  end

  # Joins Strings and byte values into one binary String.
  def b(*bytes)
    bytes.flat_map { |byte| byte.is_a?(String) ? byte.bytes : byte }.pack('C*').force_encoding(Encoding::BINARY)
  end
end
