# frozen_string_literal: true

module Smithy
  class Plan
    def initialize(model, type, options = {})
      @model = Vise::Model.new(model)
      @type = type
      @options = options
    end

    # @return [Hash] The API model as a JSON hash.
    attr_reader :model

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] The options passed to the generator.
    attr_reader :options
  end
end
