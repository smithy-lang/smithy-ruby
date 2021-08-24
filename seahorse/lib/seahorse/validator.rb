# frozen_string_literal: true

module Seahorse
  # Utility module for working with request parameters.
  #
  # * Validate structure of parameters against the expected type.
  # * Raise errors with context when validation fails.
  # @api private
  module Validator
    # Validate the given values is of the given type(s).
    # @raise [ArgumentError] Raises when the value is not one of given type(s).
    def self.validate!(value, *types, context:)
      return if !value || types.any? { |type| value.is_a?(type) }

      raise ArgumentError,
            "Expected #{context} to be in #{types}, got #{value.class}."
    end

    # Validate the given values is hash like
    # @raise [ArgumentError] Raises when the value is not hash like
    def self.validate_hash_like(value, context:)
      return if value.respond_to?(:each_pair)

      raise ArgumentError,
            "Expected #{context} to be Hash like, got #{value.class}."
    end
  end
end
