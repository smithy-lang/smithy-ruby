# frozen_string_literal: true

require 'net/http'
require 'logger'
require 'openssl'

module Hearth
  module HTTP
    # @api private
    class Client
      # Initialize an instance of this HTTP client.
      #
      # @param [Hash] options The options for this HTTP Client
      #
      # @option options [Boolean] :http_wire_trace (false) When `true`,
      #   HTTP debug output will be sent to the `:logger`.
      #
      # @option options [Logger] :logger A logger where debug output is sent.
      #
      # @option options [String] :proxy A proxy to send
      #   requests through. Formatted like 'http://proxy.com:123'.
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
      #   optionally other keyword args similar to {Addrinfo#getaddrinfo}'s
      #   positional parameters.
      def initialize(options = {})
        @http_wire_trace = options[:http_wire_trace]
        @proxy = URI(options[:proxy]) if options[:proxy]
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
        http = create_http(request.uri)
        http.set_debug_output(options[:logger]) if @http_wire_trace

        if request.uri.scheme == 'https'
          configure_ssl(http)
        else
          http.use_ssl = false
        end

        _transmit(http, request, response)
        response.body.rewind if response.body.respond_to?(:rewind)
        response
      rescue ArgumentError => e
        # Invalid verb, ArgumentError is a StandardError
        raise e
      rescue StandardError => e
        Hearth::HTTP::NetworkingError.new(e)
      end

      private

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

      def unpack_response(net_resp, response)
        response.status = net_resp.code.to_i
        net_resp.each_header { |k, v| response.headers[k] = v }
        net_resp.read_body do |chunk|
          response.body.write(chunk)
        end
      end

      # Creates an HTTP connection to the endpoint
      # Applies proxy if set
      def create_http(endpoint)
        args = []
        args << endpoint.host
        args << endpoint.port
        args += proxy_parts if @proxy
        # Net::HTTP.new uses positional arguments: host, port, proxy_args....
        Net::HTTP.new(*args.compact)
      end

      # applies ssl settings to the HTTP object
      def configure_ssl(http)
        http.use_ssl = true
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
    end
  end
end
