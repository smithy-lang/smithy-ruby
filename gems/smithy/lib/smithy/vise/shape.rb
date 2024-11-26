# frozen_string_literal: true

module Smithy
  module Vise
    class Shape
      def initialize(id, shape)
        @id = id
        @shape = shape
      end

      def type
        @shape['type']
      end
    end
  end
end
