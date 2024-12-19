# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a trait from the model.
    class Trait
      def initialize(id, properties)
        @id = id
        @properties = properties
      end

      # @return [String]
      attr_reader :id

      # @return [Hash<String, Object>]
      attr_reader :properties
    end
  end
end
