# frozen_string_literal: true

require 'openssl'

require_relative 'connection_pool'
require_relative 'stream'

module Smithy
  module Client
    module NetHTTP
      # The default HTTP/1.1 transport for {Smithy::Client}, built on Ruby's
      # +Net::HTTP+. Exposes a single {#transmit} method that sends a request and
      # returns a {Stream}. This is the default value
      # of the +:transport+ option (see {Plugins::Transport}) and the swap point
      # for supplying a custom transport.
      #
      # The transport owns its connection management through the class-level,
      # options-keyed {ConnectionPool} (a global HTTP/1.1 pool shared across
      # clients with identical configuration). Connections are opened on demand
      # and returned to the pool after a complete read.
      #
      # ## Configuration, option mapping, and V3 equivalence
      #
      # The transport-agnostic options (connect/read timeouts, proxy, TLS
      # verification and trust store, wire trace) are forwarded from client
      # config by {Plugins::Transport}. The Net::HTTP-specific options are not
      # exposed as client options; a customer who needs them constructs this
      # transport directly and passes it via the +:transport+ option, for
      # example:
      #
      #     Aws::S3::Client.new(
      #       transport: Smithy::Client::NetHTTP::Transport.new(
      #         keep_alive_timeout: 30, read_timeout: 10
      #       )
      #     )
      #
      # ### Transport-agnostic options (client config, forwarded here)
      #
      #     V4 option          Net::HTTP setting    V3 option(s)
      #     -----------------  -------------------  --------------------------------------
      #     connect_timeout    open_timeout         http_open_timeout / connection_timeout
      #     read_timeout       read_timeout         http_read_timeout / connection_read_timeout
      #     ssl_verify_peer    verify_mode          ssl_verify_peer
      #     ssl_ca_bundle      ca_file              ssl_ca_bundle
      #     ssl_ca_directory   ca_path              ssl_ca_directory
      #     ssl_ca_store       cert_store           ssl_ca_store
      #     http_proxy         proxy                http_proxy
      #     http_wire_trace    set_debug_output     http_wire_trace
      #     logger             (wire-trace target)  logger
      #
      # ### Net::HTTP-specific options (NOT client config; set via this transport)
      #
      # In V3 these were client options. In V4 they are configured only by
      # constructing this transport and passing it as +:transport+.
      #
      #     V4 option           Net::HTTP setting   V3 option
      #     ------------------  ------------------  ---------------------
      #     continue_timeout    continue_timeout    http_continue_timeout
      #     keep_alive_timeout  keep_alive_timeout  http_idle_timeout (*)
      #     write_timeout       write_timeout       (new in V4)
      #     ssl_timeout         ssl_timeout         ssl_timeout
      #     cert                cert                ssl_cert
      #     key                 key                 ssl_key
      #
      #     (*) V3's http_idle_timeout controlled pool idle eviction; in V4 the
      #         pool evicts based on keep_alive_timeout, so this option covers
      #         both keep-alive and idle eviction.
      #
      # HTTP/2-specific V3 options (max_concurrent_streams, read_chunk_size,
      # enable_alpn) belong to the H2 transport, not this one.
      # @api private
      class Transport
        # @option options [Numeric] :connect_timeout Seconds to wait for a
        #   connection to open.
        # @option options [Numeric] :read_timeout Seconds to wait for data.
        # @option options [Boolean] :ssl_verify_peer (true) Whether to verify
        #   the peer's TLS certificate.
        # @option options [String] :ssl_ca_bundle Path to a CA bundle file.
        # @option options [String] :ssl_ca_directory Path to a CA directory.
        # @option options [OpenSSL::X509::Store] :ssl_ca_store TLS trust store.
        # @option options [URI::HTTP, String] :http_proxy Proxy to send through.
        # @option options [Boolean] :http_wire_trace (false) Emit wire trace to
        #   the logger.
        # @option options [Logger] :logger Logger for wire trace.
        # @option options [Numeric] :continue_timeout Net::HTTP 100-continue
        #   timeout (transport-specific; V3 `http_continue_timeout`).
        # @option options [Numeric] :keep_alive_timeout Net::HTTP keep-alive /
        #   idle-eviction timeout (transport-specific; V3 `http_idle_timeout`).
        # @option options [Numeric] :write_timeout Net::HTTP write timeout
        #   (transport-specific; new in V4).
        # @option options [Numeric] :ssl_timeout Net::HTTP TLS handshake timeout
        #   (transport-specific; V3 `ssl_timeout`).
        # @option options [OpenSSL::X509::Certificate] :cert Client certificate
        #   for mutual TLS (transport-specific; V3 `ssl_cert`).
        # @option options [OpenSSL::PKey] :key Client private key for mutual TLS
        #   (transport-specific; V3 `ssl_key`).
        def initialize(options = {})
          @options = options
          @pool = ConnectionPool.for(pool_options)
        end

        # Sends the request (headers + body) synchronously and returns a
        # {Stream} whose response status and headers are already available.
        # Response body chunks are read on the caller's thread via
        # {Stream#each_chunk}.
        # @param [Http::Request] request
        # @return [Stream]
        # @raise [ArgumentError] If the request has an invalid HTTP method.
        # @raise [NetworkingError] If a networking error occurs while sending
        #   the request or reading the response headers.
        def transmit(request)
          stream = Stream.new(@pool, request)
          stream.send_request
          stream
        end

        private

        # Maps the transport options onto the Net::HTTP {ConnectionPool} options.
        # Transport-agnostic options use transport-neutral names and are
        # translated here; Net::HTTP-specific options are passed through.
        # @return [Hash]
        def pool_options
          o = @options
          {
            # Transport-agnostic options (transport-neutral names).
            http_open_timeout: o[:connect_timeout],
            http_read_timeout: o[:read_timeout],
            http_verify_mode: verify_mode(o.fetch(:ssl_verify_peer, true)),
            http_ca_file: o[:ssl_ca_bundle],
            http_ca_path: o[:ssl_ca_directory],
            http_cert_store: o[:ssl_ca_store],
            http_proxy: o[:http_proxy],
            http_debug_output: o.fetch(:http_wire_trace, false),
            logger: o[:logger],
            # Net::HTTP-specific options (set only via direct construction).
            http_continue_timeout: o[:continue_timeout],
            http_keep_alive_timeout: o[:keep_alive_timeout],
            http_write_timeout: o[:write_timeout],
            http_ssl_timeout: o[:ssl_timeout],
            http_cert: o[:cert],
            http_key: o[:key]
          }
        end

        # @param [Boolean] verify_peer
        # @return [Integer] The OpenSSL verify mode.
        def verify_mode(verify_peer)
          verify_peer ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
        end
      end
    end
  end
end
