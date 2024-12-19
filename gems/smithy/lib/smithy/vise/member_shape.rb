# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a member shape from the model.
    class MemberShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @traits = parse_traits(shape['traits'])
      end

      # @return [Hash<String, Trait>, nil] Member shape traits
      attr_reader :traits

      private

      def parse_traits(traits)
        return nil unless traits

        traits.each_with_object({}) { |(id, data), h| h[id] = Trait.new(id, data) }
      end
    end
  end
end
