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
  #   @option args [Hearth::HTTP::Client] :http_client (Hearth::HTTP::Client.new)
  #     The HTTP Client to use for request transport.
  #
  #   @option args [Symbol] :log_level (:info)
  #     The default log level to use with the Logger.
  #
  #   @option args [Logger] :logger (Logger.new($stdout, level: cfg.log_level))
  #     The Logger instance to use for logging.
  #
  #   @option args [Hearth::PluginList] :plugins (Hearth::PluginList.new)
  #     A list of Plugins to apply to the client. Plugins are callables that take one argument: Config.  Plugins may modify the provided config.
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
  # @!attribute http_client
  #   @return [Hearth::HTTP::Client]
  #
  # @!attribute log_level
  #   @return [Symbol]
  #
  # @!attribute logger
  #   @return [Logger]
  #
  # @!attribute plugins
  #   @return [Hearth::PluginList]
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
    :http_client,
    :log_level,
    :logger,
    :plugins,
    :retry_strategy,
    :stub_responses,
    :validate_input,
    keyword_init: true
  ) do
    include Hearth::Configuration

    def dup
      copy = super
      copy.logger = logger.dup
      copy.plugins = plugins.dup
      copy.retry_strategy = retry_strategy.dup
      copy
    end

    private

    def validate!
      Hearth::Validator.validate_types!(disable_host_prefix, TrueClass, FalseClass, context: 'options[:disable_host_prefix]')
      Hearth::Validator.validate_types!(endpoint, String, context: 'options[:endpoint]')
      Hearth::Validator.validate_types!(http_client, Hearth::HTTP::Client, context: 'options[:http_client]')
      Hearth::Validator.validate_types!(log_level, Symbol, context: 'options[:log_level]')
      Hearth::Validator.validate_types!(logger, Logger, context: 'options[:logger]')
      Hearth::Validator.validate_types!(plugins, Hearth::PluginList, context: 'options[:plugins]')
      Hearth::Validator.validate_types!(retry_strategy, Hearth::Retry::Strategy, context: 'options[:retry_strategy]')
      Hearth::Validator.validate_types!(stub_responses, TrueClass, FalseClass, context: 'options[:stub_responses]')
      Hearth::Validator.validate_types!(validate_input, TrueClass, FalseClass, context: 'options[:validate_input]')
    end

    def self.defaults
      @defaults ||= {
        disable_host_prefix: [false],
        endpoint: [proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil } ],
        http_client: [proc { |cfg| Hearth::HTTP::Client.new(logger: cfg[:logger]) }],
        log_level: [:info],
        logger: [proc { |cfg| Logger.new($stdout, level: cfg[:log_level]) } ],
        plugins: [proc { Hearth::PluginList.new}],
        retry_strategy: [proc { Hearth::Retry::Standard.new}],
        stub_responses: [false],
        validate_input: [true]
      }.freeze
    end
  end
end
