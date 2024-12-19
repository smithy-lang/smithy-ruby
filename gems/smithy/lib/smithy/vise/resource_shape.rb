# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a resource shape from the model.
    class ResourceShape < Shape
      RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list].freeze
      RESOURCE_OPERATION_KEYS = %w[operation collectionOperations].freeze

      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @identifiers = shape['identifiers']
        @properties = shape['properties']
        @lifecycle_operations = {}
        RESOURCE_LIFECYCLE_KEYS.each do |key|
          @lifecycle_operations[key] = shape[key]
        end

        @operations = shape['operations']
        @collection_operations = shape['collectionOperations']
        @resources = shape['resources']
      end

      # @return [Hash<String, Hash>, nil]
      attr_reader :identifiers

      # @return [Hash<String, Hash>, nil]
      attr_reader :properties

      # @return [Hash<String, Hash>, nil]
      attr_reader :lifecycle_operations

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :operations

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :collection_operations

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :resources
      #
      # # @return [Hash<String, String>, nil]
      # def create
      #   @lifecycle_operations['create']
      # end
      #
      # # @return [Hash<String, String>, nil]
      # def put
      #   @lifecycle_operations['put']
      # end
      #
      # # @return [Hash<String, String>, nil]
      # def read
      #   @lifecycle_operations['read']
      # end
      #
      # # @return [Hash<String, String>, nil]
      # def update
      #   @lifecycle_operations['update']
      # end
      #
      # # @return [Hash<String, String>, nil]
      # def delete
      #   @lifecycle_operations['delete']
      # end
      #
      # # @return [Hash<String, String>, nil]
      # def list
      #   @lifecycle_operations['list']
      # end
    end
  end
end
