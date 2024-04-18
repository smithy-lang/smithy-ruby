# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @!method initialize(*options)
  #   @option args [#resolve(params)] :auth_resolver (Auth::Resolver.new)
  #     A class that responds to a `resolve(auth_params)` method where `auth_params` is
  #     the {Auth::Params} struct. For a given operation_name, the method must return an
  #     ordered list of {Hearth::AuthOption} objects to be considered for authentication.
  #   @option args [Array<Hearth::AuthSchemes::Base>] :auth_schemes (Auth::SCHEMES)
  #     An ordered list of {Hearth::AuthSchemes::Base} objects that will considered when attempting to authenticate
  #     the request. The first scheme that returns an Identity from its Hearth::IdentityProvider will be used to
  #     authenticate the request.
  #   @option args [Boolean] :disable_host_prefix (false)
  #     When `true`, does not perform host prefix injection using @endpoint trait's hostPrefix property.
  #   @option args [Boolean] :disable_request_compression (false)
  #     When set to 'true' the request body will not be compressed for supported operations.
  #   @option args [String] :endpoint
  #     Endpoint of the service
  #   @option args [#resolve(params)] :endpoint_resolver (Endpoint::Resolver.new)
  #     The endpoint resolver used to resolve endpoints. Any object that responds to
  #     `#resolve(parameters)`
  #   @option args [Hearth::IdentityProvider] :http_api_key_identity_resolver
  #     A Hearth::IdentityProvider that returns a Hearth::Identities::HTTPApiKey for operations modeled with the smithy.api#httpApiKeyAuth auth scheme.
  #   @option args [Hearth::IdentityProvider] :http_bearer_identity_resolver
  #     A Hearth::IdentityProvider that returns a Hearth::Identities::HTTPBearer for operations modeled with the smithy.api#httpBearerAuth auth scheme.
  #   @option args [Hearth::HTTP::Client] :http_client (Hearth::HTTP::Client.new)
  #     The HTTP Client to use for request transport.
  #   @option args [Hearth::IdentityProvider] :http_custom_auth_identity_resolver
  #     A Hearth::IdentityProvider that returns a Auth::HTTPCustomAuthIdentity for operations modeled with the smithy.api#httpBasicAuth auth scheme.
  #   @option args [Hearth::IdentityProvider] :http_login_identity_resolver
  #     A Hearth::IdentityProvider that returns a Hearth::Identities::HTTPLogin for operations modeled to use it.
  #   @option args [Hearth::InterceptorList] :interceptors (Hearth::InterceptorList.new)
  #     A list of Interceptors to apply to the client.  Interceptors are a generic
  #     extension point that allows injecting logic at specific stages of execution
  #     within the SDK. Logic injection is done with hooks that the interceptor
  #     implements.  Hooks are either read-only or read/write. Read-only hooks allow
  #     an interceptor to read the input, transport request, transport response or
  #     output messages. Read/write hooks allow an interceptor to modify one of these
  #     messages.
  #   @option args [Logger] :logger (Logger.new(IO::NULL))
  #     The Logger instance to use for logging.
  #   @option args [Hearth::PluginList] :plugins (Hearth::PluginList.new)
  #     A list of Plugins to apply to the client. Plugins are callables that
  #     take {Config} as an argument. Plugins may modify the provided config.
  #   @option args [Integer] :request_min_compression_size_bytes (10240)
  #     The minimum size bytes that triggers compression for request bodies.
  #     The value must be non-negative integer value between 0 and 10485780 bytes inclusive.
  #   @option args [#acquire_initial_retry_token(token_scope),#refresh_retry_token(retry_token, error_info),#record_success(retry_token)] :retry_strategy (Hearth::Retry::Standard.new)
  #     Specifies which retry strategy class to use. Strategy classes may have additional
  #     options, such as `max_retries` and backoff strategies.
  #
  #     Available options are:
  #     * `Retry::Standard` - A standardized set of retry rules across the AWS SDKs. This
  #       includes support for retry quotas, which limit the number of unsuccessful retries
  #       a client can make.
  #     * `Retry::Adaptive` - An experimental retry mode that includes all the functionality
  #       of `standard` mode along with automatic client side throttling. This is a provisional
  #       mode that may change behavior in the future.
  #   @option args [String] :stage
  #     Specify the stage (beta|gamma|prod)
  #   @option args [Boolean] :stub_responses (false)
  #     Enable response stubbing for testing. See {Hearth::ClientStubs#stub_responses}.
  #   @option args [String] :test_config ('default')
  #     A Test Config
  #   @option args [Boolean] :validate_input (true)
  #     When `true`, request parameters are validated using the modeled shapes.
  # @!attribute auth_resolver
  #   @return [#resolve(params)]
  # @!attribute auth_schemes
  #   @return [Array<Hearth::AuthSchemes::Base>]
  # @!attribute disable_host_prefix
  #   @return [Boolean]
  # @!attribute disable_request_compression
  #   @return [Boolean]
  # @!attribute endpoint
  #   @return [String]
  # @!attribute endpoint_resolver
  #   @return [#resolve(params)]
  # @!attribute http_api_key_identity_resolver
  #   @return [Hearth::IdentityProvider]
  # @!attribute http_bearer_identity_resolver
  #   @return [Hearth::IdentityProvider]
  # @!attribute http_client
  #   @return [Hearth::HTTP::Client]
  # @!attribute http_custom_auth_identity_resolver
  #   @return [Hearth::IdentityProvider]
  # @!attribute http_login_identity_resolver
  #   @return [Hearth::IdentityProvider]
  # @!attribute interceptors
  #   @return [Hearth::InterceptorList]
  # @!attribute logger
  #   @return [Logger]
  # @!attribute plugins
  #   @return [Hearth::PluginList]
  # @!attribute request_min_compression_size_bytes
  #   @return [Integer]
  # @!attribute retry_strategy
  #   @return [#acquire_initial_retry_token(token_scope),#refresh_retry_token(retry_token, error_info),#record_success(retry_token)]
  # @!attribute stage
  #   @return [String]
  # @!attribute stub_responses
  #   @return [Boolean]
  # @!attribute test_config
  #   @return [String]
  # @!attribute validate_input
  #   @return [Boolean]
  Config = ::Struct.new(
    :auth_resolver,
    :auth_schemes,
    :disable_host_prefix,
    :disable_request_compression,
    :endpoint,
    :endpoint_resolver,
    :http_api_key_identity_resolver,
    :http_bearer_identity_resolver,
    :http_client,
    :http_custom_auth_identity_resolver,
    :http_login_identity_resolver,
    :interceptors,
    :logger,
    :plugins,
    :request_min_compression_size_bytes,
    :retry_strategy,
    :stage,
    :stub_responses,
    :test_config,
    :validate_input,
    keyword_init: true
  ) do
    include Hearth::Configuration

    # Validates the configuration.
    def validate!
      Hearth::Validator.validate_responds_to!(auth_resolver, :resolve, context: 'config[:auth_resolver]')
      Hearth::Validator.validate_types!(auth_schemes, Array, context: 'config[:auth_schemes]')
      Hearth::Validator.validate_types!(disable_host_prefix, TrueClass, FalseClass, context: 'config[:disable_host_prefix]')
      Hearth::Validator.validate_types!(disable_request_compression, TrueClass, FalseClass, context: 'config[:disable_request_compression]')
      Hearth::Validator.validate_types!(endpoint, String, context: 'config[:endpoint]')
      Hearth::Validator.validate_responds_to!(endpoint_resolver, :resolve, context: 'config[:endpoint_resolver]')
      Hearth::Validator.validate_types!(http_api_key_identity_resolver, Hearth::IdentityProvider, context: 'config[:http_api_key_identity_resolver]')
      Hearth::Validator.validate_types!(http_bearer_identity_resolver, Hearth::IdentityProvider, context: 'config[:http_bearer_identity_resolver]')
      Hearth::Validator.validate_types!(http_client, Hearth::HTTP::Client, context: 'config[:http_client]')
      Hearth::Validator.validate_types!(http_custom_auth_identity_resolver, Hearth::IdentityProvider, context: 'config[:http_custom_auth_identity_resolver]')
      Hearth::Validator.validate_types!(http_login_identity_resolver, Hearth::IdentityProvider, context: 'config[:http_login_identity_resolver]')
      Hearth::Validator.validate_types!(interceptors, Hearth::InterceptorList, context: 'config[:interceptors]')
      Hearth::Validator.validate_types!(logger, Logger, context: 'config[:logger]')
      Hearth::Validator.validate_types!(plugins, Hearth::PluginList, context: 'config[:plugins]')
      Hearth::Validator.validate_types!(request_min_compression_size_bytes, Integer, context: 'config[:request_min_compression_size_bytes]')
      Hearth::Validator.validate_range!(request_min_compression_size_bytes, min: 0, max: 10485760, context: 'config[:request_min_compression_size_bytes]')
      Hearth::Validator.validate_responds_to!(retry_strategy, :acquire_initial_retry_token, :refresh_retry_token, :record_success, context: 'config[:retry_strategy]')
      Hearth::Validator.validate_types!(stage, String, context: 'config[:stage]')
      Hearth::Validator.validate_types!(stub_responses, TrueClass, FalseClass, context: 'config[:stub_responses]')
      Hearth::Validator.validate_types!(test_config, String, context: 'config[:test_config]')
      Hearth::Validator.validate_types!(validate_input, TrueClass, FalseClass, context: 'config[:validate_input]')
    end

    private

    def defaults
      {
        auth_resolver: [Auth::Resolver.new],
        auth_schemes: [Auth::SCHEMES],
        disable_host_prefix: [false],
        disable_request_compression: [false],
        endpoint: [proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil }],
        endpoint_resolver: [Endpoint::Resolver.new],
        http_api_key_identity_resolver: [proc { |cfg| cfg[:stub_responses] ? Hearth::IdentityProvider.new(proc { Hearth::Identities::HTTPApiKey.new(key: 'stubbed api key') }) : nil }],
        http_bearer_identity_resolver: [proc { |cfg| cfg[:stub_responses] ? Hearth::IdentityProvider.new(proc { Hearth::Identities::HTTPBearer.new(token: 'stubbed bearer') }) : nil }],
        http_client: [proc { |cfg| Hearth::HTTP::Client.new(logger: cfg[:logger]) }],
        http_custom_auth_identity_resolver: [proc { |cfg| cfg[:stub_responses] ? Hearth::IdentityProvider.new(proc { Auth::HTTPCustomAuthIdentity.new(key: 'key') }) : nil }],
        http_login_identity_resolver: [proc { |cfg| cfg[:stub_responses] ? Hearth::IdentityProvider.new(proc { Hearth::Identities::HTTPLogin.new(username: 'stubbed username', password: 'stubbed password') }) : nil }],
        interceptors: [Hearth::InterceptorList.new],
        logger: [Logger.new(IO::NULL)],
        plugins: [Hearth::PluginList.new],
        request_min_compression_size_bytes: [10240],
        retry_strategy: [Hearth::Retry::Standard.new],
        stage: [],
        stub_responses: [false],
        test_config: ['default'],
        validate_input: [true]
      }.freeze
    end
  end
end
