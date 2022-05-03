# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  Config = ::Struct.new(
    :adaptive_retry_wait_to_fill,
    :disable_host_prefix,
    :endpoint,
    :http_wire_trace,
    :log_level,
    :logger,
    :max_attempts,
    :retry_mode,
    :stub_responses,
    :validate_input,
    keyword_init: true
  ) do
    # @option options [Boolean] :adaptive_retry_wait_to_fill (true)
    #   Used only in `adaptive` retry mode. When true, the request will sleep until there is sufficient client side capacity to retry the request. When false, the request will raise a `CapacityNotAvailableError` and will not retry instead of sleeping.
    #
    # @option options [Boolean] :disable_host_prefix (false)
    #   When `true`, does not perform host prefix injection using @endpoint's hostPrefix property.
    #
    # @option options [String] :endpoint
    #   Endpoint of the service
    #
    # @option options [Boolean] :http_wire_trace (false)
    #   Enable debug wire trace on http requests.
    #
    # @option options [Symbol] :log_level (:info)
    #   Default log level to use
    #
    # @option options [Logger] :logger ($stdout)
    #   Logger to use for output
    #
    # @option options [Integer] :max_attempts (3)
    #   An integer representing the maximum number of attempts that will be made for a single request, including the initial attempt.
    #
    # @option options [String] :retry_mode ('standard')
    #   Specifies which retry algorithm to use. Values are:
    #    * `standard` - A standardized set of retry rules across the AWS SDKs. This includes support for retry quotas, which limit the number of unsuccessful retries a client can make.
    #    * `adaptive` - An experimental retry mode that includes all the functionality of `standard` mode along with automatic client side throttling.  This is a provisional mode that may change behavior in the future.
    #
    # @option options [Boolean] :stub_responses (false)
    #   Enable response stubbing. See documentation for {#stub_responses}
    #
    # @option options [Boolean] :validate_input (true)
    #   When `true`, request parameters are validated using the modeled shapes.
    #
    def self.build(options = {})
      config = Hearth::Config::Resolver.new(HighScoreService::Config, defaults).build(options)
      validate!(config)
      config
    end

    private

    def self.validate!(config)
      Hearth::Validator.validate!(config[:adaptive_retry_wait_to_fill], TrueClass, FalseClass, context: 'config[:adaptive_retry_wait_to_fill]')
      Hearth::Validator.validate!(config[:disable_host_prefix], TrueClass, FalseClass, context: 'config[:disable_host_prefix]')
      Hearth::Validator.validate!(config[:endpoint], String, context: 'config[:endpoint]')
      Hearth::Validator.validate!(config[:http_wire_trace], TrueClass, FalseClass, context: 'config[:http_wire_trace]')
      Hearth::Validator.validate!(config[:log_level], Symbol, context: 'config[:log_level]')
      Hearth::Validator.validate!(config[:logger], Logger, context: 'config[:logger]')
      Hearth::Validator.validate!(config[:max_attempts], Integer, context: 'config[:max_attempts]')
      Hearth::Validator.validate!(config[:retry_mode], String, context: 'config[:retry_mode]')
      Hearth::Validator.validate!(config[:stub_responses], TrueClass, FalseClass, context: 'config[:stub_responses]')
      Hearth::Validator.validate!(config[:validate_input], TrueClass, FalseClass, context: 'config[:validate_input]')
    end

    def self.defaults
      defaults = {}
      # TODO
      defaults
    end
  end
end
