# frozen_string_literal: true

module Smithy
  module Schema
    # A registry that contains a map of Smithy shape ID to the shape representation.
    #
    # This registry has the following functionalities:
    #
    # * Access shape by shape ID
    # * Access shape by its type
    # * Register shape to the Registry
    # * Supports enumeration of registered shapes
    #
    # You could also combine multiple registries into one registry.
    #
    # @example Creating a new Registry
    #  # accepts a map of id/shapes
    #  registry = TypeRegistry.new(
    #   "someId" => StructureShape,
    #   "anotherId" => AnotherStructureShape
    #  )
    #
    # @example Shape Lookup
    #  # Find shape by its shape id
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

      # @param  [Hash<String, Shapes::Structure>] registry
      def initialize(registry = {})
        @registry = registry
        @shapes_by_type = register_shape_types(registry.values)
      end

      # @api private
      # @return [Hash<String, Shapes::Structure>]
      attr_accessor :registry

      # @api private
      # @return [Hash<Class, Shapes::Structure>]
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

      # @param [String] id
      # @param [Shapes::Structure] shape
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
      # @param [Class] type
      # @return [Boolean]
      def shape_by_type?(type)
        @shapes_by_type.key?(type)
      end

      # Returns the shape registered for the given type.
      # @param [Class] type
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
