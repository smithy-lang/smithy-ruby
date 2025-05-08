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

        def shape(ref, visited)
          shape = ref.shape
          return nil if visited.include?(shape)

          visited += [shape]

          case shape
          when ListShape then []
          when MapShape then {}
          when StructureShape then structure(ref, visited)
          when UnionShape then union(ref, visited)
          else scalar(ref)
          end
        end

        def structure(ref, visited)
          shape = ref.shape
          shape.members.each_with_object(shape.type.new) do |(member_name, member_ref), struct|
            struct[member_name] = shape(member_ref, visited)
          end
        end

        def union(ref, visited)
          shape = ref.shape
          member_name, member_ref = shape.members.first
          return unless member_name

          value = shape(member_ref, visited)
          klass = shape.member_type(member_name)
          klass.new(value)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def scalar(ref)
          case ref.shape
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
