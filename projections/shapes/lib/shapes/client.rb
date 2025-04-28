# frozen_string_literal: true

# This is generated code!

require_relative 'plugins/auth'
require_relative 'plugins/endpoint'
require 'smithy-client/plugins/content_length'
require 'smithy-client/plugins/logging'
require 'smithy-client/plugins/net_http'
require 'smithy-client/plugins/pageable_output'
require 'smithy-client/plugins/param_converter'
require 'smithy-client/plugins/param_validator'
require 'smithy-client/plugins/protocol'
require 'smithy-client/plugins/raise_response_errors'
require 'smithy-client/plugins/response_target'
require 'smithy-client/plugins/retry_errors'
require 'smithy-client/plugins/sign_requests'
require 'smithy-client/plugins/stub_responses'
require 'smithy-client/plugins/anonymous_auth'

module ShapeService
  # An API client for ShapeService.
  # See {#initialize} for a full list of supported configuration options.
  class Client < Smithy::Client::Base
    include Smithy::Client::Stubs

    self.service = Schema::SERVICE

    add_plugin(ShapeService::Plugins::Auth)
    add_plugin(ShapeService::Plugins::Endpoint)
    add_plugin(Smithy::Client::Plugins::ContentLength)
    add_plugin(Smithy::Client::Plugins::Logging)
    add_plugin(Smithy::Client::Plugins::NetHTTP)
    add_plugin(Smithy::Client::Plugins::PageableOutput)
    add_plugin(Smithy::Client::Plugins::ParamConverter)
    add_plugin(Smithy::Client::Plugins::ParamValidator)
    add_plugin(Smithy::Client::Plugins::Protocol)
    add_plugin(Smithy::Client::Plugins::RaiseResponseErrors)
    add_plugin(Smithy::Client::Plugins::ResponseTarget)
    add_plugin(Smithy::Client::Plugins::RetryErrors)
    add_plugin(Smithy::Client::Plugins::SignRequests)
    add_plugin(Smithy::Client::Plugins::StubResponses)
    add_plugin(Smithy::Client::Plugins::AnonymousAuth)

    # @param options [Hash] Client options
    # @option options [Boolean] :adaptive_retry_wait_to_fill (true)
    #  When true, the request will sleep until there is sufficient client side capacity to retry
    #  the request. When false, the request will raise a `CapacityNotAvailableError` and will
    #  not retry instead of sleeping.
    # @option options [ShapeService::AuthResolver] :auth_resolver
    #  The auth resolver used to resolve authentication. Any object that responds to `#resolve(parameters)`.
    # @option options [Hash] :auth_schemes
    #  The auth schemes used to resolve authentication. The key is the scheme name as a String,
    #  and the value is an initialized auth scheme class.
    # @option options [Boolean] :convert_params (true)
    #  When `true`, request parameters are coerced into the required types.
    # @option options [String] :endpoint
    #  Custom Endpoint
    # @option options [ShapeService::EndpointProvider] :endpoint_provider
    #  The endpoint provider used to resolve endpoints. Any object that responds to `#resolve(parameters)`.
    # @option options [String] :http_ca_file
    #  The path to a CA certification file in PEM format. Defaults to `nil` which uses
    #  the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ca_file Net::HTTP#ca_file}.
    # @option options [String] :http_ca_path
    #  The path of to CA directory containing certification files in PEM format. Defaults to
    #  `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ca_path Net::HTTP#ca_path}.
    # @option options [OpenSSL::X509::Certificate] :http_cert
    #  Sets the OpenSSL::X509::Certificate object to be used for client certification. Defaults
    #  to `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-cert Net::HTTP#cert}.
    # @option options [OpenSSL::X509::Store] :http_cert_store
    #  Sets the OpenSSL::X509::Store to be used for verifying peer certificate. Defaults to
    #  `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-cert_store Net::HTTP#cert_store}.
    # @option options [Numeric] :http_continue_timeout
    #  Sets the continue timeout value, which is the number of seconds to wait for an
    #  expected 100 Continue response. If the HTTP object does not receive a response
    #  in this many seconds it sends the request body. Defaults to `nil` which uses the
    #  Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-continue_timeout Net::HTTP#continue_timeout}.
    # @option options [Boolean] :http_debug_output
    #  When `true`, Net::HTTP debug output will be sent to the configured logger.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#method-i-set_debug_output Net::HTTP#set_debug_output}.
    # @option options [Numeric] :http_keep_alive_timeout
    #  The number of seconds to keep the connection open after a request is sent. If a
    #  new request is made during the given interval, the still-open connection is used;
    #  otherwise the connection will have been closed and a new connection is opened.
    #  Defaults to `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-keep_alive_timeout Net::HTTP#keep_alive_timeout}.
    # @option options [OpenSSL::PKey::RSA, OpenSSL::PKey::DSA] :http_key
    #  Sets the OpenSSL::PKey object to be used for client private key. Defaults to `nil` which
    #  uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-key Net::HTTP#key}.
    # @option options [Numeric] :http_open_timeout
    #  The number of seconds to wait for a connection to open. If the connection is not
    #  made in the given interval, an exception is raised. Defaults to `nil` which uses
    #  the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-open_timeout Net::HTTP#open_timeout}.
    # @option options [URI::HTTP, String] :http_proxy
    #  A proxy to send requests through. Formatted like 'http://proxy.com:123'.
    # @option options [Numeric] :http_read_timeout
    #  The number of seconds to wait for one block to be read (via one read(2) call).
    #  Defaults to `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-read_timeout Net::HTTP#read_timeout}.
    # @option options [Numeric] :http_ssl_timeout
    #  Sets the SSL timeout seconds. Defaults to `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ssl_timeout Net::HTTP#ssl_timeout}.
    # @option options [Integer] :http_verify_mode (OpenSSL::SSL::VERIFY_PEER)
    #  Sets the verify mode for SSL. Defaults to `OpenSSL::SSL::VERIFY_PEER`.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-verify_mode Net::HTTP#verify_mode}.
    # @option options [Numeric] :http_write_timeout
    #  The number of seconds to wait for one block to be written (via one write(2) call).
    #  Defaults to `nil` which uses the Net::HTTP default value.
    #  See {https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-write_timeout Net::HTTP#write_timeout}.
    # @option options [Symbol] :log_level (info)
    #  The log level to send messages to the logger at.
    # @option options [Logger] :logger
    #  The Logger instance to send log messages to. If this option is not set,
    #  logging is disabled.
    # @option options [String, Class] :protocol (nil)
    #  The protocol to use for request serialization and response deserialization.
    # @option options [Boolean] :raise_response_errors (true)
    #  When `true`, response errors are raised. When `false`, the error is placed on the
    #  output in the {Smithy::Client::Output#error error accessor}.
    # @option options [lambda] :retry_backoff (Smithy::Client::Retry::EXPONENTIAL_BACKOFF)
    #  A callable object that calculates a backoff delay for a retry attempt. The callable
    #  should accept a single argument, `attempts`, that represents the number of attempts
    #  that have been made. Used in the `standard` and `adaptive` retry strategies.
    # @option options [Integer] :retry_max_attempts (3)
    #  The maximum number attempts that will be made for a single request, including
    #  the initial attempt. Used in the `standard` and `adaptive` retry strategies.
    # @option options [String, Class] :retry_strategy (standard)
    #  The retry strategy to use when retrying errors. This can be one of the following:
    #  * `standard` - A standardized retry strategy used by the AWS SDKs. This includes support
    #    for retry quotas, which limit the number of unsuccessful retries a client can make.
    #  * `adaptive` - An experimental retry strategy that includes all the functionality of the
    #    `standard` strategy along with automatic client side throttling. This is a provisional
    #    strategy that may change behavior in the future.
    #  * Any instance of a class that implements the following methods:
    #    - `acquire_initial_retry_token(token_scope)`
    #    - `refresh_retry_token(retry_token, error_info)`
    #    - `record_success(retry_token)`
    # @option options [Boolean] :stub_responses
    #  When true, the client will return stubbed responses instead of networking requests.
    #  By default fake responses are generated and returned. You can specify the response data
    #  to return or errors to raise by calling {Stubs#stub_responses}.
    #  @see Stubs
    # @option options [Boolean] :validate_params (true)
    #  When `true`, request parameters are validated before sending the request.
    def initialize(*options)
      super
    end

    # @example Request syntax with placeholder values
    #   params = {
    #     blob: "data",
    #     boolean: false,
    #     string: "String",
    #     byte: 97,
    #     short: 1,
    #     integer: 1,
    #     long: 1,
    #     float: 1.0,
    #     double: 1.0,
    #     big_integer: 1,
    #     big_decimal: BigDecimal(1),
    #     timestamp: Time.now,
    #     document: TODO: document,
    #     enum: "bar" # One of: ["bar"],
    #     int_enum: 1 # One of: [1],
    #     list: ["String"],
    #     map: {
    #       "String" => "String"
    #     },
    #     structure: {
    #       member: "String"
    #     },
    #     union: {
    #       # One of:
    #       string: "String",
    #       structure: {
    #         member: "String"
    #       },
    #       unit: {
    #       }
    #     }
    #   }
    #   options = {}
    #   output = client.operation(params, options)
    # @example Response structure with placeholder values
    #   output.to_h #=>
    #   {
    #     blob: "data",
    #     boolean: false,
    #     string: "String",
    #     byte: 97,
    #     short: 1,
    #     integer: 1,
    #     long: 1,
    #     float: 1.0,
    #     double: 1.0,
    #     big_integer: 1,
    #     big_decimal: BigDecimal(1),
    #     timestamp: Time.now,
    #     document: TODO: document,
    #     enum: "bar" # One of: ["bar"],
    #     int_enum: 1 # One of: [1],
    #     list: ["String"],
    #     map: {
    #       "String" => "String"
    #     },
    #     structure: {
    #       member: "String"
    #     },
    #     union: {
    #       # One of:
    #       string: "String",
    #       structure: {
    #         member: "String"
    #       },
    #       unit: {
    #       }
    #     }
    #   }
    def operation(params = {}, options = {})
      input = build_input(:operation, params)
      input.send_request(options)
    end

    def wait_until_custom(waiter_name, params = {}, options = {})
      operation_name, waiter_config = find_waiter(waiter_name)
      poller = poller_custom(operation_name, waiter_config["acceptors"])
      waiter = waiter_custom(waiter_config, options, poller)
      waiter.wait_custom(params)
    end

    private

    def build_input(operation_name, params)
      handlers = @handlers.for(operation_name)
      context = Smithy::Client::HandlerContext.new(
        operation_name: operation_name,
        operation: config.service.operation(operation_name),
        client: self,
        params: params,
        config: config,
      )
      context[:gem_name] = 'shapes'
      context[:gem_version] = '1.0.0'
      Smithy::Client::Input.new(handlers: handlers, context: context)
    end

    def find_waiter(waiter_name)
      operations = config.service.operations
      operations.each do |operation_name, operation|
        if (trait = waitable_trait(operation))
          trait.each do |name, waiter|
            if underscore(name) == waiter_name.to_s
              return [operation_name, waiter]
            end
          end
        end
      end
      nil
    end

    def waitable_trait(operation)
      if operation.traits && !operation.traits['smithy.waiters#waitable'].nil?
        operation.traits['smithy.waiters#waitable']
      end
    end

    def underscore(input)
      input.gsub(/::/, '/')
           .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
           .gsub(/([a-z\d])([A-Z])/,'\1_\2')
           .tr("-", "_")
           .downcase
    end

    def poller_custom(operation_name, acceptors)
      Smithy::Client::Waiters::Poller.new(
        operation_name: operation_name.to_sym,
        acceptors: acceptors
      )
    end

    def waiter_custom(waiter_config, options, poller)
      Smithy::Client::Waiters::Waiter.new(
        max_wait_time: options[:max_wait_time],
        min_delay: options[:min_delay] || waiter_config[:min_delay] || 2,
        max_delay: options[:max_delay] || waiter_config[:max_delay] || 120,
        poller: poller,
        client: self
      )
    end

    class << self
      # @api private
      attr_reader :identifier

      # @api private
      def protocols
        {}
      end

      # @api private
      def errors_module
        Errors
      end
    end
  end
end
