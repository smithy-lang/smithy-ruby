module Hearth
  module Config
    # Parses and validates values provided in ENV
    # @api private
    class EnvProvider
      def initialize(env_key, type:)
        @env_key = env_key
        @type = type
      end

      def call(_provider)
        return unless value = ENV[@env_key]

        case @type
        when 'Float' then parse_float(value)
        when 'Integer' then parse_integer(value)
        when 'Boolean' then parse_boolean(value)
        else
          value
        end
      end

      private

      def parse_float(value)
        Float(value)
      rescue ArgumentError
        raise_error(value)
      end

      def parse_integer(value)
        Integer(value)
      rescue ArgumentError
        raise_error(value)
      end

      def parse_boolean(value)
        case value.downcase
        when 'true' then true
        when 'false' then false
        else raise_error(value)
        end
      end

      def raise_error(value)
        raise ArgumentError,
              "Expected ENV['#{@env_key}'] to be a #{@type}, got #{value}."
      end
    end
  end
end

