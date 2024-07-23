# frozen_string_literal: true

require 'http/2'

module Hearth
  module HTTP2
    # An HTTP2 Connection. 1:1 with an open TCP Socket and an http-2 client
    # # @api private
    # rubocop:disable Metrics/ClassLength
    class Connection
      OPTIONS = {
        logger: nil,
        debug_output: false,
        open_timeout: 15, # in seconds
        read_timeout: 60,
        max_concurrent_streams: 100,
        verify_peer: true,
        ca_file: nil,
        ca_path: nil,
        cert_store: nil,
        enable_alpn: true,
        host_resolver: nil
      }.freeze

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

        @h2_client = ::HTTP2::Client.new
        @mutex = Mutex.new

        @socket = create_tcp_connection(options)
        register_h2_callbacks
        @state = :connected
        @healthy = true

        @streams = {} # map of stream.id -> stream
        @errors = []
        start_connection_thread
      end

      OPTIONS.each_key do |attr_name|
        attr_reader(attr_name)
      end

      alias verify_peer? verify_peer

      def stale?
        !@healthy || @state != :connected
      end

      # return a new stream, or nil when max streams is exceeded
      def new_stream
        return unless @streams.size < @max_concurrent_streams

        begin
          stream = @h2_client.new_stream
          @streams[stream.id] = stream
          stream
        rescue ::HTTP2::Error::StreamLimitExceeded
          nil # exceeded our max streams from remote (server) settings
        end
      end

      def close_stream(stream)
        @mutex.synchronize do
          @streams.delete(stream.id)
          stream.close
        end
      end

      # all underlying streams will be closed
      def close
        @mutex.synchronize do
          log_debug('closing connection')
          @status = :closed
          @healthy = false

          @streams.each_value(&:close)
          @streams = {}
          @thread.kill

          @socket&.close
        end
      end
      alias finish close

      private

      # rubocop:disable Metrics
      def start_connection_thread
        @mutex.synchronize do
          @thread = Thread.new do
            while !@socket.closed? && !@socket.eof?
              begin
                data = @socket.read_nonblock(CHUNKSIZE)
                @h2_client << data
              rescue IO::WaitReadable
                begin
                  if @socket.wait_readable(read_timeout)
                    # available, retry to start reading
                    retry
                  else
                    log_debug('socket connection read time out')
                    close
                  end
                rescue StandardError
                  # error can happen when closing the socket
                  # while it's waiting for read
                  close
                end
              rescue StandardError => e
                @errors << e
                close
                raise e
              end
            end
            close
          end
          @thread.abort_on_exception = true
        end
      end
      # rubocop:enable Metrics

      def create_tcp_connection(options)
        endpoint = options[:endpoint]
        tcp, addr = tcp_socket(endpoint)
        log_debug("opening connection to #{endpoint.host}:#{endpoint.port} ...")
        nonblocking_connect(tcp, addr)
        return open_ssl_socket(tcp, endpoint) if endpoint.scheme == 'https'

        tcp
      end

      def open_ssl_socket(tcp, endpoint)
        socket = OpenSSL::SSL::SSLSocket.new(tcp, tls_context)
        socket.sync_close = true
        socket.hostname = endpoint.host

        log_debug("starting TLS for #{endpoint.host}:#{endpoint.port} ...")
        socket.connect
        log_debug('TLS established')
        socket
      end

      def tcp_socket(endpoint)
        tcp = ::Socket.new(SOCKET_FAMILY, ::Socket::SOCK_STREAM, 0)
        tcp.setsockopt(::Socket::IPPROTO_TCP, ::Socket::TCP_NODELAY, 1)

        address = get_address(endpoint.host)
        sockaddr = ::Socket.sockaddr_in(endpoint.port, address)

        [tcp, sockaddr]
      end

      def get_address(host)
        if @host_resolver
          ipv6, ipv4 = @host_resolver.resolve_address(nodename: host)
          return ipv6.address if ipv6

          return ipv4.address
        end
        ::Socket.getaddrinfo(host, nil, SOCKET_FAMILY).first[3]
      end

      def nonblocking_connect(tcp, addr)
        tcp.connect_nonblock(addr)
      rescue IO::WaitWritable
        unless tcp.wait_writable(open_timeout)
          tcp.close
          raise
        end
        begin
          tcp.connect_nonblock(addr)
        rescue Errno::EISCONN
          # tcp socket connected, continue
        end
      end

      def tls_context
        # rubocop:disable Naming/VariableNumber
        ssl_ctx = OpenSSL::SSL::SSLContext.new(:TLSv1_2)
        # rubocop:enable Naming/VariableNumber

        if verify_peer?
          ssl_ctx.verify_mode = OpenSSL::SSL::VERIFY_PEER
          configure_ssl_certs(ssl_ctx)
        else
          ssl_ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        ssl_ctx.alpn_protocols = ['h2'] if enable_alpn
        ssl_ctx
      end

      def configure_ssl_certs(ssl_ctx)
        ssl_ctx.ca_file = ca_file || default_ca_bundle
        ssl_ctx.ca_path = ca_path || default_ca_directory
        ssl_ctx.cert_store = cert_store if cert_store
      end

      def default_ca_bundle
        return unless File.exist?(OpenSSL::X509::DEFAULT_CERT_FILE)

        OpenSSL::X509::DEFAULT_CERT_FILE
      end

      def default_ca_directory
        return unless Dir.exist?(OpenSSL::X509::DEFAULT_CERT_DIR)

        OpenSSL::X509::DEFAULT_CERT_DIR
      end

      def register_h2_callbacks
        @h2_client.on(:frame) do |bytes|
          if @socket.nil?
            msg = 'Connection is closed due to errors, ' \
                  'you can find errors at async_client.connection.errors'
            raise Hearth::Http2::ConnectionClosedError, msg
          else
            @socket.print(bytes)
            @socket.flush
          end
        end
        return unless @debug_output

        @h2_client.on(:frame_sent) do |frame|
          log_debug("frame: #{frame.inspect}", :send)
        end
        @h2_client.on(:frame_received) do |frame|
          log_debug("frame: #{frame.inspect}", :receive)
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
    # rubocop:enable Metrics/ClassLength
  end
end
