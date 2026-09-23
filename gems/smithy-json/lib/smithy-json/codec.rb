# frozen_string_literal: true

module Smithy
  module Json
    # Codec that builds and parses in JSON format.
    class Codec
      # @param [Hash] options
      def initialize(options = {})
        @builder = Builder.new(options).freeze
        @parser = Parser.new(options).freeze
      end

      # @param [Shape] shape
      # @param [Object] data
      # @return [String, nil]
      def build(shape, data)
        @builder.build(shape, data)
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
