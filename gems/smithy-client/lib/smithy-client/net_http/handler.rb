# frozen_string_literal: true

module Smithy
  module Client
    module NetHTTP
      # The default HTTP handler for Smithy::Client. This is based on Ruby's `Net::HTTP`.
      # @api private
      class Handler < Client::Handler
        # @api private
        class TruncatedBodyError < IOError
          def initialize(bytes_expected, bytes_received)
            msg = "http response body truncated, expected #{bytes_expected} " \
                  "bytes, received #{bytes_received} bytes"
            super(msg)
          end
        end

        # @param [HandlerContext] context
        # @return [Output]
        def call(context)
          output = Output.new(context: context)
          transmit(context.config, context.request, context.response, output)
          output
        end

        private

        # @param [Configuration] config
        # @param [HTTP::Request] req
        # @param [Http::Response] resp
        # @param [Output] output
        # @return [void]
        def transmit(config, req, resp, output)
          # Monkey patch default content-type set by Net::HTTP
          Thread.current[:net_http_skip_default_content_type] = true
          session(config, req) do |http|
            http.request(build_net_request(req)) do |net_resp|
              bytes_received = unpack_response(net_resp, resp)
              complete_response(req, resp, output, bytes_received)
            end
          end
        rescue ArgumentError
          # Invalid verb, ArgumentError is a StandardError
          # Not retryable.
          raise
        rescue StandardError => e
          output.error = NetworkingError.new(e)
        ensure
          # ensure we turn off monkey patch in case of error
          Thread.current[:net_http_skip_default_content_type] = nil
        end

        # @param [Net::HTTPResponse] net_resp
        # @param [HTTP::Response] resp
        def unpack_response(net_resp, resp)
          resp.status_code = net_resp.code.to_i
          net_resp.each_header { |k, v| resp.headers[k] = v }
          bytes_received = 0
          net_resp.read_body do |chunk|
            bytes_received += chunk.bytesize
            resp.body.write(chunk)
          end
          bytes_received
        end

        def complete_response(req, resp, output, bytes_received)
          resp.body.rewind if resp.body.respond_to?(:rewind)
          verify_bytes_received(resp, output, bytes_received) if should_verify_bytes?(req, resp)
        end

        def should_verify_bytes?(req, resp)
          req.http_method != 'HEAD' && resp.headers['content-length']
        end

        def verify_bytes_received(resp, output, bytes_received)
          bytes_expected = resp.headers['content-length'].to_i
          return if bytes_expected == bytes_received

          error = TruncatedBodyError.new(bytes_expected, bytes_received)
          output.error = NetworkingError.new(error)
        end

        # @param [Configuration] config
        # @param [HTTP::Request] req
        # @yieldparam [Net::HTTP] http
        def session(config, req, &block)
          pool_for(config).session_for(req.endpoint, &block)
        end

        # @param [Configuration] config
        # @return [ConnectionPool]
        def pool_for(config)
          ConnectionPool.for(pool_options(config))
        end

        # Extracts the {ConnectionPool} configuration options.
        # @param [Configuration] config
        # @return [Hash]
        def pool_options(config)
          ConnectionPool::OPTIONS.keys.each_with_object({}) do |opt, opts|
            opts[opt] = config.send(opt)
          end
        end

        # Constructs and returns a Net::HTTP::Request object from a {HTTP::Request}.
        # @param [HTTP::Request] request
        # @return [Net::HTTP::Request]
        def build_net_request(request)
          request_class = net_http_request_class(request)
          req = request_class.new(request.endpoint.request_uri, net_headers_for(request))

          # Net::HTTP adds a default Content-Type when a body is present.
          # Set the body stream when it has an unknown size or when it is > 0.
          if !request.body.respond_to?(:size) ||
             (request.body.respond_to?(:size) && request.body.size.positive?)
            req.body_stream = request.body
          end
          req
        end

        # @param [HTTP::Request] request
        # @raise [ArgumentError]
        # @return Returns a base `Net::HTTP::Request` class, e.g.,
        #  `Net::HTTP::Get`, `Net::HTTP::Post`, etc.
        def net_http_request_class(request)
          Net::HTTP.const_get(request.http_method.capitalize)
        rescue NameError
          msg = "`#{request.http_method}` is not a valid http verb"
          raise ArgumentError, msg
        end

        # Validate that fields are not trailers and return a hash of headers.
        # @param [HTTP::Request] request
        # @return [Hash<String, String>]
        def net_headers_for(request)
          # Trailers are not supported in Net::HTTP
          raise NotImplementedError, 'Trailers are not supported in Net::HTTP' if request.trailers.any?

          # Net::HTTP adds a default header for accept-encoding (2.0.0+).
          # Setting a default empty value defeats this.
          # Removing this is necessary for most services to not break request
          # signatures as well as dynamodb crc32 checks (these fail if the
          # response is gzipped).
          # TODO: keeping this disabled to see if we can fix this
          # headers = { 'accept-encoding' => '' }
          headers = {}
          request.headers.each_pair do |key, value|
            headers[key] = value
          end
          headers
        end
      end
    end
  end
end
