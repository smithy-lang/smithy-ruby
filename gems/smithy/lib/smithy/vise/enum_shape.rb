# frozen_string_literal: true

module Smithy
  module Vise
    # Represents an enum shape from the model.
    class EnumShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @members = build_members(shape['members'])
      end

      # @return [Hash<String, MemberShape>]
      attr_reader :members

      private

      def build_members(members)
        members.each_with_object({}) do |(id, shape), h|
          h[id] = MemberShape.new(id, shape)
        end
      end
    end
  end
end
