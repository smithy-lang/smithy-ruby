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
        @registry = {}
        @shapes_by_type = {}
        shapes.each do |shape|
          self[shape.id] = shape
        end
      end

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

      # @return [Boolean]
      def empty?
        @registry.empty?
      end

      # @param [String] id
      def key?(id)
        @registry.key?(id)
      end
      alias include? key?

      # @return [Array<String>]
      def keys
        @registry.keys
      end

      # @param [Class] type
      def shape_by_type?(type)
        @shapes_by_type.key?(type)
      end

      # @param [Class] type
      # @return [Shapes::StructureShape, nil]
      def shape_by_type(type)
        @shapes_by_type[type]
      end

      # @return [Array<Shape::StructureShape>]
      def values
        @registry.values
      end

      # Merges multiple type registries into a new registry.
      #
      # @param [Array<TypeRegistry>] type_registries
      # @return [TypeRegistry]
      def merge(*type_registries)
        registry = TypeRegistry.new
        @registry.each do |shape_id, shape|
          registry[shape_id] = shape
        end
        type_registries.each do |type_registry|
          unless type_registry.is_a?(TypeRegistry)
            raise ArgumentError, "expected TypeRegistry, got #{type_registry.class}"
          end

          type_registry.each do |shape_id, shape|
            registry[shape_id] = shape
          end
        end
        registry
      end

      private

      def validate_shape(shape)
        return if shape.is_a?(Shapes::StructureShape) && shape.type

        raise ArgumentError, "expected a StructureShape with a type, got: #{shape.class}"
      end
    end
  end
end
