# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Creates an empty default stub.
      # @api private
      class EmptyStub
        include Smithy::Schema::Shapes

        def initialize(schema)
          @schema = schema
        end

        # @return [Schema::Structure, Schema::EmptyStructure]
        def stub
          structure(@schema, [])
        end

        private

        def shape(shape, visited)
          return nil if visited.include?(shape)

          visited += [shape]

          case shape
          when ListShape then []
          when MapShape then {}
          when StructureShape then structure(shape, visited)
          when UnionShape then union(shape, visited)
          else scalar(shape)
          end
        end

        def structure(shape, visited)
          return Schema::EmptyStructure.new if shape == Prelude::Unit

          shape.members.each_with_object(shape.type.new) do |(member_name, member_shape), struct|
            struct[member_name] = shape(member_shape.shape, visited)
          end
        end

        def union(shape, visited)
          member_name, member_shape = shape.members.first
          return unless member_name

          value = shape(member_shape.shape, visited)
          klass = shape.member_types[member_name]
          klass.new(value)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def scalar(shape)
          case shape
          when BigDecimalShape then BigDecimal(0)
          when BlobShape then 'blob'
          when BooleanShape then false
          when EnumShape then 'enum'
          when IntegerShape, IntEnumShape then 0
          when FloatShape then 0.0
          when StringShape then 'string'
          when TimestampShape then Time.now
          end
        end
        # rubocop:enable Metrics/CyclomaticComplexity
      end
    end
  end
end
