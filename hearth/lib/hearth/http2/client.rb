require 'http-2'

module Hearth
  module HTTP2
    # An HTTP2 client that uses the http-2 gem and TCP connections
    # to send requests.
    class Client

      # Includes http2 configuration options
      def initialize(options = {})
        super()
      end

      def transmit(request:, response:, logger: nil)
        # get an Http2 connection from the connection pool
        # Or create one.  The connection has a thread that will read data to
        # any streams created on it.
        connection = connection_for(request)
        stream = connection.start_stream

        # setup handlers on the stream to write data to the response
        stream.on(:headers) do |headers|
          response.headers = headers
        end
        stream.on(:data) do |data|
          response.body.write(data)
        end

        # send initial request
        stream.headers(request.headers)
        if request.body.respond_to?(:read)
          # the read method will only return data when there initial data in the request
          stream.data(request.body.read)
        end

        # the request body is a stream encoder. Give it the stream so that it can send events
        request.body.stream = stream

        response
      end
    end
  end
end
