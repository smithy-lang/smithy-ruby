# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Document do
      let(:simple_runtime) do
        Struct.new(:string, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      let(:simple_schema) do
        shape = Shapes::StructureShape.new(id: 'smithy.ruby.tests#SimpleStructure')
        string = Shapes::StringShape.new(id: 'smithy.api#String')
        shape.add_member(:string, 'stringMember', string)
        shape.type = simple_runtime
        shape
      end

      let(:runtime) do
        Struct.new(:string, :list, :foo_map, :structure, :union, :blob, :timestamp, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      let(:union_runtime) { Class.new(Union) }
      let(:union_value_runtime) do
        Class.new(union_runtime) do
          def to_h
            { union_string: super(__getobj__) }
          end

          # anonymous class, need a class name to test to_s
          def self.name
            'TestUnion::UnionString'
          end
        end
      end

      let(:schema) do
        shape = Shapes::StructureShape.new(id: 'smithy.ruby.tests#Structure')
        string = Shapes::StringShape.new(id: 'smithy.api#String')
        list = Shapes::ListShape.new(id: 'smithy.ruby.tests#List')
        list.set_member(Shapes::Prelude::String)
        map = Shapes::MapShape.new(id: 'smithy.ruby.tests#Map')
        map.set_key(Shapes::Prelude::String)
        map.set_value(list)
        union = Shapes::UnionShape.new(id: 'smithy.ruby.tests#Union')
        union.add_member(
          :union_string,
          'unionString',
          string,
          union_value_runtime,
          traits: { 'smithy.api#jsonName' => 'json' }
        )
        union.type = union_runtime
        shape.add_member(:string, 'stringMember', string, traits: { 'smithy.api#jsonName' => 'json' })
        shape.add_member(:list, 'listMember', list)
        shape.add_member(:foo_map, 'mapMember', map)
        shape.add_member(:union, 'unionMember', union)
        shape.add_member(
          :timestamp,
          'timeMember',
          Shapes::TimestampShape.new(id: 'smithy.ruby.tests#Timestamp'),
          traits: { 'smithy.api#timestampFormat' => 'http-date' }
        )
        shape.add_member(:blob, 'blobMember', Shapes::BlobShape.new(id: 'smithy.ruby.tests#Blob'))
        shape.add_member(:structure, 'structureMember', shape)
        shape.type = runtime
        shape
      end

      context 'untyped document' do
        subject { Document.new('foo') }

        describe '#initialize' do
          it 'sets data' do
            expect(subject.data).to eq('foo')
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
            expect(subject[:foo]).to eq('bar')
          end

          it 'returns nil when member key is not applicable' do
            expect(subject[:bar]).to be_nil
          end
        end

        describe '#discriminator' do
          it 'is not set' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#as_typed' do
          it 'converts document as runtime shape' do
            typed_shape = Document.new({ string: 'foo' }).as_typed(simple_schema)
            expect(typed_shape).to be_a(simple_runtime)
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
            runtime.new(
              string: 'foo',
              list: %w[Item1 Item2],
              foo_map: { foo: ['Thing1'], bar: ['Thing2'] },
              structure: { list: ['AnotherThing'] },
              union: { union_string: 'hello world' },
              timestamp: Time.utc(2024, 12, 25),
              blob: StringIO.new('foo')
            )
          end

          subject { Document.new(typed_shape, schema: schema) }

          describe '#initialize' do
            it 'set data' do
              expect(subject.data).to include(
                {
                  'stringMember' => 'foo',
                  'listMember' => %w[Item1 Item2],
                  'mapMember' => { foo: ['Thing1'], bar: ['Thing2'] },
                  'structureMember' => { 'listMember' => ['AnotherThing'] },
                  'unionMember' => { 'unionString' => 'hello world' },
                  'timeMember' => 1_735_084_800,
                  'blobMember' => 'Zm9v'
                }
              )
            end

            it 'set data using jsonName when applicable' do
              typed_shape = runtime.new(string: 'foo', union: { union_string: 'bar' })
              doc = Document.new(typed_shape, schema: schema, use_json_name: true)
              expect(doc.data).to include({ 'json' => 'foo', 'unionMember' => { 'json' => 'bar' } })
            end

            it 'set data using timestampTrait when applicable' do
              doc = Document.new(typed_shape, schema: schema, use_timestamp_format: true)
              expect(doc.data['timeMember']).to eq('2024-12-25T00:00:00Z')
            end

            it 'set discriminator' do
              expect(subject.discriminator).to be(schema.id)
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
              typed_shape = subject.as_typed(schema)
              expect(typed_shape.to_h).to include(
                {
                  string: 'foo',
                  list: %w[Item1 Item2],
                  foo_map: { foo: ['Thing1'], bar: ['Thing2'] },
                  structure: { list: ['AnotherThing'] },
                  union: { union_string: 'hello world' },
                  timestamp: 1_735_084_800,
                  blob: 'foo'
                }
              )
            end

            it 'converts document as a runtime shape of a similar schema' do
              typed_shape = subject.as_typed(simple_schema)
              expect(typed_shape).to be_a(simple_runtime)
              expect(typed_shape[:string]).to eq('foo')
            end

            it 'converts document with jsonName trait as a runtime shape' do
              typed_shape = runtime.new(string: 'foo', union: { union_string: 'bar' })
              doc = Document.new(typed_shape, schema: schema, use_json_name: true).as_typed(schema)
              expect(doc.string).to eq('foo')
              expect(doc.union.value).to eq('bar')
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
