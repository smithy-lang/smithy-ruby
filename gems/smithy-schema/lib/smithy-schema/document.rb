# frozen_string_literal: true

require_relative 'document_utils'

module Smithy
  module Schema
    # TODO: need to address the following and more
    #  * documentation
    class Document
      def initialize(data, options = {})
        @data = set_data(data, options)
        @discriminator = extract_discriminator(data, options)
      end

      attr_reader :data, :discriminator

      def [](key)
        return unless @data.is_a?(Hash) && @data.key?(key)

        @data[key]
      end

      def as_typed(schema, opts = {})
        error_message = 'Invalid schema or document data'
        raise ArgumentError, error_message unless valid_schema?(schema) && @data.is_a?(Hash)

        type = schema.type.new
        DocumentUtils.apply(@data, schema, type, opts)
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

      def set_data(data, options)
        return if data.nil?

        case data
        when Smithy::Schema::Structure
          schema = options[:schema]
          if schema.nil? || !valid_schema?(schema)
            raise ArgumentError, "Unable to convert to document with given schema: #{schema}"
          end

          options = options.except(:schema)
          # case 1 - extract data from runtime shape, schema is required to know to properly extract
          DocumentUtils.extract(data, schema, options)

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
