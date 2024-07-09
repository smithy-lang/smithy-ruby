require_relative 'connection'

module Hearth
  module HTTP2
    # An HTTP2 client that uses the http-2 gem and TCP connections
    # to send requests.
    class Client

      # @api private
      OPTIONS = {
        logger: nil,
        log_debug: nil,
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

      # TODO: Include http2 configuration options
      def initialize(options = {})
        super()
      end

      def transmit(request:, response:, logger: nil)
        with_connection_pool(request.uri, logger) do |stream|
          # setup handlers on the stream to write data to the response
          stream.on(:headers) do |headers|
            response.headers = headers
          end
          stream.on(:data) do |data|
            puts "Stream received data (writting it to the body)"
            response.body.write(data)
          end

          # send initial request
          # TODO: Do we always want to leave the stream open, or are there cases where it should close after the initial request?
          stream.headers(request.headers, end_stream: false)
          if request.body.respond_to?(:read)
            # the read method will only return data when there is initial data in the request
            stream.data(request.body.read, end_stream: false)
          end

          # the request body is a stream encoder, give it the stream so that it can send events
          if request.body.respond_to?(:stream=)
            request.body.stream = stream
          end

          response
        end
      end

      private

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
        # TODO, what options? How do we pass these through correctly
        Hearth::HTTP2::Connection.new(
          endpoint: endpoint,
          logger: Logger.new(STDOUT),
          debug_output: true)
      end

      # Config options for the HTTP client used for connection pooling
      # @return [Hash]
      def pool_config
        hash = OPTIONS.each_key.with_object({}) do |option_name, hash|
          hash[option_name] = instance_variable_get("@#{option_name}")
        end
        hash['http_version'] = 'http2'
        hash
      end
    end
  end
end
