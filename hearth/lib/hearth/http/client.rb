# frozen_string_literal: true

require 'delegate'
require 'net/http'
require 'logger'
require 'openssl'

module Hearth
  module HTTP
    # An HTTP client that uses Net::HTTP to send requests.
    class Client
      # Initialize an instance of this HTTP client.
      #
      # @param [Hash] options The options for this HTTP Client
      #
      # @option options [Boolean] :debug_output (false) When `true`,
      #   sets an output stream to the configured Logger for debugging.
      #
      # @option options [String] :proxy A proxy to send
      #   requests through. Formatted like 'http://proxy.com:123'.
      #
      # @option options [Float] :open_timeout Number of seconds to
      #   wait for the connection to open.
      #
      # @option options [Float] :read_timeout Number of seconds to wait
      #   for one block to be read (via one read(2) call).
      #
      # @option options [Float] :keep_alive_timeout Seconds to reuse the
      #   connection of the previous request.
      #
      # @option options [Float] :continue_timeout Seconds to wait for
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
      # @option options [#resolve_address] (nil) :host_resolver
      #   An object, such as {Hearth::DNS::HostResolver} that responds to
      #   `#resolve_address`, returning an array of up to two IP addresses for
      #   the given hostname, one IPv6 and one IPv4, in that order.
      #   `#resolve_address` should take a nodename keyword argument and
      #   optionally other keyword args similar to Addrinfo.getaddrinfo's
      #   positional parameters.
      def initialize(options = {})
        @debug_output = options[:debug_output]
        @proxy = URI(options[:proxy]) if options[:proxy]
        @open_timeout = options[:open_timeout]
        @read_timeout = options[:read_timeout]
        @keep_alive_timeout = options[:keep_alive_timeout]
        @continue_timeout = options[:continue_timeout]
        @write_timeout = options[:write_timeout]
        @ssl_timeout = options[:ssl_timeout]
        @verify_peer = options[:verify_peer]
        @ca_file = options[:ca_file]
        @ca_path = options[:ca_path]
        @cert_store = options[:cert_store]
        @host_resolver = options[:host_resolver]
      end

      # @param [Request] request
      # @param [Response] response
      # @return [Response]
      def transmit(request:, response:, **options)
        # http = create_http(request.uri)
        # http.set_debug_output(options[:logger]) if @debug_output
        # configure_timeouts(http)
        #
        # if request.uri.scheme == 'https'
        #   configure_ssl(http)
        # else
        #   http.use_ssl = false
        # end
        endpoint = request.uri
        pool = ConnectionPool.for(config)
        session = pool.session_for(endpoint) do
          start_session(endpoint)
        end
        _transmit2(session, request, response)
        pool.offer(endpoint, session)

        # _transmit(http, request, response)
        response.body.rewind if response.body.respond_to?(:rewind)
        response
      rescue ArgumentError => e
        session&.finish
        # Invalid verb, ArgumentError is a StandardError
        raise e
      rescue StandardError => e
        session&.finish
        Hearth::HTTP::NetworkingError.new(e)
      end

      private

      # Starts and returns a new HTTP session.
      # @param [URI] endpoint
      # @return [Net::HTTP]
      def start_session(endpoint)
        puts "starting a new session for #{endpoint}"
        http = create_http(endpoint)
        http.set_debug_output(options[:logger]) if @debug_output
        configure_timeouts(http)

        if endpoint.scheme == 'https'
          configure_ssl(http)
        else
          http.use_ssl = false
        end

        http.start
        http
      end

      def _transmit(http, request, response)
        # Inform monkey patch to use our DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = @host_resolver
        http.start do |conn|
          conn.request(build_net_request(request)) do |net_resp|
            unpack_response(net_resp, response)
          end
        end
      ensure
        # Restore the default DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = nil
      end

      def _transmit2(http, request, response)
        # Inform monkey patch to use our DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = @host_resolver
        http.request(build_net_request(request)) do |net_resp|
          unpack_response(net_resp, response)
        end
      ensure
        # Restore the default DNS resolver
        Thread.current[:net_http_hearth_dns_resolver] = nil
      end

      def configure_timeouts(http)
        http.open_timeout = @open_timeout if @open_timeout
        http.keep_alive_timeout = @keep_alive_timeout if @keep_alive_timeout
        http.read_timeout = @read_timeout if @read_timeout
        http.continue_timeout = @continue_timeout if @continue_timeout
        http.write_timeout = @write_timeout if @write_timeout
      end

      def unpack_response(net_resp, response)
        response.status = net_resp.code.to_i
        net_resp.each_header { |k, v| response.headers[k] = v }
        net_resp.read_body do |chunk|
          response.body.write(chunk)
        end
      end

      def config
        {
          debug_output: @debug_output,
          proxy: @proxy,
          open_timeout: @open_timeout,
          read_timeout: @read_timeout,
          keep_alive_timeout: @keep_alive_timeout,
          continue_timeout: @continue_timeout,
          write_timeout: @write_timeout,
          ssl_timeout: @ssl_timeout,
          verify_peer: @verify_peer,
          ca_file: @ca_file,
          ca_path: @ca_path,
          cert_store: @cert_store,
          host_resolver: @host_resolver
        }
      end

      # Creates an HTTP connection to the endpoint
      # Applies proxy if set
      def create_http(endpoint)
        args = []
        args << endpoint.host
        args << endpoint.port
        args += proxy_parts if @proxy
        # Net::HTTP.new uses positional arguments: host, port, proxy_args....
        HTTP.new(Net::HTTP.new(*args.compact))
      end

      # applies ssl settings to the HTTP object
      def configure_ssl(http)
        http.use_ssl = true
        http.ssl_timeout = @ssl_timeout if @ssl_timeout
        if @verify_peer
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.ca_file = @ca_file if @ca_file
          http.ca_path = @ca_path if @ca_path
          http.cert_store = @cert_store if @cert_store
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
        req = request_class.new(request.uri.to_s, net_headers_for(request))

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
        [
          @proxy.host,
          @proxy.port,
          (@proxy.user && CGI.unescape(@proxy.user)),
          (@proxy.password && CGI.unescape(@proxy.password))
        ]
      end

      # Helper methods extended onto Net::HTTP objects opened by the
      # connection manager.
      # @api private
      class HTTP < Delegator
        def initialize(http)
          super(http)
          @http = http
        end

        # @return [Integer, nil]
        attr_reader :last_used

        def __getobj__
          @http
        end

        def __setobj__(obj)
          @http = obj
        end

        # Sends the request and tracks that this session has been used.
        def request(...)
          @http.request(...)
          @last_used = monotonic_milliseconds
        end

        def stale?
          @last_used.nil? ||
            (monotonic_milliseconds - @last_used) > keep_alive_timeout * 1000
        end

        # Attempts to close/finish the session without raising an error.
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
