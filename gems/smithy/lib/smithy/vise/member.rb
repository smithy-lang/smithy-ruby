# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a member from a shape within a model.
    class Member
      def initialize(name, target, traits)
        @name = name
        @target = target
        @traits = traits
      end

      # @return [String]
      attr_reader :name

      # @return [String]
      attr_reader :target

      # @return [Hash<String, Trait>]
      attr_reader :traits

      # @return [String] Returns member name in snake case format.
      def name_as_snake_case
        return nil if @name.empty?

        Tools::Underscore.underscore(@name)
      end

      # @return [String] Returns target relative shape id.
      def relative_target_id
        return nil if @target.empty?

        @target.split('#').last
      end
    end
  end
end
