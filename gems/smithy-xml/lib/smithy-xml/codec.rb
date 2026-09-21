# frozen_string_literal: true

module Smithy
  module Xml
    # @api private
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @options = options
      end

      # @param [Shape] shape
      # @param [Object] data
      # @param [Array, nil] output (nil)
      # @return [String, nil]
      def build(shape, data, output = nil)
        Builder.new(@options).build(shape, data, output)
      end

      # @param [Shape] shape
      # @param [String] bytes
      # @param [Object, nil] result (nil)
      # @return [Object, nil]
      def parse(shape, bytes, result = nil)
        Parser.new(@options).parse(shape, bytes, result)
      end
    end
  end
end
