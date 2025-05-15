# frozen_string_literal: true

require_relative 'document_utils/deserializer'
require_relative 'document_utils/serializer'
require 'delegate'

module Smithy
  module Schema
    # A Smithy document, representing typed or untyped data from the Smithy data model.
    # The Data class delegates to the underlying data object while providing additional
    # document-specific functionality.
    #
    # The module provides functionality for handling Smithy document types,
    # which represent protocol-agnostic data structures in the Smithy data model.
    #
    # This module includes capabilities for:
    # * Serialization and deserialization of document data
    # * Type-aware data handling
    # * Support for JSON document format
    #
    # @example Basic usage with a document
    #   data = Document::Data.new({ name: "document" })
    #   data.data  # => { "name" => "example" }
    #
    # @example Using with a shape
    #   shape = Smithy::Schema::StructureShape.new
    #   data = Document::Data.new({ "name" => "example" }, shape: shape)
    #
    class Document < ::SimpleDelegator
      # A Smithy document, representing typed or untyped data from the Smithy data model.
      # The Data class delegates to the underlying data object while providing additional
      # document-specific functionality.
      # @param [Object | Hash] data  document data that is in JSON-friendly format
      # @param [Hash] options
      # @option options [String] :discriminator This value is used to identify a specific
      # shape. This is equivalent of a Smithy shape ID.
      def initialize(data, options = {})
        @data = data
        @discriminator = options[:discriminator]
        super(@data)
      end

      # Returns the discriminator value for the document
      #
      # @return [String. nil] discriminator
      attr_reader :discriminator

      # Serializes a document data with optional formatting.
      # @param [TypeRegistry] type_registry TODO
      # @param [Hash] opts serialization options
      # @option opts [Boolean] :use_timestamp_format Whether to use the
      #  `timestampFormat` trait or ignore it. The `timestampFormat` trait
      #   is ignored by default.
      # @option opts [Boolean] :use_json_name Whether to use `jsonName` trait
      #   or just member name. The `jsonName` trait is ignored by default.
      def serialize_contents(type_registry, opts = {})
        validate_document(type_registry)

        opts[:discriminator] = true
        serializer = DocumentUtils::Serializer.new(opts)
        serializer.format_document_data(type_registry[@discriminator], @data)
      end

      private

      def validate_document(type_registry)
        msg = 'unable to serialize typed document - must have a discriminator'
        raise ArgumentError, msg unless @discriminator

        msg = 'document discriminator not found in type registry'
        raise ArgumentError, msg unless type_registry.key?(@discriminator)
      end

      class << self

        # Create document data from various input data formats
        # @param [Object] data Input data can be: Ruby objects, instance of a runtime shape or a
        #  JSON response with type discriminator.
        # @return [Document] document data
        #
        # @example Ruby objects as input
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # ruby objects as input
        #   serializer.create_document(foo: "bar")
        #   # => {"foo" => "bar"}
        # @example Runtime shape as input
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # given the following runtime shape
        #   runtime_shape = some_structure.new.type(some_data)
        #   # => #<struct SampleService::Types::Structure...>
        #
        #   serializer.create_document(runtime_shape)
        #   # => an instance of Smithy::Schema::Document::Data
        # @example JSON data
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # given the following json data
        #   parsed_json = {
        #     "__type" => "smithy.ruby.tests#Structure",
        #     "string" => "hello"
        #   }
        #
        #   document = serializer.create_document(parsed_json)
        #   # => an instance of Smithy::Schema::Document::Data
        #   document.discriminator
        #   # => "smithy.ruby.tests#Structure"
        def create_document(data, type_registry = nil)
          raise ArgumentError, 'invalid data - document cannot be nil' if data.nil?

          return untyped_document(data) if type_registry.nil?

          validate_typed_data(data, type_registry)
          typed_document(data, type_registry)
        end

        def serialize_document(); end

        def deserialize_document; end

        private

        def discriminator?(data)
          data.is_a?(Hash) && data.key?('__type')
        end

        def untyped_document(data)
          serializer = DocumentUtils::Serializer.new
          new(serializer.serialize_untyped(data))
        end

        def typed_document(data, type_registry)
          case data
          when Smithy::Schema::Structure
            serializer = DocumentUtils::Serializer.new(type_registry: type_registry)
            shape = type_registry.shape_by_type(data.class)
          else
            opts = { type_registry: type_registry, discriminator: true, json_name: true }
            serializer = DocumentUtils::Serializer.new(opts)
            shape = type_registry[data['__type']]
          end
          new(serializer.format_document_data(shape, data), discriminator: shape.id)
        end

        def validate_typed_data(data, type_registry)
          raise ArgumentError, 'must provide a type registry to create a typed document' if type_registry.nil?

          case data
          when Schema::Structure
            msg = 'given runtime shape not found in type registry'
            raise ArgumentError, msg unless type_registry.shape_by_type?(data.class)
          else
            msg = 'document discriminator not found in type registry'
            raise ArgumentError, msg if discriminator?(data) && !type_registry.key?(data['__type'])
          end
        end


      end
    end
  end
end
