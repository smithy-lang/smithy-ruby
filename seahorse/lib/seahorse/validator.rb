# frozen_string_literal: true

module Seahorse
  # Utility class for working with request parameters.
  #
  # * Validate structure of parameters against the expected model.
  # * Raise errors with context when validation fails.
  #
  class Validator
    # Initialize a new instance of the validator.
    # @param [Struct] input The input type for this shape.
    # @param [String] context The nested context of the input, for error
    #   messaging.
    def initialize(input:, context:)
      @input = input
      @context = context
    end

    # Validates that a key's value is present in a list of enum values.
    # @param [Symbol] key The key to validate.
    # @param [Array<String>] enums A list of all available enums.
    # @raise [ArgumentError] Raises when the key's value is not in the list
    #   of enums.
    def validate_enum!(key, enums:)
      unless enums.include?(@input[key])
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be in #{enums}."
      end
    end

    # Validates that a key's value is longer or shorter than min and max values
    #   (inclusive). This validation is used with strings, arrays, and hashes.
    # @param [Symbol] key The key to validate.
    # @param [Integer,Float] min A minimum numeric value.
    # @param [Integer,Float] max A maximum numeric value.
    # @raise [ArgumentError] Raises when the key's value is not within the min
    #   or max length.
    def validate_length!(key, min: nil, max: nil)
      if min && @input[key].length < min
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be longer than #{min}."
      end
      if max && @input[key].length > max
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be shorter than #{max}."
      end
    end

    # Validates that a key's value conforms to a regular expression.
    # @param [Symbol] key The key to validate.
    # @param [String] pattern A regex pattern as a string.
    # @raise [ArgumentError] Raises when the key's value does not match the
    #   regular expression pattern.
    def validate_pattern!(key, pattern:)
      unless @input[key].match?(Regexp.new(pattern))
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to match #{pattern}."
      end
    end

    # Validates that a key's value is larger or smaller than min and max values
    #   (inclusive). This validation is used with numeric values.
    # @param [Symbol] key The key to validate.
    # @param [Integer,Float] min A minimum numeric value.
    # @param [Integer,Float] max A maximum numeric value.
    # @raise [ArgumentError] Raises when the key's value is not within the min
    #   or max range.
    def validate_range!(key, min: nil, max: nil)
      if min && @input[key] < min
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be larger than #{min}."
      end
      if max && @input[key] > max
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be smaller than #{max}."
      end
    end

    # Validate that a key's value is present and not empty.
    # @param [Symbol] key The key to validate.
    # @raise [ArgumentError] Raises when the key's value is nil or empty.
    def validate_required!(key)
      if (v = @input[key])
        if v.respond_to?(:empty?) && v.empty?
          raise ArgumentError,
                "Expected #{@context}[:#{key}] to be non-empty."
        end
      else
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be set."
      end
    end

    # Validate that a key's value is an array with unique items (Set).
    # @param [Symbol] key The key to validate.
    # @raise [ArgumentError] Raises when the key's value is not an array with
    #   unique items.
    def validate_unique_items!(key)
      if @input[key].size != @input[key].uniq.size
        raise ArgumentError,
              "Expected items in #{@context}[:#{key}] to be unique."
      end
    end

  end
end
