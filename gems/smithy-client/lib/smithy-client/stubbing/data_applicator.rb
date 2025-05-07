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

        def shape(ref, value)
          case ref.shape
          when StructureShape then structure(ref.shape, value, ref.shape.type.new)
          when ListShape then list(ref, value)
          when MapShape then map(ref, value)
          else value
          end
        end

        def list(ref, value)
          value.each_with_object([]) do |v, list|
            list << shape(ref.shape.member, v)
          end
        end

        def map(ref, value)
          value.each_with_object({}) do |(k, v), map|
            map[k.to_s] = shape(ref.shape.value, v)
          end
        end

        def structure(ref, data, stub)
          data.each do |key, value|
            stub[key] = shape(ref.shape.member(key), value)
          end
          stub
        end
      end
    end
  end
end
