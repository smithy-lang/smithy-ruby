# frozen_string_literal: true

module Smithy
  module Json
    # @api private
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @options = options
      end

      # @param [ShapeRef, Shape] shape
      # @param [Object] data
      # @return [String, nil]
      def build(shape, data)
        Builder.new(@options).build(shape, data)
      end

      # @param [ShapeRef, Shape] shape
      # @param [String] bytes
      # @param [Object, nil] target (nil)
      # @return [Object, nil]
      def parse(shape, bytes, target = nil)
        Parser.new(@options).parse(shape, bytes, target)
      end
    end
  end
end
