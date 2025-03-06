# frozen_string_literal: true

module Smithy
  module Schema
    # Registry that contains a map of Smithy shape ID to its shape representation
    # TODO: Implement a method that takes a document and deserializes
    class TypeRegistry
      def initialize
        @registry = {}
      end

      # @return [Hash<String, Shape>]
      attr_accessor :registry

      # @param [Array<Shape>] shapes
      def register(*shapes)
        raise ArgumentError, 'Expected an array of Shapes' unless shapes.all?(Shape)

        shapes.each do |s|
          next if s.id.nil?

          @registry[s.id] = s
        end
      end

      # @param [String] shape_id
      # @return [Boolean]
      def shape?(shape_id)
        @registry.key?(shape_id)
      end

      # @param [String] shape_id
      # @return [Shape]
      def shape(shape_id)
        @registry[shape_id]
      end

      class << self

        # TODO: Need thoughts on...
        #  * Smithy-Java only allows to compose 2 registries at a time,
        #    * Do we follow suit or allow unlimited number of registry to compose?
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
