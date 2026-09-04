# frozen_string_literal: true

require 'openssl'

require_relative 'connection_pool'
require_relative 'exchange'
require_relative 'stream'

module Smithy
  module Client
    module NetHTTP
      # The default HTTP/1.1 transport for {Smithy::Client}, built on Ruby's
      # +Net::HTTP+ and the default value of the +:transport+ option (see
      # {Plugins::Transport}).
      #
      # Connection management is handled by the class-level, options-keyed
      # {ConnectionPool} (a global pool shared across clients with identical
      # configuration). Connections are opened on demand and returned to the pool
      # after a complete read.
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
      class Transport
        # @option options [Numeric] :connect_timeout Seconds to wait for a
        #   connection to open. Net::HTTP default: 60.
        # @option options [Numeric] :read_timeout Seconds to wait for data.
        #   Net::HTTP default: 60.
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
        #   timeout (transport-specific). Net::HTTP default: nil (no wait).
        # @option options [Numeric] :keep_alive_timeout Net::HTTP keep-alive /
        #   idle-eviction timeout (transport-specific). Net::HTTP default: 2.
        # @option options [Numeric] :write_timeout Net::HTTP write timeout
        #   (transport-specific). Net::HTTP default: 60.
        # @option options [Numeric] :ssl_timeout Net::HTTP TLS handshake timeout
        #   (transport-specific). Net::HTTP default: nil.
        # @option options [OpenSSL::X509::Certificate] :cert Client certificate
        #   for mutual TLS (transport-specific).
        # @option options [OpenSSL::PKey] :key Client private key for mutual TLS
        #   (transport-specific).
        def initialize(options = {})
          @options = options
          @pool = ConnectionPool.for(pool_options)
        end

        # The bridge queue for event streaming, matching this transport's
        # concurrency model. Net::HTTP drives on a background thread, so a
        # thread-blocking +SizedQueue+ is correct: the driving thread pushes and
        # the consumer thread pops. Supplied to the event stream layer's bridge
        # so the transport stays fully push and the bridge is concurrency-
        # appropriate (see {Transport}).
        # @return [SizedQueue]
        def event_queue
          SizedQueue.new(64)
        end

        # Drives an {Exchange} inline (see {Transport#transmit} for the
        # contract): sends and pushes the response into +sink+ to its terminal on
        # the caller's thread, then returns nothing. Net::HTTP is synchronous, so
        # "inline" is a plain blocking call here.
        # @param [Http::Request] request
        # @param [#headers, #data, #done, #error] sink The inbound response sink
        #   (see {ResponseSink}).
        # @return [void]
        # @raise [ArgumentError] If the request has an invalid HTTP method
        #   (validated at {Exchange} construction, before any network I/O).
        def transmit(request, sink)
          Exchange.new(@pool, request, sink).drive
          nil
        end

        # Drives an {Exchange} on a background thread (Net::HTTP is blocking, so
        # the concurrency mechanism is an OS thread) and returns its {Stream}
        # handle immediately (see {Transport#transmit_background} for the
        # contract).
        # @param [Http::Request] request
        # @param [#headers, #data, #done, #error] sink The inbound response sink
        #   (see {ResponseSink}).
        # @return [Stream]
        # @raise [ArgumentError] If the request has an invalid HTTP method
        #   (validated at {Exchange} construction, before spawning).
        def transmit_background(request, sink)
          exchange = Exchange.new(@pool, request, sink)
          exchange.drive_background
          Stream.new(exchange)
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
