# frozen_string_literal: true

require_relative 'document_utils/deserializer'
require_relative 'document_utils/serializer'
require 'delegate'

module Smithy
  module Schema
    # A Smithy document, representing typed or untyped data from the Smithy data model.
    # The Document class delegates to the underlying data object while providing additional
    # document-specific functionality. The document will represent protocol-agnostic
    # data structures in the Smithy data model.
    #
    # This class includes capabilities for:
    #
    # - Serialization and deserialization of document data
    # - Type-aware data handling
    # - Support for JSON document format
    #
    # To create a Document using various input formats, use {create_document}
    # @example Basic usage with a document
    #   document = Document.new(name: "document")
    #   document  # => { "name" => "document" }
    class Document < ::SimpleDelegator
      # A Smithy document, representing typed or untyped data from the Smithy data model.
      # This class delegates to the underlying data object while providing additional
      # document-specific functionality.
      # @param [Object] data  document data
      # @param [Hash] options
      # @option options [String] :discriminator This value is used to identify a specific
      #  shape. This is equivalent of a Smithy shape ID.
      def initialize(data, options = {})
        @data = data
        @discriminator = options[:discriminator]
        super(@data)
      end

      # Returns the discriminator value for the document.
      #
      # @return [String, nil] discriminator
      attr_reader :discriminator

      # Serializes a {Document} with optional formatting.
      #
      # @param [TypeRegistry] type_registry Registry is required for identifying
      #  and validating typed documents
      # @param [Hash] opts Formatting options
      # @option opts [Boolean] :timestamp_format Whether to use the `timestampFormat`
      #  trait or ignore it. The `timestampFormat` trait is ignored by default.
      # @option opts [Boolean] :json_name Whether to use `jsonName` trait
      #   or just member name. The `jsonName` trait is ignored by default.
      def serialize_contents(type_registry, opts = {})
        validate_document(type_registry)

        opts[:type_registry] = type_registry
        opts[:json] = true
        serializer = DocumentUtils::Serializer.new(opts)
        serializer.format_document_data(type_registry[@discriminator], @data)
      end

      # Deserializes a {Document} into a runtime shape.
      #
      # @param [TypeRegistry, nil] type_registry Registry is required for
      #  identifying and deserializing typed documents. Either this or shape
      #  must be provided.
      # @param [StructureShape, nil] shape shape to use for deserialization.
      #  If provided, this shape takes precedence over the document's discriminator.
      #  The shape must have a type.
      def deserialize(type_registry: nil, shape: nil)
        msg = 'either a type registry or a structure shape must be provided to deserialize'
        raise ArgumentError, msg unless type_registry || shape

        type_registry.nil? ? validate_shape(shape) : validate_document(type_registry)

        shape ||= type_registry[@discriminator]
        deserializer = DocumentUtils::Deserializer.new(type_registry: type_registry)
        deserializer.deserialize(@data, shape)
      end

      private

      def validate_document(type_registry)
        msg = 'unable validate typed document - must have a discriminator'
        raise ArgumentError, msg unless @discriminator

        msg = 'document discriminator not found in type registry'
        raise ArgumentError, msg unless type_registry.key?(@discriminator)
      end

      def validate_shape(shape)
        msg = 'invalid shape - must be a structure shape with type'
        raise ArgumentError, msg unless shape.is_a?(Shapes::StructureShape) && shape.type
      end

      class << self
        # Create a {Document} from various input formats.
        #
        # @param [Object] data Input data could be one of the following: a Ruby object,
        #  a runtime shape or a parsed JSON with type discriminator key.
        # @param [TypeRegistry, nil] type_registry Type Registry is required for
        #  identifying and serializing typed documents. Option for untyped documents.
        # @return [Document] document
        #
        # @example Ruby Object as input
        #   # creating an untyped document
        #   document = Smithy::Schema::Document.create_document(foo: "bar")
        #   # => {"foo" => "bar"}
        # @example Runtime shape as input
        #   runtime_shape = some_structure.type.new(some_data)
        #   # => #<struct SampleService::Types::Structure...>
        #
        #   # Type Registry is required to properly serialize
        #   document = Smithy::Schema::Document.create_document(runtime_shape, type_registry)
        #   # => an instance of Smithy::Schema::Document
        # @example JSON data
        #   # given the following json data
        #   parsed_json = {
        #     "__type" => "smithy.ruby.tests#Structure",
        #     "string" => "hello"
        #   }
        #
        #   document = serializer.create_document(parsed_json, type_registry)
        #   # => an instance of Smithy::Schema::Document
        #   document.discriminator
        #   # => "smithy.ruby.tests#Structure"
        def create_document(data, type_registry = nil)
          raise ArgumentError, 'invalid data - document cannot be nil' if data.nil?

          return untyped_document(data) if type_registry.nil?

          validate_typed_data(data, type_registry)
          typed_document(data, type_registry)
        end

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
            opts = { type_registry: type_registry, json: true, json_name: true }
            serializer = DocumentUtils::Serializer.new(opts)
            shape = type_registry[data['__type']]
          end
          new(serializer.format_document_data(shape, data), discriminator: shape.id)
        end

        def validate_typed_data(data, type_registry)
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
