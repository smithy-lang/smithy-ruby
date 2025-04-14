# frozen_string_literal: true

require_relative 'document_utils'

module Smithy
  module Schema
    # A Smithy document type, representing typed or untyped data from Smithy data model.
    class Document
      # @param  [Object] data  document data
      # @param [Hash] options
      # @option options [Smithy::Schema::Structure] :schema schema to reference when setting
      #  document data. Only applicable when data param is a type of {Shapes::StructureShape}.
      # @option options [Boolean] :use_timestamp_format Whether to use the `timestampFormat`
      #  trait or ignore it when creating a {Document} with given schema. The `timestampFormat`
      #  trait is ignored by default.
      # @option options [Boolean] :use_json_name Whether to use the `jsonName` trait or ignore
      #  it when creating a {Document} with given schema. The `jsonName` trait is ignored
      #  by default.
      def initialize(data, options = {})
        @data = set_data(data, options)
        @discriminator = extract_discriminator(data, options)
      end

      # @return [Object] data
      attr_reader :data

      # @return [String] discriminator
      attr_reader :discriminator

      # @param [Object] key
      # @return [Object]
      def [](key)
        return unless @data.is_a?(Hash) && @data.key?(key)

        @data[key]
      end

      # @param [Shapes::Shape] schema
      # @return [Shapes::Structure] typed shape
      def as_typed(schema)
        error_message = 'Invalid schema or document data'
        raise ArgumentError, error_message unless valid_schema?(schema) && @data.is_a?(Hash)

        type = schema.type.new
        DocumentUtils.apply(@data, schema, type)
      end

      private

      def discriminator?(data)
        data.is_a?(Hash) && data.key?('__type')
      end

      def extract_discriminator(data, opts)
        return if data.nil?

        return unless discriminator?(data) || (schema = opts[:schema])

        if discriminator?(data)
          data['__type']
        else
          error_message = "Expected a structure schema, given #{schema.class} instead"
          raise error_message unless valid_schema?(schema)

          schema.id
        end
      end

      def set_data(data, opts)
        return if data.nil?

        case data
        when Smithy::Schema::Structure
          schema = opts[:schema]
          if schema.nil? || !valid_schema?(schema)
            raise ArgumentError, "Unable to create a document with given schema: #{schema}"
          end

          opts = opts.except(:schema)
          # case 1 - extract data from runtime shape, schema is required to know to properly extract
          DocumentUtils.extract(data, schema, opts)

        else
          if discriminator?(data)
            # case 2 - extract typed data from parsed JSON
            data.except('__type')
          else
            # case 3 - untyped data, we will need consolidate timestamps and such
            DocumentUtils.format(data)
          end
        end
      end

      def valid_schema?(schema)
        schema.is_a?(Shapes::StructureShape) && !schema.type.nil?
      end
    end
  end
end
