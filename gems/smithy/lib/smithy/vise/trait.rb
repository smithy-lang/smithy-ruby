# frozen_string_literal: true

module Smithy
  module Vise
    class Trait < Shape
      def initialize(id, trait)
        @id = id
        @trait = trait
      end

      def type
        'trait'
      end
    end
  end
end
