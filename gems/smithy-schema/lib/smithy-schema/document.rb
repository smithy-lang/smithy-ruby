# frozen_string_literal: true

require_relative 'document/deserializer'
require_relative 'document/serializer'
require 'delegate'

module Smithy
  module Schema
    module Document
      # A Smithy document type, representing typed or untyped data from Smithy data model.
      # ## Document types
      # Document types are protocol-agnostic view of untyped data. They could be combined
      # with a shape to serialize its contents.
      #
      # Smithy-Ruby currently only support JSON documents.
      class Data < ::SimpleDelegator
        # @param [Object] data  document data
        # @param [Hash] options
        # @option options [Smithy::Schema::StructureShape] :shape shape to reference when setting
        #  document data.
        def initialize(data, options = {})
          @data = data
          super(@data)
          @discriminator = options[:discriminator] || nil
        end

        # @return [String] discriminator
        attr_reader :discriminator

        def data
          __getobj__
        end
      end
    end
  end
end
