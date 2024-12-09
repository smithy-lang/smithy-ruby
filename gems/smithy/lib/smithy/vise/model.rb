# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a Smithy model.
    class Model
      def initialize(model)
        Smithy::Weld.descendants.each { |w| w.preprocess(model) }
        @version = model['smithy']
        @shapes = parse_shapes(model['shapes'])
      end

      # @return [String]
      attr_reader :version

      # @return [Hash<String, Shape>]
      attr_reader :shapes

      private

      def parse_shapes(shapes)
        shapes.each_with_object({}) do |(id, shape), h|
          h[id] = Shape.new(id, shape)
        end
      end
    end
  end
end