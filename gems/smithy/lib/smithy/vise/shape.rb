# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a shape from the model.
    # Shape IDs have the following syntax:
    #
    # smithy.example.foo#ExampleShapeName$memberName
    # └─────────┬──────┘ └───────┬──────┘ └────┬───┘
    #      (Namespace)     (Shape name)  (Member name)
    #                    └──────────────┬────────────┘
    #                          (Relative shape ID)
    # └──────────────────────┬───────────────────────┘
    #               (Absolute shape ID)
    class Shape
      # @param [String] id Absolute shape ID
      # @param [Hash] shape Shape definition
      def initialize(id, shape)
        @id = id
        @traits = build_traits(shape['traits'])
      end

      # @return [String] Absolute shape ID
      attr_reader :id

      # @return [Hash<String, Trait>, nil] Shape traits
      attr_reader :traits

      # Optional shape namespace
      # @return [String, nil] Shape namespace
      def namespace
        return nil unless @id.include?('#')

        @id.split('#').first
      end

      # @return [String] Relative shape ID
      def relative_id
        return nil if @id.empty?

        @id.split('#').last
      end

      # @return [String] Shape name
      def name
        return nil if @id.empty?

        @id.split('#').last.split('$').first
      end

      # Optional member name
      # @return [String, nil] Member name
      def member_name
        return nil unless @id.include?('$')

        @id.split('$').last
      end

      private

      def build_traits(traits)
        return nil unless traits

        traits.each_with_object({}) { |(id, data), h| h[id] = Trait.new(id, data) }
      end
    end
  end
end
