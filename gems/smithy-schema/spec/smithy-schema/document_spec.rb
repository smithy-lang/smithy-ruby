# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe Document do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:type_registry) { sample_schema.type_registry }
      let(:structure_shape) { sample_schema.const_get(:Structure) }
      let(:type) do
        structure_shape.type.new(
          big_decimal: 0,
          big_integer: 0,
          blob: StringIO.new('foo'),
          boolean: true,
          byte: 1,
          document: true,
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

      subject { Document.new({ 'foo' => 'bar' }) }

      describe '#initialize' do
        it 'sets data' do
          expect(subject).to eq('foo' => 'bar')
        end

        it 'defaults discriminator to nil' do
          expect(subject.discriminator).to be_nil
        end
      end

      describe '#[]' do
        it 'returns member value' do
          expect(subject['foo']).to eq('bar')
        end

        it 'returns nil when member is not applicable' do
          expect(subject['bar']).to be_nil
        end
      end

      describe '#discriminator' do
        it 'is not set' do
          expect(subject.discriminator).to be_nil
        end
      end

      describe '#serialize' do
        let(:typed_document) { Document.create(type, type_registry) }

        it 'returns serialized data' do
          expect(typed_document.serialize(type_registry))
            .to include(
              '__type' => 'smithy.ruby.tests#Structure',
              'bigDecimal' => 0,
              'bigInteger' => 0,
              'blob' => 'Zm9v',
              'boolean' => true,
              'byte' => 1,
              'document' => true,
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
            )
        end

        it 'applies jsonName trait to serialized data when configured' do
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'A' }
          shapes['smithy.ruby.tests#Union']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'B' }

          typed_structure = structure_shape.type.new(string: 'hello', union: { string: 'world' })
          document = Document.create(typed_structure, type_registry)
          expect(document.serialize(type_registry).to eq(
            '__type' => 'smithy.ruby.tests#Structure',
            'A' => 'hello',
            'union' => { 'B' => 'world' }
          )
        end

        it 'applies timestampFormat trait to serialized data when configured' do
          shapes['smithy.ruby.tests#Structure']['members']['timestampDateTime'] = {
            'target' => 'smithy.api#Timestamp', 'traits' => { 'smithy.api#timestampFormat' => 'date-time' }
          }
          shapes['smithy.ruby.tests#Structure']['members']['timestampHttpDate'] = {
            'target' => 'smithy.api#Timestamp', 'traits' => { 'smithy.api#timestampFormat' => 'http-date' }
          }
          shapes['smithy.ruby.tests#Structure']['members']['timestampEpochSeconds'] = {
            'target' => 'smithy.api#Timestamp', 'traits' => { 'smithy.api#timestampFormat' => 'epoch-seconds' }
          }
          shapes['smithy.ruby.tests#Structure']['members']['timestampUseShape'] = {
            'target' => 'smithy.ruby.tests#TimestampUseShape'
          }
          shapes['smithy.ruby.tests#TimestampUseShape'] = {
            'type' => 'timestamp', 'traits' => { 'smithy.api#timestampFormat' => 'http-date' }
          }
          struct = structure_shape.type.new(
            timestamp_date_time: Time.utc(2024, 12, 25),
            timestamp_http_date: Time.utc(2024, 12, 25),
            timestamp_epoch_seconds: Time.utc(2024, 12, 25),
            timestamp_use_shape: Time.utc(2024, 12, 25)
          )
          document = Document.create(struct, type_registry)
          expect(document.serialize(type_registry, timestamp_format: true)).to include(
            '__type' => 'smithy.ruby.tests#Structure',
            'timestampDateTime' => '2024-12-25T00:00:00Z',
            'timestampHttpDate' => 'Wed, 25 Dec 2024 00:00:00 GMT',
            'timestampEpochSeconds' => 1_735_084_800,
            'timestampUseShape' => 'Wed, 25 Dec 2024 00:00:00 GMT'
          )
        end
      end

      describe '#deserialize' do
        let(:typed_document) { Document.create(type, type_registry) }

        it 'deserializes document into correct type using discriminator' do
          structure = typed_document.deserialize(type_registry: type_registry)
          expect(structure).to be_a_kind_of(Structure)
          expect(structure).to be_an_instance_of(structure_shape.type)
          expect(structure.to_h).to eq(
            big_decimal: 0,
            big_integer: 0,
            blob: 'foo',
            boolean: true,
            byte: 1,
            double: 1.1,
            enum: 'enum',
            float: 1.1,
            int_enum: 0,
            integer: 1,
            list: %w[Item1 Item2],
            long: 1,
            map: { 'color' => 'red' },
            document: true,
            short: 1,
            streaming_blob: 'streaming blob',
            structure_list: [{ integer: 1 }, { integer: 2 }, { integer: 3 }],
            structure_map: { 'key' => { map: { 'color' => 'blue' } } },
            string: 'foo',
            timestamp: Time.at(1_735_084_800).utc,
            union: { string: 'string' }
          )
        end

        it 'prioritizes provided shape over document discriminator when deserializing' do
          shapes['smithy.ruby.tests#Foo'] = shapes['smithy.ruby.tests#Structure']
          shapes['smithy.ruby.tests#Structure']['members']['foo'] =
            { 'target' => 'smithy.ruby.tests#Foo' }

          another_shape = sample_schema.const_get(:Foo)
          structure = typed_document.deserialize(shape: another_shape)
          expect(structure).to be_a_kind_of(Structure)
          expect(structure).to be_an_instance_of(another_shape.type)
        end
      end

      describe '.create' do
        context 'with untyped data' do
          let(:untyped_document) { Document.create(foo: 'bar') }

          it 'returns a document data' do
            expect(untyped_document).to be_a_kind_of(Document)
          end

          it 'sets data' do
            expect(untyped_document.to_h).to eq('foo' => 'bar')
          end

          it 'sets discriminator to nil' do
            expect(untyped_document.discriminator).to be_nil
          end

          it 'sets time data using default timestamp format' do
            doc = Document.create(Time.utc(2024, 12, 25))
            expect(doc).to eq(1_735_084_800)
          end

          it 'raises when given invalid data' do
            expect do
              Document.create(nil)
            end.to raise_error(ArgumentError)
          end
        end

        context 'with a type class' do
          let(:typed_document) { Document.create(type, type_registry) }
          let(:unregistered_type) do
            Struct.new(keyword_init: true) do
              include Smithy::Schema::Structure
            end
          end

          it 'sets data' do
            expect(typed_document.to_h).to include(
              '__type' => 'smithy.ruby.tests#Structure',
              'bigDecimal' => 0,
              'bigInteger' => 0,
              'blob' => 'Zm9v',
              'boolean' => true,
              'byte' => 1,
              'document' => true,
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
            )
          end

          it 'sets discriminator' do
            expect(typed_document.discriminator).to eql(structure_shape.id)
          end

          it 'raises when the type class is not found in type registry' do
            expect do
              Document.create(unregistered_type.new, type_registry)
            end.to raise_error(ArgumentError)
          end
        end

        context 'with parsed JSON input' do
          let(:json) { { '__type' => 'smithy.ruby.tests#Structure', 'string' => 'hello' } }
          let(:document) { Document.create(json, type_registry) }

          it 'sets data' do
            expect(document.to_h).to include(json)
          end

          it 'sets discriminator' do
            expect(document.discriminator).to eql(structure_shape.id)
          end

          it 'raises when discriminator not found in type registry' do
            json['__type'] = 'smithy.ruby.tests#Invalid'
            expect do
              Document.create(json, type_registry)
            end.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
