# frozen_string_literal: true

require_relative 'document/deserializer'
require_relative 'document/serializer'
require 'delegate'

module Smithy
  module Schema
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
    module Document
      # A Smithy document, representing typed or untyped data from the Smithy data model.
      # The Data class delegates to the underlying data object while providing additional
      # document-specific functionality.
      class Data < ::SimpleDelegator
        # @param [Object] data  document data that is in JSON-friendly format
        # @param [Hash] options
        # @option options [String] :discriminator This value is used to identify a specific
        # shape. This is equivalent of a Smithy shape ID.
        def initialize(data, options = {})
          @data = data
          super(@data)
          @discriminator = options[:discriminator]
        end

        # Returns the discriminator value for the document
        #
        # @return [String. nil] discriminator
        attr_reader :discriminator

        def data
          __getobj__
        end
      end
    end
  end
end
