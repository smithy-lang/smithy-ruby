# frozen_string_literal: true

require_relative 'documents'

module Smithy
  module Schema
    # TODO: need to address the following and more
    #  * documentation
    class Document
      include Documents
      def initialize(data, schema = nil)
        @data = format_data(data, schema)
        @discriminator = Extractor.discriminator(data, schema)
        @schema = schema
      end

      attr_reader :data, :discriminator, :schema

      def [](key)
        return unless @data.is_a?(Hash) && @data.key?(key)

        @data[key]
      end

      def as_typed(schema)
        error_message = 'Invalid schema or document data'
        raise ArgumentError, error_message unless valid_schema?(schema) && @data.is_a?(Hash)

        type = schema.type.new
        Applier.apply(schema, @data, type)
      end

      private

      def discriminator?(data)
        data.is_a?(Hash) && data.key?('__type')
      end

      def format_data(data, schema)
        return if data.nil?

        case data
        when Smithy::Schema::Structure
          if schema.nil? || !schema.is_a?(Shapes::StructureShape)
            raise ArgumentError, 'Unable to convert as document with given schema'
          end

          Extractor.extract(schema, data)
        else
          data = data.except('__type') if discriminator?(data)
          data # TODO: add some validation if schema exists
        end
      end

      def valid_schema?(schema)
        schema.is_a?(Shapes::StructureShape) && !schema.type.nil?
      end
    end
  end
end
