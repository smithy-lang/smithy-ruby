# frozen_string_literal: true

require 'delegate'
require 'net/http'
require 'logger'
require 'openssl'

module Hearth
  module HTTP
    # An HTTP client that uses Net::HTTP to send requests.
    class Client
      # @api private
      OPTIONS = {
        logger: nil,
        debug_output: nil,
        proxy: nil,
        open_timeout: 15,
        read_timeout: nil,
        keep_alive_timeout: 5,
        continue_timeout: 1,
        write_timeout: nil,
        ssl_timeout: nil,
        verify_peer: true,
        ca_file: nil,
        ca_path: nil,
        cert_store: nil,
        host_resolver: nil
      }.freeze

      # Initialize an instance of this HTTP client.
      #
      # @param [Hash] options The options for this HTTP Client
      #
      # @option options [Logger] :logger (nil) A logger used to log Net::HTTP
      #   requests and responses when `:debug_output` is enabled.
      #
      # @option options [Boolean] :debug_output (false) When `true`,
      #   sets an output stream to the configured Logger (if any) for debugging.
      #
      # @option options [String, URI] :proxy A proxy to send
      #   requests through. Formatted like 'http://proxy.com:123'.
      #
      # @option options [Float] :open_timeout (15) Number of seconds to
      #   wait for the connection to open.
      #
      # @option options [Float] :read_timeout Number of seconds to wait
      #   for one block to be read (via one read(2) call).
      #
      # @option options [Float] :keep_alive_timeout (5) Seconds to reuse the
      #   connection of the previous request.
      #
      # @option options [Float] :continue_timeout (1) Seconds to wait for
      #   100 Continue response.
      #
      # @option options [Float] :write_timeout Number of seconds to wait
      #   for one block to be written (via one write(2) call).
      #
      # @option options [Float] :ssl_timeout Sets the SSL timeout seconds.
      #
      # @option options [Boolean] :verify_peer (true) When `true`,
      #   SSL peer certificates are verified when establishing a
      #   connection.
      #
      # @option options [String] :ca_file Full path to the SSL
      #   certificate authority bundle file that should be used when
      #   verifying peer certificates.  If you do not pass
      #   `:ca_file` or `:ca_path` the system default
      #   will be used if available.
      #
      # @option options [String] :ca_path Full path of the
      #   directory that contains the unbundled SSL certificate
      #   authority files for verifying peer certificates.  If you do
      #   not pass `:ca_file` or `:ca_path` the
      #   system default will be used if available.
      #
      # @option options [OpenSSL::X509::Store] :cert_store An OpenSSL X509
      #   certificate store that contains the SSL certificate authority.
      #
      # @option options [#resolve_address] :host_resolver
      #   An object, such as {Hearth::DNS::HostResolver} that responds to
      #   `#resolve_address`, returning an array of up to two IP addresses for
      #   the given hostname, one IPv6 and one IPv4, in that order.
      #   `#resolve_address` should take a nodename keyword argument and
      #   optionally other keyword args similar to Addrinfo.getaddrinfo's
      #   positional parameters.
      def initialize(options = {})
        unknown = options.keys - OPTIONS.keys
        raise ArgumentError, "Unknown options: #{unknown}" unless unknown.empty?

        OPTIONS.each_pair do |opt_name, default_value|
          value = options.key?(opt_name) ? options[opt_name] : default_value
          instance_variable_set("@#{opt_name}", value)
        end
      end

      OPTIONS.each_key do |attr_name|
        attr_reader(attr_name)
      end

      # @param [Request] request
      # @param [Response] response
      # @param [Logger] logger (nil)
      # @return [Response]
      def transmit(request:, response:, logger: nil)
        net_request = build_net_request(request)
        with_connection_pool(request.uri, logger) do |connection|
          _transmit(connection, net_request, response)
        end
        response.body.rewind if response.body.respond_to?(:rewind)
        response
      rescue ArgumentError => e
        # Invalid verb, ArgumentError is a StandardError
        raise e
      rescue StandardError => e
        raise Hearth::HTTP::NetworkingError, e
      end

      private

      def with_connection_pool(endpoint, logger)
        pool = ConnectionPool.for(pool_config)
        connection = pool.connection_for(endpoint) do
          new_connection(endpoint, logger)
        end
        yield connection
        pool.offer(endpoint, connection)
      rescue StandardError => e
        connection&.finish
        raise e
      end

      # Starts and returns a new HTTP connection.
      # @return [Net::HTTP]
      def new_connection(endpoint, logger)
        http = create_http(endpoint)
        http.set_debug_output(@logger || logger) if @debug_output
        configure_timeouts(http)

        if endpoint.scheme == 'https'
          configure_ssl(http)
        else
          http.use_ssl = false
        end

        http.start
        http
      end

      def _transmit(http, net_request, response)
        # Inform monkey patch to use our DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = @host_resolver
        http.request(net_request) do |net_resp|
          unpack_response(net_resp, response)
        end
      ensure
        # Restore the default DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = nil
      end

      def unpack_response(net_resp, response)
        response.status = net_resp.code.to_i
        net_resp.each_header { |k, v| response.headers[k] = v }
        net_resp.read_body do |chunk|
          response.body.write(chunk)
        end
      end

      # Creates an HTTP connection to the endpoint.
      # Applies proxy if set.
      def create_http(endpoint)
        args = []
        args << endpoint.host
        args << endpoint.port
        args += proxy_parts if @proxy
        # Net::HTTP.new uses positional arguments: host, port, proxy_args....
        HTTP.new(Net::HTTP.new(*args.compact))
      end

      def configure_timeouts(http)
        http.open_timeout = @open_timeout
        http.keep_alive_timeout = @keep_alive_timeout
        http.read_timeout = @read_timeout
        http.continue_timeout = @continue_timeout
        http.write_timeout = @write_timeout
      end

      # applies ssl settings to the HTTP object
      def configure_ssl(http)
        http.use_ssl = true
        http.ssl_timeout = @ssl_timeout
        if @verify_peer
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.ca_file = @ca_file
          http.ca_path = @ca_path
          http.cert_store = @cert_store
        else
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

      # Constructs and returns a Net::HTTP::Request object from
      # a {Http::Request}.
      # @param [Http::Request] request
      # @return [Net::HTTP::Request]
      def build_net_request(request)
        request_class = net_http_request_class(request)
        req = request_class.new(request.uri, net_headers_for(request))

        # Net::HTTP adds a default Content-Type when a body is present.
        # Set the body stream when it has an unknown size or when it is > 0.
        # We instead add our own Content-Length header via Middleware.
        if !request.body.respond_to?(:size) ||
           (request.body.respond_to?(:size) && request.body.size.positive?)
          req.body_stream = request.body
        end
        req
      end

      # Validate that fields are not trailers and return a hash of headers.
      # @param [HTTP::Request] request
      # @return [Hash<String, String>]
      def net_headers_for(request)
        # Trailers are not supported in Net::HTTP
        if request.trailers.any?
          raise NotImplementedError, 'Trailers are not supported in Net::HTTP'
        end

        request.headers.to_h
      end

      # @param [Http::Request] request
      # @raise [InvalidHttpVerbError]
      # @return Returns a base `Net::HTTP::Request` class, e.g.,
      #   `Net::HTTP::Get`, `Net::HTTP::Post`, etc.
      def net_http_request_class(request)
        Net::HTTP.const_get(request.http_method.capitalize)
      rescue NameError
        msg = "`#{request.http_method}` is not a valid http verb"
        raise ArgumentError, msg
      end

      # Extract the parts of the proxy URI
      # @return [Array]
      def proxy_parts
        proxy = URI(@proxy)
        [
          proxy.host,
          proxy.port,
          proxy.user && CGI.unescape(proxy.user),
          proxy.password && CGI.unescape(proxy.password)
        ]
      end

      # Config options for the HTTP client used for connection pooling
      # @return [Hash]
      def pool_config
        OPTIONS.each_key.with_object({}) do |option_name, hash|
          hash[option_name] = instance_variable_get("@#{option_name}")
        end
      end

      # Helper methods extended onto Net::HTTP objects.
      # @api private
      class HTTP < SimpleDelegator
        def initialize(http)
          super
          @http = http
        end

        # @return [Integer, nil]
        attr_reader :last_used

        # Sends the request and tracks that this connection has been used.
        def request(...)
          @http.request(...)
          @last_used = monotonic_milliseconds
        end

        def stale?
          @last_used.nil? ||
            (monotonic_milliseconds - @last_used) > keep_alive_timeout * 1000
        end

        # Attempts to close/finish the connection without raising an error.
        def finish
          @http.finish
        rescue IOError
          nil
        end

        private

        def monotonic_milliseconds
          Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
        end
      end
    end
  end
end
