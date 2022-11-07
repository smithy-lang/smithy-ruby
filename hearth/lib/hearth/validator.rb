# frozen_string_literal: true

module Hearth
  # Utility module for working with request parameters.
  #
  # * Validate structure of parameters against the expected type.
  # * Raise errors with context when validation fails.
  # @api private
  module Validator
    # Validate the given value is of the given type(s).
    # @raise [ArgumentError] Raises when the value is not one of given type(s).
    def self.validate_types!(value, *types, context:)
      return if !value || types.any? { |type| value.is_a?(type) }

      raise ArgumentError,
            "Expected #{context} to be in " \
            "[#{types.map(&:to_s).join(', ')}], got #{value.class}."
    end

    # Validate a value is present and not empty.
    # @raise [ArgumentError] Raises when the value is nil or empty.
    def validate_required!(value, context:)
      raise ArgumentError, "Expected #{context} to be set." if value.nil?
    end
  end
end
