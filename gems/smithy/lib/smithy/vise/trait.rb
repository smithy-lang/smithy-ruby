# frozen_string_literal: true

module Smithy
  module Vise
    class Trait
      def initialize(id, data)
        @id = id
        @data = data
      end

      # @return [String]
      attr_reader :id

      # @return [Object]
      attr_reader :data
    end
  end
end
