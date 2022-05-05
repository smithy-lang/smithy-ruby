# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  # @!method initialize(*args)
  #   @option args [Boolean] :adaptive_retry_wait_to_fill (true)
  #     Used only in `adaptive` retry mode. When true, the request will sleep until there is sufficient client side capacity to retry the request. When false, the request will raise a `CapacityNotAvailableError` and will not retry instead of sleeping.
  #
  #   @option args [Boolean] :disable_host_prefix (false)
  #     When `true`, does not perform host prefix injection using @endpoint's hostPrefix property.
  #
  #   @option args [String] :endpoint
  #     Endpoint of the service
  #
  #   @option args [Boolean] :http_wire_trace (false)
  #     Enable debug wire trace on http requests.
  #
  #   @option args [Symbol] :log_level (:info)
  #     Default log level to use
  #
  #   @option args [Logger] :logger ($stdout)
  #     Logger to use for output
  #
  #   @option args [Integer] :max_attempts (3)
  #     An integer representing the maximum number of attempts that will be made for a single request, including the initial attempt.
  #
  #   @option args [String] :retry_mode ('standard')
  #     Specifies which retry algorithm to use. Values are:
  #      * `standard` - A standardized set of retry rules across the AWS SDKs. This includes support for retry quotas, which limit the number of unsuccessful retries a client can make.
  #      * `adaptive` - An experimental retry mode that includes all the functionality of `standard` mode along with automatic client side throttling.  This is a provisional mode that may change behavior in the future.
  #
  #   @option args [Boolean] :stub_responses (false)
  #     Enable response stubbing. See documentation for { stub_responses}
  #
  #   @option args [Boolean] :validate_input (true)
  #     When `true`, request parameters are validated using the modeled shapes.
  #
  # @!attribute adaptive_retry_wait_to_fill
  #   @return [Boolean]
  #
  # @!attribute disable_host_prefix
  #   @return [Boolean]
  #
  # @!attribute endpoint
  #   @return [String]
  #
  # @!attribute http_wire_trace
  #   @return [Boolean]
  #
  # @!attribute log_level
  #   @return [Symbol]
  #
  # @!attribute logger
  #   @return [Logger]
  #
  # @!attribute max_attempts
  #   @return [Integer]
  #
  # @!attribute retry_mode
  #   @return [String]
  #
  # @!attribute stub_responses
  #   @return [Boolean]
  #
  # @!attribute validate_input
  #   @return [Boolean]
  #
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
    include Hearth::Configuration

    private

    def validate!
      Hearth::Validator.validate!(adaptive_retry_wait_to_fill, TrueClass, FalseClass, context: 'options[adaptive_retry_wait_to_fill]')
      Hearth::Validator.validate!(disable_host_prefix, TrueClass, FalseClass, context: 'options[disable_host_prefix]')
      Hearth::Validator.validate!(endpoint, String, context: 'options[endpoint]')
      Hearth::Validator.validate!(http_wire_trace, TrueClass, FalseClass, context: 'options[http_wire_trace]')
      Hearth::Validator.validate!(log_level, Symbol, context: 'options[log_level]')
      Hearth::Validator.validate!(logger, Logger, context: 'options[logger]')
      Hearth::Validator.validate!(max_attempts, Integer, context: 'options[max_attempts]')
      Hearth::Validator.validate!(retry_mode, String, context: 'options[retry_mode]')
      Hearth::Validator.validate!(stub_responses, TrueClass, FalseClass, context: 'options[stub_responses]')
      Hearth::Validator.validate!(validate_input, TrueClass, FalseClass, context: 'options[validate_input]')
    end

    def self.defaults
      @defaults ||= {
        adaptive_retry_wait_to_fill: [true],
        disable_host_prefix: [false],
        endpoint: [proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil } ],
        http_wire_trace: [false],
        log_level: [:info],
        logger: [proc { |cfg| Logger.new($stdout, level: cfg[:log_level]) } ],
        max_attempts: [3],
        retry_mode: ['standard'],
        stub_responses: [false],
        validate_input: [true]
      }.freeze
    end
  end
end
