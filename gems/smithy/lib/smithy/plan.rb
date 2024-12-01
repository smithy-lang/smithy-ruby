# frozen_string_literal: true

module Smithy
  # The Plan class is a simple data structure that holds the model, type, and options for a generator.
  class Plan
    # @param model [Hash] The API model as a JSON hash.
    # @param type [Symbol] The type of code to generate, either :client, :server, or :types.
    # @param options [Hash] The options passed to the generator.
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
