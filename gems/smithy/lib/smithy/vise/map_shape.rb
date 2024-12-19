# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a map shape from the model.
    class MapShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @key = MemberShape.new('key', shape['key'])
        @value = MemberShape.new('value', shape['value'])
      end

      # @return [MemberShape]
      attr_reader :key

      # @return [MemberShape]
      attr_reader :value
    end
  end
end
