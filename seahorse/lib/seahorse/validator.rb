# frozen_string_literal: true

module Seahorse
  # Utility class for working with request parameters.
  #
  # * Validate structure of parameters against the expected type.
  # * Raise errors with context when validation fails.
  #
  class Validator
    # Initialize a new instance of the validator.
    # @param [Struct] input The input type for this shape.
    # @param [String] context The nested context of the input, for error
    #   messaging.
    def initialize(input, context:)
      @input = input
      @context = context
    end

    # Validate the given key is the given type.
    # @raise [ArgumentError] Raises when the key's value is not the given type.
    def validate_type!(key, type)
      v = @input[key]
      return if !v || v.is_a?(type)

      raise ArgumentError,
            "Expected #{@context}[:#{key}] to be a #{type}, got #{v.class}."
    end
  end
end
