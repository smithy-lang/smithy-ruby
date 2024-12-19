# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a list shape from the model.
    class ListShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @member = MemberShape.new('member', shape['member'])
      end

      # @return [MemberShape]
      attr_reader :member
    end
  end
end
