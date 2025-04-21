# frozen_string_literal: true

module Smithy
  module Schema
    # A registry that contains a map of Smithy shape ID to its shape.
    # Also includes a way to find shape based on its type representation.
    class TypeRegistry
      include Enumerable
      def initialize(registry = {})
        @registry = registry
        @shapes_by_type = register_shape_types(registry.values)
      end

      # @api private
      # @return [Hash<String, Shapes::Structure>]
      attr_accessor :registry

      # @api private
      # @return [Hash<Struct, Shapes::Structure>]
      attr_reader :shapes_by_type

      # @return [Hash<String, Shapes::Structure>]
      def each(&)
        @registry.each(&)
      end

      # @param [String] id
      # @return [Shapes::Structure, nil]
      def [](id)
        @registry[id]
      end

      def []=(id, shape)
        msg = 'Expected a shape with members and type'
        raise ArgumentError, msg unless shape.is_a?(Shapes::Structure) && shape.type

        @registry[id] = shape
        register_shape_type(shape, @shapes_by_type)
      end

      # Returns true if the registry contains specific shape id.
      # @param [String] id
      # @return [Boolean]
      def key?(id)
        @registry.key?(id)
      end

      # Returns true if the registry contains a shape associated
      #  with the given type.
      # @param [Struct] type
      # @return [Boolean]
      def shape_by_type?(type)
        @shapes_by_type.key?(type)
      end

      # Returns the shape registered for the given type.
      # @param [Struct] type
      # @return [Shapes::Structure, nil]
      def shape_by_type(type)
        @shapes_by_type[type]
      end

      private

      def register_shape_types(shapes)
        shapes.each_with_object({}) do |s, h|
          register_shape_type(s, h)
        end
      end

      def register_shape_type(shape, mapping)
        case shape
        when Shapes::StructureShape
          mapping[shape.type] = shape
        when Shapes::UnionShape
          shape.member_types.values { |v| mapping[v] = shape }
        end
      end

      class << self
        # Combines multiple registries and returns a new registry.
        # @param [Array<TypeRegistry>]
        # @return [TypeRegistry]
        def concat(*type_registries)
          raise ArgumentError, 'Expected an array of TypeRegistries' unless type_registries.all?(self)

          combined_registry = type_registries.map(&:registry).reduce({}, :merge)
          new(combined_registry)
        end
      end
    end
  end
end
