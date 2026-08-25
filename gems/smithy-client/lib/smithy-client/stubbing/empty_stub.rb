# frozen_string_literal: true

require 'bigdecimal'

module Smithy
  module Client
    module Stubbing
      # Creates an empty default stub.
      # @api private
      class EmptyStub
        include Smithy::Schema::Shapes

        def initialize(shape)
          @shape = shape
        end

        # @return [Schema::Structure, Schema::EmptyStructure]
        def stub
          structure(@shape, [])
        end

        private

        def stub_shape(shape, visited)
          resolved_shape = shape.target
          return nil if visited.include?(resolved_shape)

          visited += [resolved_shape]

          case resolved_shape
          when ListShape then []
          when MapShape then {}
          when StructureShape then structure(shape, visited)
          when UnionShape then union(shape, visited)
          else scalar(shape)
          end
        end

        def structure(shape, visited)
          shape = shape.target
          shape.members.each_with_object(shape.type.new) do |(member_name, member_shape), struct|
            struct[member_name] = stub_shape(member_shape, visited)
          end
        end

        def union(shape, visited)
          shape = shape.target
          member_name, member_shape = shape.members.first
          return unless member_name

          value = stub_shape(member_shape, visited)
          klass = shape.member_type(member_name)
          klass.new(member_name => value)
        end

        def scalar(shape)
          case shape.target
          when BigDecimalShape then BigDecimal(0)
          when BlobShape, EnumShape, StringShape then shape.name
          when BooleanShape then false
          when IntegerShape, IntEnumShape then 0
          when FloatShape then 0.0
          when TimestampShape then Time.now
          end
        end
      end
    end
  end
end
