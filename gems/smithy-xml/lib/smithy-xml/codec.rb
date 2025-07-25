# frozen_string_literal: true

require_relative 'builder'
require_relative 'parser'

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
      # @return [String, nil]
      def build(shape, data)
        Builder.new(@options).build(shape, data)
      end

      # @param [Shape] shape
      # @param [String] bytes
      # @param [Struct] target
      # @return [Object, nil]
      def parse(shape, bytes, target = nil)
        Parser.new(@options).parse(shape, bytes, target)
      end
    end
  end
end
