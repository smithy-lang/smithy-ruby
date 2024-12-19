# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a service shape from the model.
    class ServiceShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @version = shape['version']
        @operations = shape['operations']
        @resources = shape['resources']
      end

      # @return [String, nil]
      attr_reader :version

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :operations

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :resources
    end
  end
end
