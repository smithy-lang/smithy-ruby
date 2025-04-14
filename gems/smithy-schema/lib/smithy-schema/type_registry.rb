# frozen_string_literal: true

module Smithy
  module Schema
    # A registry that contains a map of Smithy shape ID to its schema.
    # Also includes a way to find schema based on its shape type representation
    class TypeRegistry
      def initialize
        @registry = {}
        @schema_by_types = {}
      end

      # @api private
      attr_reader :schema_by_types

      # @return [Hash<String, Shapes::Shape>]
      attr_accessor :registry

      # @param [Array<Shapes::Shape>] shapes
      def register(*shapes)
        raise ArgumentError, 'Expected an array of Shapes' unless shapes.all?(Shapes::Shape)

        shapes.each do |s|
          @registry[s.id] = s

          case s.class
          when Shapes::StructureShape
            @schema_by_types[s.type] = s if s.type
          when Shapes::UnionShape
            s.member_types.values { |v| @schema_by_types[v] = s }
          end
        end
      end

      # Returns true if this type registry contains specific shape id.
      # @param [String] id
      # @return [Boolean]
      def schema_by_id?(id)
        @registry.key?(id)
      end

      # Returns the shape schema registered for the given shape id.
      # @param [id] id
      # @return [Shapes::Shape, nil]
      def schema_by_id(id)
        @registry[id]
      end

      # Returns true if this type registry contains a schema associated
      #  with the given typed shape.
      # @param [Class] type
      # @return [Boolean]
      def scheme_by_type?(type)
        @schema_by_types.key?(type)
      end

      # Returns the shape schema registered for the given typed shape.
      # @param [Class] type
      # @return [Shapes::Shape, nil]
      def scheme_by_type(type)
        @schema_by_types[type]
      end

      # Deserializes a document into a typed shape from registry.
      # @param [Document] document
      # @return [Shapes::Structure] typed shape
      def convert_as_typed(document)
        msg = 'Unable to convert given document since discriminator is not set'
        raise ArgumentError, msg unless document.discriminator

        if schema_by_id?(document.discriminator)
          document.as_typed(schema_by_id(document.discriminator))
        else
          msg = "Unable to find schema with #{document.discriminator} in Registry"
          raise ArgumentError, msg
        end
      end

      class << self
        # Composes multiple type registries together.
        # @param [Array<TypeRegistry>]
        # @return [TypeRegistry]
        def compose(*type_registries)
          raise ArgumentError, 'Expected an array of TypeRegistries' unless type_registries.all?(self)

          new_type_registry = new
          new_type_registry.registry =
            type_registries.each_with_object({}) { |r, h| h.merge!(r.registry) }
          new_type_registry
        end
      end
    end
  end
end
