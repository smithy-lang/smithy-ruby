# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Applies data to a stubbed object.
      # @api private
      class DataApplicator
        include Smithy::Schema::Shapes

        def initialize(schema)
          @schema = schema
        end

        def apply(data, stub)
          structure(@schema, data, stub)
        end

        private

        def structure(shape, data, stub)
          data.each do |key, value|
            stub[key] = member(shape.member(key).shape, value)
          end
          stub
        end

        def member(shape, value)
          case shape
          when StructureShape
            structure(shape, value, shape.type.new)
          when ListShape
            value.each_with_object([]) do |v, list|
              list << member(shape.member, v)
            end
          when MapShape
            value.each_with_object({}) do |(k, v), map|
              map[k.to_s] = member(shape.value, v)
            end
          else
            value
          end
        end
      end
    end
  end
end
