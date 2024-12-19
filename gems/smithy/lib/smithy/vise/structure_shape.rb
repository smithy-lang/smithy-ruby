# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a structure shape from the model.
    class StructureShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @members = shape['members']
      end

      # @return [Hash<String, Hash>]
      attr_reader :members
    end
  end
end
