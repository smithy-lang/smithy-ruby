# frozen_string_literal: true

module Seahorse
  # Utility class for working with request parameters.
  #
  # * Validate structure of parameters against the expected model.
  # * Raise errors with context when validation fails.
  #
  class Validator
    # Initialize a new instance of Input.
    # @param [Struct] input The input type for this shape.
    # @param [String] context The nested context of the input, for error
    #   messaging.
    def initialize(input:, context:)
      @input = input
      @context = context
    end

    def validate_enum!(key, enums:)
      unless enums.include?(@input[key])
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be in #{enums}."
      end
    end

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

    def validate_pattern!(key, pattern:)
      unless @input[key].match?(Regexp.new(pattern))
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to match #{pattern}."
      end
    end

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

    # Validate required parameters
    # @raise [ArgumentError] Raises when parameters are required.
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

    def validate_unique_items!(key)
      if @input[key].size != @input[key].uniq.size
        raise ArgumentError,
              "Expected items in #{@context}[:#{key}] to be unique."
      end
    end

  end
end
