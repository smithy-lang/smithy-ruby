# frozen_string_literal: true

module Seahorse
  # Utility class for working with request parameters.
  #
  # * Validate structure of parameters against expected types.
  # * Raise errors with context when validation or cast fails.
  #
  class Input
    # Initialize a new instance of Input.
    # @param [Hash, Struct] params The params for this shape.
    # @param [String] context The nested context for these params, for error
    #   messaging.
    def initialize(params:, context:)
      @params = params
      @context = context
    end

    # Validate that the params are either a Hash or an object of the Type
    def validate_params!(type)
      unless @params.is_a?(Hash) || @params.is_a?(type)
        raise ArgumentError,
              "Expected #{@context} to be a Hash or #{type},"\
              " got #{@params.class}."
      end
    end

    # Validate required parameters
    # @raise [ArgumentError] Raises when parameters are required.
    def validate_required!(key)
      if (v = @params[key])
        if v.respond_to?(:empty?) && v.empty?
          raise ArgumentError,
                "Expected #{@context}[:#{key}] to be non-empty."
        end
      else
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be set."
      end
    end

    # Validate the given key is the given type
    # @raise [ArgumentError] Raises when the key's value is not the given type.
    def validate_type!(key, type)
      if (v = @params[key]) && !v.is_a?(type)
        raise ArgumentError,
              "Expected #{@context}[:#{key}] to be a #{type}, got #{v.class}."
      end
    end

    # Validate that there aren't any extra unexpected keys for the type.
    # @raise [ArgumentError] Raises when there are unexpected keys.
    def validate_unexpected!(type)
      # Types already validate unexpected members on construction
      return if @params.is_a?(type)

      unless (unexpected = @params.keys - type.members).empty?
        raise ArgumentError,
              "Unexpected params at #{@context}, got #{unexpected}"
      end
    end
  end
end
