require 'http/2'

module Hearth
  module HTTP2
    # An HTTP2 Connection. 1:1 with an open TCP Socket and an http-2 client
    class Connection

      # TODO: Refine these options
      OPTIONS = {
        max_concurrent_streams: 100,
        connection_timeout: 60,
        connection_read_timeout: 60,
        debug_output: false,
        logger: nil,
        ssl_verify_peer: true,
        ssl_ca_bundle: nil,
        ssl_ca_directory: nil,
        ssl_ca_store: nil,
        enable_alpn: false
      }

      # chunk read size at socket
      CHUNKSIZE = 1024

      SOCKET_FAMILY = ::Socket::AF_INET

      # 1:1 with an h2 client
      # 1:1 with a TCP connection
      # Has a thread that is responsible for reading data to the client
      def initialize(options = {})
        OPTIONS.each_pair do |opt_name, default_value|
          value = options[opt_name].nil? ? default_value : options[opt_name]
          instance_variable_set("@#{opt_name}", value)
        end

        # TODO: Validate that endpoint is set?

        @h2_client = ::HTTP2::Client.new
        @socket = create_tcp_connection(options)
        register_h2_callbacks
        @state = :CONNECTED
        @healthy = true
        @mutex = Mutex.new
        @streams = {} # map of stream.id -> stream
        # TODO: Ensure that this thread is cleaned up correctly when the connection closes!
        @thread = Thread.new do
          while !@socket.closed? && !@socket.eof?
            begin
              data = @socket.read_nonblock(CHUNKSIZE)
              @h2_client << data # this data will have information about its stream
            rescue Exception => e
              # TODO: some error handling.  Set connected/healthy
              # TODO: propagate errors, thread raise on errors?
              puts "Connection thread error: #{e}"
              puts e.inspect
              puts e.backtrace
            end
          end
          @mutex.synchronize do
            @state = :CLOSED
            @healthy = false
          end
        end
      end

      OPTIONS.keys.each do |attr_name|
        attr_reader(attr_name)
      end

      alias ssl_verify_peer? ssl_verify_peer

      def stale?
        !@healthy || @state != :CONNECTED
      end

      # return a new stream, or nil when max streams is exceeded
      def new_stream
        if @streams.size < @max_concurrent_streams
          begin
            stream = @h2_client.new_stream
            @streams[stream.id] = stream
            stream
          rescue ::HTTP2::Error::StreamLimitExceeded
            nil # exceeded our max streams from remote (server) settings
          end
        else
          nil
        end
      end

      def close_stream(stream)
        puts "---------------CLOSE STREAM: #{stream.id}"
        @streams.delete(stream.id)
        stream.close
      end

      # all underlying streams will be closed
      def close
        puts "---------------CLOSE ALL STREAMS"
        @streams.values.each { |s| s.close }
        @streams = {}
        @thread.kill
      end
      alias_method :finish, :close

      private
      def create_tcp_connection(options)
        endpoint = options[:endpoint]
        tcp, addr = tcp_socket(endpoint)
        log_debug("opening connection to #{endpoint.host}:#{endpoint.port} ...")
        nonblocking_connect(tcp, addr)
        if endpoint.scheme == 'https'
          @socket = OpenSSL::SSL::SSLSocket.new(tcp, tls_context)
          @socket.sync_close = true
          @socket.hostname = endpoint.host

          log_debug("starting TLS for #{endpoint.host}:#{endpoint.port} ...")
          @socket.connect
          log_debug('TLS established')
        else
          @socket = tcp
        end

        @socket
      end

      def tcp_socket(endpoint)
        tcp = ::Socket.new(SOCKET_FAMILY, ::Socket::SOCK_STREAM, 0)
        tcp.setsockopt(::Socket::IPPROTO_TCP, ::Socket::TCP_NODELAY, 1)

        address = ::Socket.getaddrinfo(endpoint.host, nil, SOCKET_FAMILY).first[3]
        sockaddr = ::Socket.sockaddr_in(endpoint.port, address)

        [tcp, sockaddr]
      end

      def nonblocking_connect(tcp, addr)
        begin
          tcp.connect_nonblock(addr)
        rescue IO::WaitWritable
          unless IO.select(nil, [tcp], nil, connection_timeout)
            tcp.close
            raise
          end
          begin
            tcp.connect_nonblock(addr)
          rescue Errno::EISCONN
            # tcp socket connected, continue
          end
        end
      end

      def tls_context
        ssl_ctx = OpenSSL::SSL::SSLContext.new(:TLSv1_2)
        if ssl_verify_peer?
          ssl_ctx.verify_mode = OpenSSL::SSL::VERIFY_PEER
          ssl_ctx.ca_file = ssl_ca_bundle ? ssl_ca_bundle : default_ca_bundle
          ssl_ctx.ca_path = ssl_ca_directory ? ssl_ca_directory : default_ca_directory
          ssl_ctx.cert_store = ssl_ca_store if ssl_ca_store
        else
          ssl_ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        if enable_alpn
          log_debug('enabling ALPN for TLS ...')
          ssl_ctx.alpn_protocols = ['h2']
        end
        ssl_ctx
      end

      def default_ca_bundle
        File.exist?(OpenSSL::X509::DEFAULT_CERT_FILE) ?
          OpenSSL::X509::DEFAULT_CERT_FILE : nil
      end

      def default_ca_directory
        Dir.exist?(OpenSSL::X509::DEFAULT_CERT_DIR) ?
          OpenSSL::X509::DEFAULT_CERT_DIR : nil
      end

      def register_h2_callbacks
        @h2_client.on(:frame) do |bytes|
          if @socket.nil?
            msg = 'Connection is closed due to errors, '\
              'you can find errors at async_client.connection.errors'
            raise Hearth::Http2::ConnectionClosedError.new(msg)
          else
            @socket.print(bytes)
            @socket.flush
          end
        end
        if @debug_output
          @h2_client.on(:frame_sent) do |frame|
            log_debug("frame: #{frame.inspect}", :send)
          end
          @h2_client.on(:frame_received) do |frame|
            log_debug("frame: #{frame.inspect}", :receive)
          end
        end
      end

      def log_debug(msg, type = nil)
        prefix = case type
                 when :send then '-> '
                 when :receive then '<- '
                 else
                   ''
                 end
        return unless @logger && @debug_output
        @logger.debug(prefix + msg)
      end

    end
  end
end
