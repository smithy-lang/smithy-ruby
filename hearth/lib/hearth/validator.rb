# frozen_string_literal: true

module Hearth
  # Utility module for working with request parameters.
  #
  # * Validate structure of parameters against the expected input.
  # * Raise errors with context when validation fails.
  # @api private
  module Validator
    # Validate the given value is within the expected range (inclusive).
    # @param value [Object] The value to validate.
    # @param min [Numeric] The minimum that the given value should be.
    # @param max [Numeric] The maximum that the given value should be.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value is not within expected range.
    def self.validate_range!(value, min:, max:, context:)
      return if value.nil? || value.between?(min, max)

      raise ArgumentError,
            "Expected #{context} to be between " \
            "#{min} to #{max}, got #{value}."
    end

    # Validate the given value responds to the given methods.
    # @param value [Object] The value to validate.
    # @param methods [Array<Symbol>] The methods to validate against.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value does not respond to the
    #   methods.
    def self.validate_responds_to!(value, *methods, context:)
      if value.nil? || methods.all? { |method| value.respond_to?(method) }
        return
      end

      raise ArgumentError,
            "Expected #{context} to respond to " \
            "[#{methods.map(&:to_s).join(', ')}], got #{value.class}."
    end

    # Validate a value is present and not nil.
    # @param value [Object] The value to validate.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value is nil.
    def self.validate_required!(value, context:)
      raise ArgumentError, "Expected #{context} to be set." if value.nil?
    end

    # Validate the given value is of the given type(s).
    # @param value [Object] The value to validate.
    # @param types [Array<Class>] The types to validate against.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when the value is not one of given type(s).
    def self.validate_types!(value, *types, context:)
      return if value.nil? || types.any? { |type| value.is_a?(type) }

      raise ArgumentError,
            "Expected #{context} to be in " \
            "[#{types.map(&:to_s).join(', ')}], got #{value.class}."
    end

    # Validate unknown parameters are not present for a given Type.
    # @param klass [Structure, Configuration] The class to validate against.
    # @param params [Hash] The parameters to validate.
    # @param context [String] The context of the value being validated.
    # @raise [ArgumentError] Raises when unknown parameters are present.
    def self.validate_unknown!(klass, params, context:)
      unknown = params.keys - klass.class::MEMBERS
      return if unknown.empty?

      unknown = unknown.map { |key| "#{context}[:#{key}]" }
      raise ArgumentError,
            "Unexpected members: [#{unknown.join(', ')}]"
    end
  end
end
