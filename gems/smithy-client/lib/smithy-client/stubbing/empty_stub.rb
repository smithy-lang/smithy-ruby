# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # @api private
      class EmptyStub
        include Smithy::Schema::Shapes

        def initialize(rules)
          @rules = rules
        end

        # @return [Structure]
        def stub
          return EmptyStructure.new unless @rules

          shape(@rules)
        end

        private

        def shape(shape, visited = [])
          return nil if visited.include?(shape)

          visited += [shape]

          case shape
          when StructureShape then structure(shape, visited)
          when ListShape then []
          when MapShape then {}
          end
        end

        def structure(shape, visited)
          shape.members.each_with_object(shape.type.new) do |(member_name, member_shape), struct|
            struct[member_name] = shape(member_shape, visited)
          end
        end

        # def scalar(shape)
        #   case shape
        #   when BigDecimalShape then BigDecimal(0)
        #   when BlobShape then ''
        #   when StringShape then shape.name || 'string'
        #   when IntegerShape then 0
        #   when FloatShape then 0.0
        #   when BooleanShape then false
        #   when TimestampShape then Time.now
        #   else nil
        #   end
        # end
      end
    end
  end
end
