# frozen_string_literal: true

require_relative 'document_utils'

module Smithy
  module Schema
    # A Smithy document type, representing typed or untyped data from Smithy data model.
    # ## Document types
    # Document types are protocol-agnostic view of untyped data. They could be combined
    # with a shape to serialize its contents.
    #
    # Smithy-Ruby currently only support JSON documents.
    class Document
      # @param  [Object] data  document data
      # @param [Hash] options
      # @option options [Smithy::Schema::Structure] :shape shape to reference when setting
      #  document data. Only applicable when data param is a type of {Shapes::StructureShape}.
      # @option options [Boolean] :use_timestamp_format Whether to use the `timestampFormat`
      #  trait or ignore it when creating a {Document} with given shape. The `timestampFormat`
      #  trait is ignored by default.
      # @option options [Boolean] :use_json_name Whether to use the `jsonName` trait or ignore
      #  it when creating a {Document} with given shape. The `jsonName` trait is ignored
      #  by default.
      def initialize(data, options = {})
        @data = set_data(data, options)
        @discriminator = extract_discriminator(data, options)
      end

      # @return [Object] data
      attr_reader :data

      # @return [String] discriminator
      attr_reader :discriminator

      # @param [String] key
      # @return [Object]
      def [](key)
        return unless @data.is_a?(Hash) && @data.key?(key)

        @data[key]
      end

      # @param [Shapes::Structure] shape
      # @return [Object] typed shape
      def as_typed(shape)
        error_message = 'Invalid shape or document data'
        raise ArgumentError, error_message unless valid_shape?(shape) && @data.is_a?(Hash)

        type = shape.type.new
        DocumentUtils.apply(@data, shape, type)
      end

      private

      def discriminator?(data)
        data.is_a?(Hash) && data.key?('__type')
      end

      def extract_discriminator(data, opts)
        return if data.nil?

        return unless discriminator?(data) || (shape = opts[:shape])

        if discriminator?(data)
          data['__type']
        else
          error_message = "Expected a structure shape, given #{shape.class} instead"
          raise error_message unless valid_shape?(shape)

          shape.id
        end
      end

      def set_data(data, opts)
        return if data.nil?

        case data
        when Smithy::Schema::Structure
          shape = opts[:shape]
          if shape.nil? || !valid_shape?(shape)
            raise ArgumentError, "Unable to create a document with given shape: #{shape}"
          end

          opts = opts.except(:shape)
          DocumentUtils.extract(data, shape, opts)
        else
          if discriminator?(data)
            data.except('__type')
          else
            DocumentUtils.format(data)
          end
        end
      end

      def valid_shape?(shape)
        shape.is_a?(Shapes::StructureShape) && !shape.type.nil?
      end
    end
  end
end
