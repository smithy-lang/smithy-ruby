# frozen_string_literal: true

require_relative 'deserializer'
require_relative 'serializer'

module Smithy
  module CBOR
    # Codec that serializes and deserializes in CBOR format.
    # TODO:
    #   * Update implementation to handle event streams
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @options = options
      end

      # @param [Shape] shape
      # @param [Object] data
      # @return [String, nil]
      def serialize(shape, data)
        Serializer.new(@options).serialize(shape, data)
      end

      # @param [Shape] shape
      # @param [String] bytes
      # @param [Object] target
      # @return [Object]
      def deserialize(shape, bytes, target = nil)
        Deserializer.new(@options).deserialize(shape, bytes, target)
      end
    end
  end
end
