# frozen_string_literal: true

module Hearth
  # Utility module for working with request parameters.
  #
  # * Validate structure of parameters against the expected type.
  # * Raise errors with context when validation fails.
  # @api private
  module Validator
    # Validate the given value is of the given type(s).
    # @param value [Object] The value to validate.
    # @param types [Array<Class>] The types to validate against.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value is not one of given type(s).
    def self.validate_types!(value, *types, context:)
      return if !value || types.any? { |type| value.is_a?(type) }

      raise ArgumentError,
            "Expected #{context} to be in " \
            "[#{types.map(&:to_s).join(', ')}], got #{value.class}."
    end

    # Validate a value is present and not nil.
    # @param value [Object] The value to validate.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value is nil.
    def self.validate_required!(value, context:)
      raise ArgumentError, "Expected #{context} to be set." if value.nil?
    end

    # Validate unknown parameters are not present for a given Struct.
    # @param struct [Struct] The Struct to validate against.
    # @param params [Hash] The parameters to validate.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when unknown parameters are present.
    def self.validate_unknown!(struct, params, context:)
      unknown = params.keys - struct.members
      return if unknown.empty?

      unknown = unknown.map { |key| "#{context}[:#{key}]" }
      raise ArgumentError,
            "Unexpected members: [#{unknown.join(', ')}]"
    end

    # draft of what validate_range *could* look like
    # valid_range param consists of min and max keys
    def self.validate_range(value, valid_range, context:)
      # need to validate the valid_range object before proceeding
      # does it make sense us to use existing method - validate_type!
      valid_range.each { |context, value| self.validate_type!(value, Integer, context: context) }

      return if value.between?(valid_range[:min], valid_range[:max])

      raise ArgumentError,
            "Expected #{context} to be between " \
            "#{minimum} to #{maximum}, got #{value}."
    end

  end
end
