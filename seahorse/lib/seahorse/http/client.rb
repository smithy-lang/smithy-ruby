# frozen_string_literal: true

require 'net/http'
require 'logger'
require 'openssl'

module Seahorse
  module HTTP
    # Transmits an HTTP {Request} object, returning an HTTP {Response}.
    class Client

      NETWORK_ERRORS = [
        SocketError, EOFError, IOError, Timeout::Error,
        Errno::ECONNABORTED, Errno::ECONNRESET, Errno::EPIPE,
        Errno::EINVAL, Errno::ETIMEDOUT, OpenSSL::SSL::SSLError,
        Errno::EHOSTUNREACH, Errno::ECONNREFUSED,
        Net::HTTPFatalError # for proxy connection failures
      ].freeze

      # @param [Boolean] http_wire_trace (false) When `true`,
      #   HTTP debug output will be sent to the `:logger`.
      #
      # @param [Logger] logger (Logger.new($stdout)) Where debug output is sent.
      #
      # @param [URI::HTTP,String] http_proxy A proxy to send
      #   requests through. Formatted like 'http://proxy.com:123'.
      #
      # @param [Boolean] ssl_verify_peer (true) When `true`,
      #   SSL peer certificates are verified when establishing a
      #   connection.
      #
      # @param [String] ssl_ca_bundle Full path to the SSL
      #   certificate authority bundle file that should be used when
      #   verifying peer certificates.  If you do not pass
      #   `:ssl_ca_bundle` or `:ssl_ca_directory` the system default
      #   will be used if available.
      #
      # @param [String] ssl_ca_directory Full path of the
      #   directory that contains the unbundled SSL certificate
      #   authority files for verifying peer certificates.  If you do
      #   not pass `:ssl_ca_bundle` or `:ssl_ca_directory` the
      #   system default will be used if available.
      def initialize(http_wire_trace:, logger:,
                     http_proxy: nil, ssl_verify_peer: true,
                     ssl_ca_bundle: nil, ssl_ca_directory: nil,
                     ssl_ca_store: nil)
        @http_wire_trace =  http_wire_trace
        @logger = logger
        @http_proxy = URI.parse(http_proxy.to_s) if http_proxy
        @ssl_verify_peer = ssl_verify_peer
        @ssl_ca_bundle = ssl_ca_bundle
        @ssl_ca_directory = ssl_ca_directory
        @ssl_ca_store = ssl_ca_store
      end

      # @param [Request] request
      # @param [Response] response
      # @return [Response]
      def transmit(request:, response:)
        uri = URI.parse(request.url)
        http = create_http(uri)
        http.set_debug_output(@logger) if @http_wire_trace

        if uri.scheme == 'https'
          configure_ssl(http)
        else
          http.use_ssl = false
        end

        http.start do |http|
          http.request(build_net_request(request)) do |net_resp|
            response.status = net_resp.code.to_i
            response.headers = extract_headers(net_resp)
            net_resp.read_body do |chunk|
              response.body.write(chunk)
            end
          end
        end
        response.body.rewind if response.body.respond_to?(:rewind)
        response
      rescue *NETWORK_ERRORS => e
        raise Seahorse::HTTP::NetworkingError, e
      end

      private

      # Creates an HTTP connection to the endpoint
      # Applies proxy if set
      def create_http(endpoint)
        args = []
        args << endpoint.host
        args << endpoint.port
        args += http_proxy_parts if @http_proxy
        # Net::HTTP.new uses positional arguments: host, port, proxy_args....
        Net::HTTP.new(*args.compact)
      end

      # applies ssl settings to the HTTP object
      def configure_ssl(http)
        http.use_ssl = true
        if @ssl_verify_peer
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.ca_file = @ssl_ca_bundle if @ssl_ca_bundle
          http.ca_path = @ssl_ca_directory if @ssl_ca_directory
          http.cert_store = @ssl_ca_store if @ssl_ca_store
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
        req = request_class.new(request.url, request.headers.to_h)
        req.body_stream = request.body
        req
      end

      # @param [Net::HTTP::Response] response
      # @return [Hash<String, String>]
      def extract_headers(response)
        response.to_hash.transform_values(&:first)
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

      # Extract the parts of the http_proxy URI
      # @return [Array(String)]
      def http_proxy_parts
        [
          @http_proxy.host,
          @http_proxy.port,
          (@http_proxy.user && CGI.unescape(@http_proxy.user)),
          (@http_proxy.password && CGI.unescape(@http_proxy.password))
        ]
      end

    end
  end
end
