# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Codecs
      describe CBOR do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_service) { ClientHelper.sample_service(shapes: shapes) }
        let(:service) { sample_service.const_get(:Schema).const_get(:SERVICE) }

        it 'serialize returns nil when given a unit shape' do
          expect(subject.serialize(Schema::Shapes::Prelude::Unit, '')).to be_nil
        end

        it 'deserializes returns an empty hash when given bytes are empty' do
          expect(subject.deserialize(Schema::Shapes::Prelude::String, '')).to be_empty
        end

        it 'deserializes returns an empty hash when given a unit shape' do
          expect(subject.deserialize(Schema::Shapes::Prelude::Unit, '')).to be_empty
        end

        it 'serializes and deserializes data' do
          shape = service.operation(:operation).input
          time = Time.now
          allow(Time).to receive(:at).and_return(time)
          data = {
            big_decimal: 0.0,
            big_integer: 0,
            blob: 'blob',
            boolean: false,
            byte: 0,
            double: 0.0,
            enum: 'enum',
            float: 0.0,
            int_enum: 0,
            integer: 0,
            list: [],
            long: 0,
            map: {},
            short: 0,
            streaming_blob: 'streaming blob',
            string: 'string',
            structure_list: [],
            structure_map: {},
            timestamp: time,
            union: { string: 'string' }
          }
          data = data.merge(structure: data)
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end
      end
    end
  end
end
