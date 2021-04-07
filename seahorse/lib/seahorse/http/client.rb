# frozen_string_literal: true
#
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
      ]

      def initialize(http_wire_trace:, logger:)
        @http_wire_trace =  http_wire_trace
        @logger = logger
      end

      # @param [Request] request
      # @param [Response] response
      # @return [Response]
      def transmit(request:, response:)
        # TODO: connection pool for connections
        uri = URI.parse(request.url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output(@logger) if @http_wire_trace

        if uri.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          # TODO: Support for Verify Peer + pass through ca bundle/dir/store
        else
          http.use_ssl = false
        end

        http.start do |http|
          http.request(build_net_request(request)) do |net_resp|
            response.status_code = net_resp.code.to_i
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
        response.to_hash.inject({}) do |headers, (k, v)|
          headers[k] = v.first
          headers
        end
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
    end

  end
end
