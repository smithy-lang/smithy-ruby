# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    module Document
      describe Data do
        subject { Data.new({ 'foo' => 'bar' }) }

        describe '#initialize' do
          it 'sets data' do
            expect(subject.data).to eq('foo' => 'bar')
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
      end

      describe Serializer do
        let(:shapes) { SchemaHelper.sample_shapes }
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
          context 'untyped input' do
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
          end

          context 'runtime shape input' do
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

            it 'raises when runtime shape is not found in type registry' do
              expect do
                subject.create_document(invalid_runtime.new(string: 'foo'))
              end.to raise_error(ArgumentError)
            end
          end

          context 'parsed json input' do
            let(:json) do
              {
                '__type' => 'smithy.ruby.tests#Structure',
                'string' => 'hello'
              }
            end

            let(:document) { subject.create_document(json) }

            it 'sets data' do
              expect(document.data).to include(
                {
                  '__type' => 'smithy.ruby.tests#Structure',
                  'string' => 'hello'
                }
              )
            end

            it 'sets discriminator' do
              expect(document.discriminator).to eql(structure_shape.id)
            end

            it 'raises when discriminator is not found in type registry' do
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

          it 'returns serialized data with jsonName when applicable' do
            shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'A' }
            shapes['smithy.ruby.tests#Union']['members']['string']['traits'] = { 'smithy.api#jsonName' => 'B' }

            document = subject.create_document(structure_shape.type.new(string: 'hello', union: { string: 'world' }))
            expect(subject.serialize_document(document, use_json_name: true)).to include(
              '__type' => 'smithy.ruby.tests#Structure',
              'A' => 'hello',
              'union' => { 'B' => 'world' }
            )
          end

          it 'returns serialized data with timestampTrait when applicable' do
            shapes['smithy.ruby.tests#Structure']['members']['timestampDateTime'] = {
              'target' => 'smithy.api#Timestamp',
              'traits' => { 'smithy.api#timestampFormat' => 'date-time' }
            }
            shapes['smithy.ruby.tests#Structure']['members']['timestampHttpDate'] = {
              'target' => 'smithy.api#Timestamp',
              'traits' => { 'smithy.api#timestampFormat' => 'http-date' }
            }
            shapes['smithy.ruby.tests#Structure']['members']['timestampEpochSeconds'] = {
              'target' => 'smithy.api#Timestamp',
              'traits' => { 'smithy.api#timestampFormat' => 'epoch-seconds' }
            }
            shapes['smithy.ruby.tests#Structure']['members']['timestampUseShape'] = {
              'target' => 'smithy.ruby.tests#TimestampUseShape'
            }
            shapes['smithy.ruby.tests#TimestampUseShape'] = {
              'type' => 'timestamp',
              'traits' => { 'smithy.api#timestampFormat' => 'http-date' }
            }

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

          it 'raises when discriminator cannot be found in type registry' do
            # TODO
          end
        end
      end

      describe Deserializer do
        it 'TBD' do
          # TODO
        end
      end

      context 'SERDE test cases' do # don't look ... its not ready >_<
        tests = JSON.load_file(File.expand_path('../fixtures/typed-documents/test-cases.json', __dir__.to_s))
        let(:test_model) { JSON.load_file(File.expand_path('../fixtures/typed-documents/model.json', __dir__.to_s)) }
        let(:schema) { SchemaHelper.sample_schema(model: test_model) }
        let(:structure_shape) { schema.const_get(:OmniWidget) }
        let(:type_registry) { schema.const_get(:TYPE_REGISTRY) }

        # def create_runtime_shape(data, shape)
        #   Document.new(data, shape: shape).as_typed(shape)
        # end

        # def document_options(settings)
        #   settings.each_with_object({}) do |(k, v), o|
        #     case k
        #     when 'jsonName'
        #       o[:disable_json_name] = true if v == false
        #     when 'timestampFormat'
        #       o[:disable_timestamp_format] = true if v['useTrait'] == false
        #     end
        #   end
        # end

        tests['serdeTests'].each do |test_case|
          context "Case: #{test_case['name']}" do
            # let(:data_object) { create_runtime_shape(test_case['deserialized'], structure_shape) }
            # let(:document_object) { Document.new(test_case['serialized'], shape: structure_shape) }
            # let(:serialized_data) { test_case['serialized'] }
            # let(:settings) { document_options(test_case['settings']) }

            it 'when data object is converted to a Document, it deeply equals the document object' do
              # document = Document.new(data_object, shape: structure_shape)
              # expect(document.data).to eq(document_object.data)
            end

            it 'when document object is deserialized, it deeply equals data object' do
              # expect(document_object.as_typed(structure_shape).to_h).to eq(data_object.to_h)
            end

            it 'when data object is serialized, it equals serialized data' do
              # document = Document.new(data_object, shape: structure_shape)
              # expect(document.as_json(structure_shape, settings)).to eq(serialized_data.except('__type'))
            end

            it 'when serialized data is deserialized, it equals data object' do
              # document = Document.new(serialized_data, shape: structure_shape)
              # expect(document.as_typed(structure_shape).to_h).to eq(data_object.to_h)
            end

            it 'when document object is serialized, it equals serialized data' do
              # serialized_document = document_object.as_json(structure_shape, settings)
              # expect(serialized_document).to eq(serialized_data.except('__type'))
            end

            # Assert that the serialized test data (3) can be parsed into a document (2)
            it 'serialized data can be parsed into document' do
              # expect(document_object).to be_an_instance_of(Document)
            end
          end
        end
      end
    end
  end
end
