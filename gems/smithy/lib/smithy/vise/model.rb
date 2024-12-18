# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a Smithy model.
    class Model
      # @param [Hash] model The Smithy model as a JSON hash.
      def initialize(model)
        @version = model['smithy']
        @shapes = parse_shapes(model['shapes'])
      end

      # @return [String]
      attr_reader :version

      # @return [Hash<String, Shape>]
      attr_reader :shapes

      private

      def parse_shapes(shapes)
        @service = false
        shapes.each_with_object({}) do |(id, shape), h|
          h[id] = Shape.new(id, shape)
          # TODO: Find a better way to do this later
          raise 'Multiple service shapes found' if @service && h[id].type == 'service'

          @service = true if h[id].type == 'service'
        end
      end
    end
  end
end
