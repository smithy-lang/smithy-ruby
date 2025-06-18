# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe DefaultParams do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
      let(:service_shape) { sample_client.const_get(:Schema).const_get(:SampleSchema) }

      let(:structure_members) { shapes['smithy.ruby.tests#Structure']['members'] }

      def validate(params, expected)
        input = service_shape.operation(:operation).input
        DefaultParams.new(input).apply(params)
        expect(params).to eq(expected)
      end

      it 'does not apply top-level defaults' do
        structure_members['string']['traits'] = { 'smithy.api#default' => 'string' }
        validate({}, {})
      end

      it 'does not apply client optional defaults' do
        structure_members['string']['traits'] = {
          'smithy.api#default' => 'string',
          'smithy.api#clientOptional' => {}
        }
        validate({ structure: {} }, { structure: {} })
      end

      it 'applies recursive defaults' do
        structure_members['string']['traits'] = { 'smithy.api#default' => 'string' }
        validate(
          { structure: { structure: {} } },
          { structure: { string: 'string', structure: { string: 'string' } } }
        )
      end

      it 'applies a blob default' do
        structure_members['blob']['traits'] = { 'smithy.api#default' => 'YmxvYg==' }
        validate({ structure: {} }, { structure: { blob: 'blob' } })
      end

      it 'applies an int enum default' do
        structure_members['intEnum']['traits'] = { 'smithy.api#default' => 123 }
        validate({ structure: {} }, { structure: { int_enum: 123 } })
      end

      context 'documents' do
        it 'applies a null default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => nil }
          validate({ structure: {} }, { structure: { document: nil } })
        end

        it 'applies a true default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => true }
          validate({ structure: {} }, { structure: { document: true } })
        end

        it 'applies a false default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => false }
          validate({ structure: {} }, { structure: { document: false } })
        end

        it 'applies a string default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => 'string' }
          validate({ structure: {} }, { structure: { document: 'string' } })
        end

        it 'applies an integer default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => 123 }
          validate({ structure: {} }, { structure: { document: 123 } })
        end

        it 'applies a float default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => 123.45 }
          validate({ structure: {} }, { structure: { document: 123.45 } })
        end

        it 'applies an empty list default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => [] }
          validate({ structure: {} }, { structure: { document: [] } })
        end

        it 'applies an empty map default' do
          structure_members['document']['traits'] = { 'smithy.api#default' => {} }
          validate({ structure: {} }, { structure: { document: {} } })
        end
      end

      it 'applies an empty list default' do
        structure_members['list']['traits'] = { 'smithy.api#default' => [] }
        validate({ structure: {} }, { structure: { list: [] } })
      end

      it 'applies an empty map default' do
        structure_members['map']['traits'] = { 'smithy.api#default' => {} }
        validate({ structure: {} }, { structure: { map: {} } })
      end

      context 'timestamps' do
        it 'applies a timestamp default as a string' do
          timestamp = '2025-08-27T00:00:00Z'
          structure_members['timestamp']['traits'] = { 'smithy.api#default' => timestamp }
          validate({ structure: {} }, { structure: { timestamp: Time.parse(timestamp) } })
        end

        it 'applies a timestamp default as an integer' do
          timestamp = 1_234_567_890
          structure_members['timestamp']['traits'] = { 'smithy.api#default' => timestamp }
          validate({ structure: {} }, { structure: { timestamp: Time.at(timestamp) } })
        end
      end
    end
  end
end
