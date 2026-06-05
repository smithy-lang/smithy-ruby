# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Applies data to a stubbed object.
      # @api private
      class DataApplicator
        include Smithy::Schema::Shapes

        def initialize(shape)
          @shape = shape
        end

        def apply(data, stub)
          structure(@shape, data, stub)
        end

        private

        def apply_shape(shape, value, stub = nil)
          case shape.target
          when StructureShape then structure(shape, value, stub)
          when ListShape then list(shape, value)
          when MapShape then map(shape, value)
          else value
          end
        end

        def list(shape, value)
          return if value.nil?

          shape = shape.target
          value.each_with_object([]) do |v, list|
            list << apply_shape(shape.member, v)
          end
        end

        def map(shape, value)
          return if value.nil?

          shape = shape.target
          value.each_with_object({}) do |(k, v), map|
            map[k.to_s] = apply_shape(shape.value, v)
          end
        end

        def structure(shape, data, stub)
          return if data.nil?

          stub = shape.target.type.new if stub.nil?
          shape = shape.target
          data.each_pair do |key, value|
            stub[key] = apply_shape(shape.member(key), value)
          end
          stub
        end
      end
    end
  end
end
