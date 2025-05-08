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
    #  # accepts a map of id/shapes
    #  registry = TypeRegistry.new(
    #   "someId" => StructureShape,
    #   "anotherId" => AnotherStructureShape
    #  )
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
    #  TypeRegistry.concat(registry1, registry2)
    #  # => #<Smithy::Schema::TypeRegistry...>
    class TypeRegistry
      include Enumerable

      # @param  [Hash<String, Shapes::StructureShape>] registry
      def initialize(registry = {})
        @registry = registry
        @shapes_by_type = register_shape_types(registry.values)
      end

      # @api private
      # @return [Hash<String, Shapes::StructureShape>]
      attr_accessor :registry

      # @api private
      # @return [Hash<Class, Shapes::StructureShape>]
      attr_reader :shapes_by_type

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
        msg = 'Expected a StructureShape that has a type representation'
        raise ArgumentError, msg unless shape.is_a?(Shapes::StructureShape) && shape.type

        @registry[id] = shape
        @shapes_by_type[shape.type] = shape
      end

      # Returns true if the registry contains specific shape id.
      # @param [String] id
      # @return [Boolean]
      def key?(id)
        @registry.key?(id)
      end

      # Returns true if the registry contains a shape associated
      #  with the given type.
      # @param [Class] type
      # @return [Boolean]
      def shape_by_type?(type)
        @shapes_by_type.key?(type)
      end

      # Returns the shape registered for the given type.
      # @param [Class] type
      # @return [Shapes::StructureShape, nil]
      def shape_by_type(type)
        @shapes_by_type[type]
      end

      private

      def register_shape_types(shapes)
        shapes.each_with_object({}) do |s, h|
          msg = 'Expected a StructureShape that has a type representation'
          raise ArgumentError, msg unless s.is_a?(Shapes::StructureShape) && s.type

          h[s.type] = s
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
