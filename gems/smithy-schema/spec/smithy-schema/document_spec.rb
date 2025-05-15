# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe Document do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:type_registry) { sample_schema.const_get(:TYPE_REGISTRY) }
      let(:structure) { sample_schema.const_get(:Structure) }
      let(:typed_shape) do
        structure.type.new(
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
      let(:expected_typed_data) do
        {
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
        }
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

      describe '#serialize_contents' do
        let(:typed_document) { Document.create_document(typed_shape, type_registry) }

        it 'returns serialized data' do
          pp typed_document.discriminator
          expect(typed_document.serialize_contents(type_registry))
            .to include(expected_typed_data)
        end

        it 'applies jsonName trait to serialized data when configured' do
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'A' }
          shapes['smithy.ruby.tests#Union']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'B' }

          typed_structure = structure.type.new(string: 'hello', union: { string: 'world' })
          document = Document.create_document(typed_structure, type_registry)
          pp document
          expect(document.serialize_contents(type_registry, json_name: true)).to eq(
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
          struct = structure.type.new(
            timestamp_date_time: Time.utc(2024, 12, 25),
            timestamp_http_date: Time.utc(2024, 12, 25),
            timestamp_epoch_seconds: Time.utc(2024, 12, 25),
            timestamp_use_shape: Time.utc(2024, 12, 25)
          )
          document = Document.create_document(struct, type_registry)
          expect(document.serialize_contents(type_registry, timestamp_format: true)).to include(
            '__type' => 'smithy.ruby.tests#Structure',
            'timestampDateTime' => '2024-12-25T00:00:00Z',
            'timestampHttpDate' => 'Wed, 25 Dec 2024 00:00:00 GMT',
            'timestampEpochSeconds' => 1_735_084_800,
            'timestampUseShape' => 'Wed, 25 Dec 2024 00:00:00 GMT'
          )
        end
      end

      describe '.create_document' do
        context 'with untyped data' do
          let(:untyped_document) { Document.create_document(foo: 'bar') }

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
            doc = Document.create_document(Time.utc(2024, 12, 25))
            expect(doc).to eq(1_735_084_800)
          end

          it 'raises when given invalid data' do
            expect do
              Document.create_document(nil)
            end.to raise_error(ArgumentError)
          end
        end

        context 'with runtime shape' do
          let(:typed_document) { Document.create_document(typed_shape, type_registry) }
          let(:invalid_runtime) do
            Struct.new(:string, keyword_init: true) do
              include Smithy::Schema::Structure
            end
          end

          it 'sets data' do
            expect(typed_document.to_h).to include(expected_typed_data)
          end

          it 'sets discriminator' do
            expect(typed_document.discriminator).to eql(structure.id)
          end

          it 'raises when runtime shape not found in type registry' do
            expect do
              Document.create_document(invalid_runtime.new(string: 'foo'), type_registry)
            end.to raise_error(ArgumentError)
          end
        end

        context 'with parsed JSON input' do
          let(:json) do
            {
              '__type' => 'smithy.ruby.tests#Structure',
              'string' => 'hello'
            }
          end
          let(:document) { Document.create_document(json, type_registry) }

          it 'sets data' do
            expect(document.to_h).to include(json)
          end

          it 'sets discriminator' do
            expect(document.discriminator).to eql(structure.id)
          end

          it 'raises when discriminator not found in type registry' do
            json['__type'] = 'smithy.ruby.tests#Invalid'
            expect do
              Document.create_document(json, type_registry)
            end.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
