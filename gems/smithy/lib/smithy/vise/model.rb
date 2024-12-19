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

      # @return [Shape]
      def service
        @service ||= ServiceParser.new(@shapes).parse
      end

      # @return [Hash<String, Shape>]
      def operations
        @operations ||= OperationsParser.new(@shapes).parse(service)
      end

      private

      def parse_shapes(shapes)
        shapes.each_with_object({}) do |(id, shape), h|
          h[id] =
            case shape['type']
            when 'service'
              ServiceShape.new(id, shape)
            when 'resource'
              ResourceShape.new(id, shape)
            when 'operation'
              OperationShape.new(id, shape)
            when 'structure'
              StructureShape.new(id, shape)
            else
              Shape.new(id, shape)
            end
        end
      end
    end
  end
end
