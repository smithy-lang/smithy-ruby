# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Codec do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      describe '#build' do
        it 'reuses the same codec instance across build calls without leaking builder state' do
          codec = described_class.new

          first = codec.build(structure_shape, { string: 'first' })
          second = codec.build(structure_shape, { integer: 123 })

          expect(Smithy::Json.load(first)).to eq('string' => 'first')
          expect(Smithy::Json.load(second)).to eq('integer' => 123)
        end
      end

      describe '#parse' do
        it 'reuses the same codec instance across parse calls' do
          codec = described_class.new

          first = codec.parse(structure_shape, '{"string":"first"}')
          second = codec.parse(structure_shape, '{"integer":123}')

          expect(first.to_h).to eq(string: 'first')
          expect(second.to_h).to eq(integer: 123)
        end
      end
    end
  end
end
