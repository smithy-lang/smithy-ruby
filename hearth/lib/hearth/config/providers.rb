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


# test code
module Service
  Config = Struct.new(
    :endpoint, # static
    :log_level, # static
    :logger, # static
    :http_wire_trace, # default middleware
    :stub_responses, # default middleware
    :disable_host_prefix, # default middleware
    :max_attempts, # default middleware
    :max_delay, # default middleware
    :validate_input, # default middleware
    :use_arn_region, # service specific middleware
    keyword_init: true
  ) do

    def self.build(options = {})
      config = Hearth::Config::Resolver.new(
        ::Service::Config, defaults
      ).build(options)
      validate!(config)
      config
    end

    private

    def self.validate!(config)
      Hearth::Validator.validate!(config[:log_level], Symbol, context: 'config[:log_level]')
      Hearth::Validator.validate!(config[:logger], Logger, context: 'config[:logger]')
      Hearth::Validator.validate!(config[:stub_responses], TrueClass, FalseClass, context: 'config[:stub_responses]')
      # ...
    end

    def self.defaults
      defaults = {}
      # static value, as a single value
      defaults[:log_level] = [ :info ]
      # dynamic value, as a block
      defaults[:logger] = [
        proc { |cfg| Logger.new($stdout, level: cfg[:log_level]) }
      ]
      # env value, fallback to static value
      defaults[:stub_responses] = [
        Hearth::Config::EnvProvider.new('STUB_RESPONSES', type: 'Boolean'),
        false
      ]
      # ... more defaults
      defaults
    end
  end
end
