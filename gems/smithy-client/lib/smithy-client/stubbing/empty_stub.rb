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
          return nil if visited.include?(ref.target)

          visited += [ref.target]

          case ref.target
          when ListShape then []
          when MapShape then {}
          when StructureShape then structure(ref, visited)
          when UnionShape then union(ref, visited)
          else scalar(ref)
          end
        end

        def structure(ref, visited)
          return Schema::EmptyStructure.new if ref.target == Prelude::Unit

          ref.target.members.each_with_object(ref.target.type.new) do |(member_name, member_ref), struct|
            struct[member_name] = shape(member_ref, visited)
          end
        end

        def union(ref, visited)
          member_name, member_ref = ref.target.members.first
          return unless member_name

          value = shape(member_ref.target, visited)
          klass = ref.target.member_type(member_name)
          klass.new(value)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def scalar(ref)
          case ref.target
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
