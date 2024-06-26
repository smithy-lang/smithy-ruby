require 'http/2'

module Hearth
  module HTTP2
    # An HTTP2 Connection. 1:1 with an open TCP Socket and an http-2 client
    class Connection

      # 1:1 with an h2 client
      # 1:1 with a TCP connection
      # Has a thread that is responsible for reading data to the client

      def initialize(options = {})
        @h2_client = ::HTTP2::Client.new
        @socket = create_tcp_connection(options)
        @state = :CONNECTED
        @healthy = true
        @mutex = Mutex.new
        @max_streams = options[:max_streams] || 10
        @streams = {} # map of stream.id -> stream
        @thread = Thread.new do
          while !@socket.closed? && !@socket.eof?
            begin
              data = @socket.read_nonblock(1024)
              @h2_client << data # this data will have information about its stream
            rescue Exception
              # some error handling.  Set connected/healthy
            end
          end
          @state = :CLOSED
        end

        # setup mechanism to send data from streams to the socket
        @h2_client.on(:frame) do |bytes|
          @socket.print bytes
          @socket.flush
        end
      end

      def stale?
        !@healthy || @state != :CONNECTED
      end

      # return a new stream, or nil when max streams is exceeded
      def start_stream
        if @streams.size < @max_streams
          stream = @h2_client.start_stream
          @streams[stream.id] = stream
          stream
        else
          nil
        end
      end

      def close_stream(stream)
        @streams.delete(stream.id)
        stream.close
      end

      # all underlying streams will be closed
      def close
        @streams.each { |s| s.close }
        @thread.kill
      end
      alias_method :finish, :close

      private
      def create_tcp_connection(options)
        # TODO
      end

    end
  end
end