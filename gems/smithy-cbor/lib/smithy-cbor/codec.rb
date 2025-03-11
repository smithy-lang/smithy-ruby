# frozen_string_literal: true

require_relative 'deserializer'
require_relative 'serializer'

module Smithy
  module CBOR
    # Codec that serializes and deserializes in CBOR format.
    # TODO:
    #   * Support handling of typed documents when it is supported
    #   * Update implementation to handle event streams
    #   * Update (de)serializing document types
    #   * Allow user to pass in their preferred type to deserialize
    #     If it fails, resort to deserializing type on the shape.
    class Codec
      include Schema::Shapes

      # @param [Hash] options
      def initialize(options = {})
        @options = options
      end

      # @param [Shape] shape
      # @param [Object] data
      # @return [String, nil] the encoded bytes in CBOR format
      def serialize(shape, data)
        Serializer.new(@options).serialize(shape, data)
      end

      # @param [Shape] shape
      # @param [String] bytes
      # @param [Struct] type
      # @return [Object, Hash]
      def deserialize(shape, bytes, type = nil)
        Deserializer.new(@options).deserialize(shape, bytes, type)
      end
    end
  end
end
