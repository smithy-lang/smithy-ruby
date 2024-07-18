# frozen_string_literal: true

require_relative 'connection'

module Hearth
  module HTTP2
    # An HTTP2 client that uses the http-2 gem and TCP connections
    # to send requests.
    # rubocop:disable Metrics/ClassLength
    class Client
      # @api private
      OPTIONS = {
        logger: nil,
        log_debug: false,
        max_concurrent_streams: 100,
        host_resolver: nil,
        open_timeout: 15, # in seconds
        verify_peer: true,
        ca_file: nil,
        ca_path: nil,
        cert_store: nil,
        enable_alpn: true
      }.freeze

      # Initialize an instance of this HTTP client.
      #
      # @param [Hash] options The options for this HTTP Client
      #
      # @option options [Logger] :logger (nil) A logger used to log
      #   requests and responses when `:debug_output` is enabled.
      #
      # @option options [Boolean] :debug_output (false) When `true`,
      #   sets an output stream to the configured Logger (if any) for debugging.
      #
      # @option options [Float] :open_timeout (15) Number of seconds to
      #   wait for the connection to open.
      #
      # @option options [Float] :max_concurrent_stream (100) Max number of
      #   concurrent streams on a single connection.  Note that the service
      #   may set a maximum as well and the smaller of the two will apply.
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
      # @option options [Boolean] :enable_alpn (true) When true enables
      #   ALPN for TLS. ALPN improves protocol negotiation performance by
      #   reducing round trips.
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

      def transmit(request:, response:, logger: nil)
        with_connection_pool(request.uri, logger) do |stream|
          response.stream = stream

          # setup handlers on the stream to write data to the response
          setup_stream_handlers(response, stream)

          # send initial request
          headers = h2_headers(request)
          stream.headers(headers, end_stream: false)
          if request.body.respond_to?(:read)
            # the read method will only return data when there is initial
            # data in the request.
            # if the body is eof, then close the stream.
            # Event encoder should ensure that eof is false after initial event.
            payload = request.body.read
            stream.data(payload, end_stream: !request.keep_open)
          end

          response
        end
      end

      private

      def setup_stream_handlers(response, stream)
        stream.on(:headers) do |headers|
          headers.each { |k, v| response.headers[k] = v }
          if response.body.respond_to?(:headers=)
            # allow async events based on headers
            response.body.headers = response.headers
          end
        end

        stream.on(:data) do |data|
          response.body.write(data)
        end

        stream.on(:close) do
          response.sync_queue << 'stream-closed'
        end
      end

      # H2 pseudo headers
      # https://http2.github.io/http2-spec/#rfc.section.8.1.2.3
      def h2_headers(request)
        endpoint = request.uri
        headers = {}
        headers[':method'] = request.http_method.upcase
        headers[':authority'] = endpoint.host
        headers[':scheme'] = endpoint.scheme
        headers[':path'] = endpoint_path(endpoint)
        request.headers.each { |k, v| headers[k.downcase] = v }
        headers
      end

      def endpoint_path(endpoint)
        path = endpoint.path.empty? ? '/' : endpoint.path
        path += "?#{endpoint.query}" if endpoint.query && !endpoint.query.empty?
        path
      end

      def with_connection_pool(endpoint, logger)
        # get an Http2 connection from the connection pool
        # Or create one.  The connection has a thread that will read data to
        # any streams created on it.
        pool = ConnectionPool.for(pool_config)
        connection = pool.connection_for(endpoint) do
          new_connection(endpoint, logger)
        end
        stream = connection.new_stream
        if stream.nil?
          # no capacity for new streams, open a new connection
          pool.offer(endpoint, connection)
          connection = new_connection(endpoint, logger)
          stream = connection.new_stream
        end
        yield stream
        pool.offer(endpoint, connection)
      rescue StandardError => e
        connection&.finish
        raise e
      end

      # Starts and returns a new HTTP2 connection.
      # @return [Hearth::HTTP2::Connection]
      def new_connection(endpoint, logger)
        options = OPTIONS.each_key.with_object({}) do |option_name, hash|
          hash[option_name] = instance_variable_get("@#{option_name}")
        end
        options[:logger] ||= logger
        Hearth::HTTP2::Connection.new(
          endpoint: endpoint,
          **options
        )
      end

      # Config options for the HTTP client used for connection pooling
      # @return [Hash]
      def pool_config
        options = OPTIONS.each_key.with_object({}) do |option_name, hash|
          hash[option_name] = instance_variable_get("@#{option_name}")
        end
        options['http_version'] = 'http2'
        options
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
