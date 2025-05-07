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

      context 'SERDE test cases' do # don't look ... its not ready >_<
        tests = JSON.load_file(File.expand_path('../fixtures/documents/test-cases.json', __dir__.to_s))
        let(:test_model) { JSON.load_file(File.expand_path('../fixtures/documents/model.json', __dir__.to_s)) }
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
