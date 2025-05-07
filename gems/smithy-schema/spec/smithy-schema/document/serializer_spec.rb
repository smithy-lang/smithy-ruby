# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../support/schema_helper'

module Smithy
  module Schema
    module Document
      describe Serializer do
        let(:shapes) do
          shapes = SchemaHelper.sample_shapes
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
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'A' }
          shapes['smithy.ruby.tests#Union']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'B' }
          shapes
        end
        let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
        let(:type_registry) { sample_schema.const_get(:TYPE_REGISTRY) }
        let(:structure_shape) { sample_schema.const_get(:Structure) }
        let(:typed_shape) do
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

        subject { Document::Serializer.new(type_registry) }
        let(:typed_document) { subject.create_document(typed_shape) }
        let(:untyped_document) { subject.create_document(foo: 'bar') }

        describe '#create_document' do
          context 'with untyped data' do
            it 'returns a document data' do
              expect(untyped_document).to be_a_kind_of(Data)
            end

            it 'sets data' do
              expect(untyped_document.data).to eq('foo' => 'bar')
            end

            it 'sets discriminator to nil' do
              expect(untyped_document.discriminator).to be_nil
            end

            it 'sets time data using default timestamp format' do
              doc = subject.create_document(Time.utc(2024, 12, 25))
              expect(doc.data).to eq(1_735_084_800)
            end

            it 'raises when given invalid data' do
              expect do
                subject.create_document(nil)
              end.to raise_error(ArgumentError)
            end
          end

          context 'with runtime shape' do
            let(:invalid_runtime) do
              Struct.new(:string, keyword_init: true) do
                include Smithy::Schema::Structure
              end
            end

            it 'sets data' do
              expect(typed_document.data).to include(expected_typed_data)
            end

            it 'sets discriminator' do
              expect(typed_document.discriminator).to eql(structure_shape.id)
            end

            it 'raises when runtime shape not found in type registry' do
              expect do
                subject.create_document(invalid_runtime.new(string: 'foo'))
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
            let(:document) { subject.create_document(json) }

            it 'sets data' do
              expect(document.data).to include(json)
            end

            it 'sets discriminator' do
              expect(document.discriminator).to eql(structure_shape.id)
            end

            it 'raises when discriminator not found in type registry' do
              json['__type'] = 'smithy.ruby.tests#Invalid'
              expect do
                subject.create_document(json)
              end.to raise_error(ArgumentError)
            end
          end
        end

        describe '#serialize_document' do
          it 'returns serialized data' do
            expect(subject.serialize_document(typed_document))
              .to include(expected_typed_data)
          end

          it 'applies jsonName trait to serialized data when configured' do
            document = subject.create_document(structure_shape.type.new(string: 'hello', union: { string: 'world' }))
            expect(subject.serialize_document(document, use_json_name: true)).to include(
              '__type' => 'smithy.ruby.tests#Structure',
              'A' => 'hello',
              'union' => { 'B' => 'world' }
            )
          end

          it 'applies timestampFormat trait to serialized data when configured' do
            struct = structure_shape.type.new(
              timestamp_date_time: Time.utc(2024, 12, 25),
              timestamp_http_date: Time.utc(2024, 12, 25),
              timestamp_epoch_seconds: Time.utc(2024, 12, 25),
              timestamp_use_shape: Time.utc(2024, 12, 25)
            )
            document = subject.create_document(struct)
            expect(subject.serialize_document(document, use_timestamp_format: true)).to include(
              '__type' => 'smithy.ruby.tests#Structure',
              'timestampDateTime' => '2024-12-25T00:00:00Z',
              'timestampHttpDate' => 'Wed, 25 Dec 2024 00:00:00 GMT',
              'timestampEpochSeconds' => 1_735_084_800,
              'timestampUseShape' => 'Wed, 25 Dec 2024 00:00:00 GMT'
            )
          end

          it 'raises when an invalid document is given' do
            expect do
              subject.serialize_document('foo')
            end.to raise_error(ArgumentError)
            expect do
              subject.serialize_document(untyped_document)
            end.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
