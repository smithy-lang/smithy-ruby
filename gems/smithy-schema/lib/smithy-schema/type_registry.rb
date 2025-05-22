# frozen_string_literal: true

module Smithy
  module Schema
    # A registry that contains a map of Smithy shape ID to its shape defined in a schema.
    # The registered shapes are limited to {Shapes::StructureShape} with a type.
    #
    # This registry has the following functionalities:
    #
    # * Access shape by shape ID
    # * Access shape by its type
    # * Register shape to the Registry
    # * Supports enumeration of registered shapes
    #
    # You could also combine multiple registries into one {TypeRegistry}.
    #
    # @example Creating a new Registry
    #  # accepts an array of structure shapes
    #  registry = TypeRegistry.new(StructureShape1, StructureShape2)
    #
    # @example Shape Lookup
    #  # Find shape by its id
    #  registry["someId"]
    #  # => #<Smithy::Schema::Shapes::StructureShape...>
    #
    #  # Find shape by its type
    #  registry.shape_by_type(ExampleService::Types::Structure)
    #  # => #<Smithy::Schema::Shapes::StructureShape...>
    #
    # @example Combining multiple registries
    #  registry.concat(registry1, registry2)
    #  # => #<Smithy::Schema::TypeRegistry...>
    class TypeRegistry
      include Enumerable

      # @param [Array<Shapes::StructureShape>] shapes
      def initialize(shapes = [])
        @registry, @shapes_by_type = register_shapes(shapes)
      end

      # @return [Hash<String, Shapes::StructureShape>]
      def each(&)
        @registry.each(&)
      end

      # @param [String] id
      # @return [Shapes::StructureShape, nil]
      def [](id)
        @registry[id]
      end

      # @param [String] id
      # @param [Shapes::StructureShape] shape
      def []=(id, shape)
        validate_shape(shape)
        @registry[id] = shape
        @shapes_by_type[shape.type] = shape
      end

      def key?(id)
        @registry.key?(id)
      end

      # @return [Array<String>]
      def keys
        @registry.keys
      end

      # @return [Array<Shape::StructureShape>]
      def values
        @registry.values
      end

      def shape_by_type?(type)
        @shapes_by_type.key?(type)
      end

      # Returns the shape registered for the given type.
      #
      # @param [Class] type
      # @return [Shapes::StructureShape, nil]
      def shape_by_type(type)
        @shapes_by_type[type]
      end

      # Combines multiple type registries into a new registry containing unique shapes.
      #
      # @param [Array<TypeRegistry>] type_registries
      # @return [TypeRegistry]
      def concat(*type_registries)
        raise ArgumentError, 'Expected a Type Registry as input' unless type_registries.all?(TypeRegistry)

        new_shapes = @registry.values
        type_registries.each { |v| new_shapes.concat(v.to_h.values) }
        TypeRegistry.new(new_shapes.uniq!)
      end

      private

      def validate_shape(shape)
        msg = 'Expected a StructureShape that has a type representation'
        raise ArgumentError, msg unless shape.is_a?(Shapes::StructureShape) && shape.type
      end

      def register_shapes(shapes)
        registry = {}
        shapes_by_type = {}

        shapes.each do |shape|
          validate_shape(shape)
          registry[shape.id] = shape
          shapes_by_type[shape.type] = shape
        end
        [registry, shapes_by_type]
      end
    end
  end
end
