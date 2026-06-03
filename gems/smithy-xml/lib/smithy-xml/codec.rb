# frozen_string_literal: true

module Smithy
  module Xml
    # @api private
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @options = options
      end

      # @param [MemberShape, Shape] shape
      # @param [Object] data
      # @param [String, nil] target (nil)
      # @return [String, nil]
      def build(shape, data, target = nil)
        Builder.new(@options).build(shape, data, target)
      end

      # @param [MemberShape, Shape] shape
      # @param [String] bytes
      # @param [Object, nil] target (nil)
      # @return [Object, nil]
      def parse(shape, bytes, target = nil)
        Parser.new(@options).parse(shape, bytes, target)
      end
    end
  end
end
