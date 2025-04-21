# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe Document do
      let(:structure_shape) { SchemaHelper.sample_schema.const_get(:Structure) }

      let(:simple_schema) do
        shape = Shapes::StructureShape.new(id: 'smithy.ruby.tests#SimpleStructure')
        string = Shapes::StringShape.new(id: 'smithy.api#String')
        shape.add_member(:string, 'string', string)
        shape.type = simple_runtime
        shape
      end

      let(:simple_runtime) do
        Struct.new(:string, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      context 'untyped document' do
        subject { Document.new(foo: 'bar') }

        describe '#initialize' do
          it 'sets data' do
            expect(subject.data).to eq('foo' => 'bar')
          end

          it 'sets time data using default format' do
            doc = Document.new(Time.utc(2024, 12, 25))
            expect(doc.data).to eq(1_735_084_800)
          end

          it 'defaults discriminator to nil' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#[]' do
          subject { Document.new({ foo: 'bar' }) }

          it 'returns member value' do
            expect(subject['foo']).to eq('bar')
          end

          it 'returns nil when member key is not applicable' do
            expect(subject['bar']).to be_nil
          end
        end

        describe '#discriminator' do
          it 'is not set' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#as_typed' do
          it 'converts document as runtime shape' do
            typed_shape = Document.new({ string: 'foo' }).as_typed(structure_shape)
            expect(typed_shape).to be_a(structure_shape.type)
            expect(typed_shape[:string]).to eq('foo')
          end

          it 'raises when invalid schema is given' do
            invalid_schema = Shapes::StringShape.new(id: 'smithy.api#Invalid')
            expect do
              subject.as_typed(invalid_schema)
            end.to raise_error(ArgumentError)
          end
        end
      end

      context 'typed document' do
        context 'when runtime shape is the input' do
          let(:typed_shape) do
            structure_shape.type.new(
              big_decimal: 0,
              big_integer: 0,
              blob: StringIO.new('foo'),
              boolean: true,
              byte: 1,
              double: 1.1,
              float: 1.1,
              enum: 'enum',
              int_enum: 0,
              integer: 1,
              long: 1,
              short: 1,
              list: %w[Item1 Item2],
              map: { color: 'red' },
              streaming_blob: 'streaming blob',
              string: 'foo',
              structure_list: [{ integer: 1 }, { integer: 2 }, { integer: 3 }],
              structure_map: { 'key' => { map: { 'color' => 'blue' } } },
              timestamp: Time.utc(2024, 12, 25),
              union: { string: 'string' }
            )
          end

          subject { Document.new(typed_shape, shape: structure_shape) }

          describe '#initialize' do
            it 'set data' do
              expect(subject.data).to include(
                {
                  'bigDecimal' => 0,
                  'bigInteger' => 0,
                  'blob' => 'Zm9v',
                  'boolean' => true,
                  'byte' => 1,
                  'double' => 1.1,
                  'float' => 1.1,
                  'enum' => 'enum',
                  'intEnum' => 0,
                  'integer' => 1,
                  'long' => 1,
                  'short' => 1,
                  'list' => %w[Item1 Item2],
                  'map' => { 'color' => 'red' },
                  'streamingBlob' => 'c3RyZWFtaW5nIGJsb2I=',
                  'string' => 'foo',
                  'structureList' => [{ 'integer' => 1 }, { 'integer' => 2 }, { 'integer' => 3 }],
                  'structureMap' => { 'key' => { 'map' => { 'color' => 'blue' } } },
                  'timestamp' => 1_735_084_800,
                  'union' => { 'string' => 'string' }
                }
              )
            end

            it 'set data using jsonName when applicable' do
              typed_shape = structure_shape.type.new(string: 'foo', union: { string: 'bar' })
              doc = Document.new(typed_shape, shape: structure_shape, use_json_name: true)
              expect(doc.data).to include({ 'jsonName' => 'foo', 'union' => { 'jsonName' => 'bar' } })
            end

            it 'set data using timestampTrait when applicable' do
              doc = Document.new(typed_shape, shape: structure_shape, use_timestamp_format: true)
              expect(doc.data['timestamp']).to eq('2024-12-25T00:00:00Z')
            end

            it 'set discriminator' do
              expect(subject.discriminator).to be(structure_shape.id)
            end

            it 'raises when no schema is given' do
              expect do
                Document.new(typed_shape)
              end.to raise_error(ArgumentError)
            end

            it 'raises when an invalid schema is provided' do
              invalid_schema = Shapes::StringShape.new(id: 'smithy.api#String')
              expect do
                Document.new(typed_shape, invalid_schema)
              end.to raise_error(ArgumentError)
            end
          end

          describe '#as_typed' do
            it 'converts document as a runtime shape' do
              typed_shape = subject.as_typed(structure_shape)
              expect(typed_shape.to_h).to include(
                {
                  big_decimal: 0,
                  big_integer: 0,
                  blob: 'foo',
                  boolean: true,
                  byte: 1,
                  double: 1.1,
                  float: 1.1,
                  enum: 'enum',
                  int_enum: 0,
                  integer: 1,
                  long: 1,
                  short: 1,
                  string: 'foo',
                  streaming_blob: 'streaming blob',
                  structure_list: [{ integer: 1 }, { integer: 2 }, { integer: 3 }],
                  structure_map: { 'key' => { map: { 'color' => 'blue' } } },
                  union: { string: 'string' },
                  timestamp: '2024-12-25T00:00:00Z'
                }
              )
            end

            it 'converts document as a runtime shape of a similar schema' do
              typed_shape = subject.as_typed(simple_schema)
              expect(typed_shape).to be_a(simple_runtime)
              expect(typed_shape[:string]).to eq('foo')
            end
          end
        end

        context 'when parsed json is the input' do
          let(:json) { <<~JSON.strip }
            {
              "__type": "foo.example#string",
              "stringMember": "hello"
            }
          JSON

          let(:subject) { Document.new(JSON.parse(json)) }

          describe '#initialize' do
            it 'sets discriminator' do
              expect(subject.discriminator).to eq('foo.example#string')
            end

            it 'data does not include a discriminator' do
              expect(subject.data).not_to include('__type')
            end
          end

          describe '#as_typed' do
            it 'converts document as a runtime shape' do
              typed_shape = subject.as_typed(simple_schema)
              expect(typed_shape).to be_a(simple_runtime)
            end
          end
        end
      end
    end
  end
end
