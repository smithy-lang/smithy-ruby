# frozen_string_literal: true

module Smithy
  module Xml
    # @api private
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @builder = Builder.new(options)
        @parser = Parser.new(options)
      end

      # @param [Shape] shape
      # @param [Object] data
      # @param [Array, nil] output (nil)
      # @return [String, nil]
      def build(shape, data, output = nil)
        @builder.build(shape, data, output)
      end

      # @param [Shape] shape
      # @param [String] bytes
      # @param [Object, nil] result (nil)
      # @return [Object, nil]
      def parse(shape, bytes, result = nil)
        @parser.parse(shape, bytes, result)
      end
    end
  end
end
