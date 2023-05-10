# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @!method initialize(*options)
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
  #   @option args [Hearth::Retry::Strategy] :retry_strategy (Hearth::Retry::Standard.new)
  #     Specifies which retry strategy class to use. Strategy classes
  #      may have additional options, such as max_retries and backoff strategies.
  #      Available options are:
  #      * `Retry::Standard` - A standardized set of retry rules across the AWS SDKs. This includes support for retry quotas, which limit the number of unsuccessful retries a client can make.
  #      * `Retry::Adaptive` - An experimental retry mode that includes all the functionality of `standard` mode along with automatic client side throttling.  This is a provisional mode that may change behavior in the future.
  #
  #   @option args [Boolean] :stub_responses (false)
  #     Enable response stubbing for testing. See {Hearth::ClientStubs stub_responses}.
  #
  #   @option args [Boolean] :validate_input (true)
  #     When `true`, request parameters are validated using the modeled shapes.
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
  # @!attribute retry_strategy
  #   @return [Hearth::Retry::Strategy]
  #
  # @!attribute stub_responses
  #   @return [Boolean]
  #
  # @!attribute validate_input
  #   @return [Boolean]
  #
  Config = ::Struct.new(
    :disable_host_prefix,
    :endpoint,
    :http_wire_trace,
    :log_level,
    :logger,
    :retry_strategy,
    :stub_responses,
    :validate_input,
    keyword_init: true
  ) do
    include Hearth::Configuration

    private

    def validate!
      Hearth::Validator.validate_types!(disable_host_prefix, TrueClass, FalseClass, context: 'options[:disable_host_prefix]')
      Hearth::Validator.validate_types!(endpoint, String, context: 'options[:endpoint]')
      Hearth::Validator.validate_types!(http_wire_trace, TrueClass, FalseClass, context: 'options[:http_wire_trace]')
      Hearth::Validator.validate_types!(log_level, Symbol, context: 'options[:log_level]')
      Hearth::Validator.validate_types!(logger, Logger, context: 'options[:logger]')
      Hearth::Validator.validate_types!(retry_strategy, Hearth::Retry::Strategy, context: 'options[:retry_strategy]')
      Hearth::Validator.validate_types!(stub_responses, TrueClass, FalseClass, context: 'options[:stub_responses]')
      Hearth::Validator.validate_types!(validate_input, TrueClass, FalseClass, context: 'options[:validate_input]')
    end

    def self.defaults
      @defaults ||= {
        disable_host_prefix: [false],
        endpoint: [proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil } ],
        http_wire_trace: [false],
        log_level: [:info],
        logger: [proc { |cfg| Logger.new($stdout, level: cfg[:log_level]) } ],
        retry_strategy: [Hearth::Retry::Standard.new],
        stub_responses: [false],
        validate_input: [true]
      }.freeze
    end
  end
end
