# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Applies data to a stubbed object.
      # @api private
      class DataApplicator
        include Smithy::Schema::Shapes

        def initialize(ref)
          @ref = ref
        end

        def apply(data, stub)
          structure(@ref, data, stub)
        end

        private

        def shape(ref, value, stub = nil)
          case ref.target
          when StructureShape then structure(ref, value, stub)
          when ListShape then list(ref, value)
          when MapShape then map(ref, value)
          else value
          end
        end

        def list(ref, value)
          return if value.nil?

          shape = ref.target
          value.each_with_object([]) do |v, list|
            list << shape(shape.member, v)
          end
        end

        def map(ref, value)
          return if value.nil?

          shape = ref.target
          value.each_with_object({}) do |(k, v), map|
            map[k.to_s] = shape(shape.value, v)
          end
        end

        def structure(ref, data, stub)
          return if data.nil?

          stub = ref.target.type.new if stub.nil?
          shape = ref.target
          data.each_pair do |key, value|
            stub[key] = shape(shape.member(key), value)
          end
          stub
        end
      end
    end
  end
end
