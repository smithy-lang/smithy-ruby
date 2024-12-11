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
        @shape = shape
        @type = shape['type']
        @traits = parse_traits(shape)
        @members = parse_members(shape)
      end

      # @return [String] Absolute shape ID
      attr_reader :id

      # @return [String] Shape data
      attr_reader :shape

      # @return [String] Shape type
      attr_reader :type

      # @return [Hash<String, Trait>] Shape traits
      attr_reader :traits

      # @return [Hash<String, Member>] Shape members
      attr_reader :members

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

      def parse_traits(shape)
        return {} unless shape['traits']

        shape['traits'].each_with_object({}) { |(id, data), h| h[id] = Trait.new(id, data) }
      end

      def parse_members(shape)
        return {} unless shape['members']

        shape['members'].each_with_object({}) do |(name, data), h|
          h[name] = Member.new(name, data['target'], parse_traits(data))
        end
      end
    end
  end
end
