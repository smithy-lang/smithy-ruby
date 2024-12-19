# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a Smithy model.
    class Model
      # @api private
      SHAPE_CLASSES = {
        'enum' => EnumShape,
        'intEnum' => IntEnumShape,
        'list' => ListShape,
        'map' => MapShape,
        'operation' => OperationShape,
        'resource' => ResourceShape,
        'service' => ServiceShape,
        'structure' => StructureShape,
        'union' => UnionShape
      }.freeze

      # @param [Hash] model The Smithy model as a JSON hash.
      def initialize(model)
        @version = model['smithy']
        @shapes = build_shapes(model['shapes'])
      end

      # @return [String]
      attr_reader :version

      # @return [Hash<String, Shape>]
      attr_reader :shapes

      # @return [Shape]
      def service
        @service ||= ServiceParser.new(@shapes).parse
      end

      # @return [Hash<String, Shape>]
      def operations
        @operations ||= OperationsParser.new(@shapes).parse(service)
      end

      private

      def build_shapes(shapes)
        shapes.each_with_object({}) do |(id, shape), h|
          klass = SHAPE_CLASSES[shape['type']] || Shape
          h[id] = klass.new(id, shape)
        end
      end
    end
  end
end
