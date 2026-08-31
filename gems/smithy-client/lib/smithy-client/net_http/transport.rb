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
      # ## Configuration and option mapping
      #
      # The Net::HTTP-specific options are not exposed as client options. To use
      # them, construct this transport directly and pass it via the +:transport+
      # option, for example:
      #
      #     Weather::Client.new(
      #       transport: Smithy::Client::NetHTTP::Transport.new(
      #         keep_alive_timeout: 30
      #       )
      #     )
      #
      # ### Common client options forwarded to this transport
      #
      # These client options are forwarded to the default Net::HTTP transport
      # (by {Plugins::Transport}) and mapped onto Net::HTTP settings:
      #
      #     Client Option      Net::HTTP setting
      #     -----------------  -------------------
      #     connect_timeout    open_timeout
      #     read_timeout       read_timeout
      #     ssl_verify_peer    verify_mode
      #     ssl_ca_bundle      ca_file
      #     ssl_ca_directory   ca_path
      #     ssl_ca_store       cert_store
      #     http_proxy         proxy
      #     http_wire_trace    set_debug_output
      #     logger             (wire-trace target)
      #
      # ### Net::HTTP-only transport options
      #
      # These are not exposed as client options; configure them by constructing
      # this transport directly and passing it via +:transport+. They map 1:1
      # onto the corresponding Net::HTTP settings: +continue_timeout+,
      # +keep_alive_timeout+, +write_timeout+, +ssl_timeout+, +cert+, +key+.
      # (The pool evicts idle connections by +keep_alive_timeout+, so that option
      # covers both keep-alive and idle eviction.)
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
        #   timeout (transport-specific).
        # @option options [Numeric] :keep_alive_timeout Net::HTTP keep-alive /
        #   idle-eviction timeout (transport-specific).
        # @option options [Numeric] :write_timeout Net::HTTP write timeout
        #   (transport-specific).
        # @option options [Numeric] :ssl_timeout Net::HTTP TLS handshake timeout
        #   (transport-specific).
        # @option options [OpenSSL::X509::Certificate] :cert Client certificate
        #   for mutual TLS (transport-specific).
        # @option options [OpenSSL::PKey] :key Client private key for mutual TLS
        #   (transport-specific).
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
        # translated here; Net::HTTP-specific options are passed through. The
        # keys produced here are the +http_*+ names declared in
        # {ConnectionPool::OPTIONS} (the single source of truth for pool
        # settings); keep the two in sync.
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
