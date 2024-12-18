# frozen_string_literal: true

module Smithy
  # The Plan class is a simple data structure that holds the model, type, and options for a generator.
  class Plan
    # @param [Symbol] type The type of code to generate, either :client, :server, or :types.
    # @param [Hash] options The options passed to the generator.
    def initialize(type, options = {})
      @type = type
      @options = options
    end

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] The options passed to the generator.
    attr_reader :options
  end
end
