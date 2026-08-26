# frozen_string_literal: true

require_relative '../send_handler'
require_relative '../net_http/transport'

module Smithy
  module Client
    module Plugins
      # The generic transport plugin. It:
      #
      # * registers the transport-agnostic +:send+ handler ({SendHandler}),
      # * resolves the +:transport+ used to send requests (the documented swap
      #   point), and
      # * defines the transport-agnostic client options (connect/read timeouts,
      #   proxy, TLS verification and trust store, wire trace) that every
      #   built-in transport honors.
      #
      # These options use transport-neutral names and are forwarded to the
      # default transport at construction. Transport-specific knobs (for example
      # Net::HTTP's keep-alive/continue timeouts or client certificates) are not
      # exposed as client options: a customer who needs them constructs a
      # transport instance directly and passes it as +:transport+ (see
      # {Smithy::Client::NetHTTP::Transport}). A customer-supplied transport is
      # used as-is, so these options do not apply to it.
      # @api private
      class Transport < Plugin
        # The transport-agnostic client options forwarded to the default
        # transport. Keeping them in one list keeps the option definitions and
        # the forwarding in sync: add a name here and define the matching
        # +option(...)+ below and it is forwarded automatically.
        TRANSPORT_OPTIONS = %i[
          connect_timeout read_timeout ssl_verify_peer ssl_ca_bundle
          ssl_ca_directory ssl_ca_store http_proxy http_wire_trace logger
        ].freeze

        ## Connections

        option(
          :connect_timeout,
          default: nil,
          doc_type: Numeric,
          docstring: <<~DOCS)
            The number of seconds to wait when opening a connection before timing out.
            Defaults to `nil`, which uses the transport's default.
          DOCS

        option(
          :read_timeout,
          default: nil,
          doc_type: Numeric,
          docstring: <<~DOCS)
            The number of seconds to wait for data to be read before timing out.
            Defaults to `nil`, which uses the transport's default.
          DOCS

        ## Security

        option(
          :ssl_verify_peer,
          default: true,
          doc_type: 'Boolean',
          docstring: <<~DOCS)
            When `true` (default), the peer's TLS certificate is verified. Disable only
            for debugging, as it is insecure.
          DOCS

        option(
          :ssl_ca_bundle,
          default: nil,
          doc_type: String,
          docstring: <<~DOCS)
            The path to a CA certificate bundle file in PEM format used to verify peer
            certificates. Defaults to `nil`, which uses the transport's default trust store.
          DOCS

        option(
          :ssl_ca_directory,
          default: nil,
          doc_type: String,
          docstring: <<~DOCS)
            The path to a directory of CA certificates in PEM format used to verify peer
            certificates. Defaults to `nil`, which uses the transport's default trust store.
          DOCS

        option(
          :ssl_ca_store,
          default: nil,
          doc_type: 'OpenSSL::X509::Store',
          docstring: <<~DOCS)
            An in-memory TLS trust store used to verify peer certificates. Defaults to `nil`,
            which uses the transport's default trust store.
          DOCS

        ## Debugging

        option(
          :http_wire_trace,
          default: false,
          doc_type: 'Boolean',
          docstring: <<~DOCS)
            When `true`, HTTP wire trace output is sent to the configured logger.
          DOCS

        ## Proxies

        option(
          :http_proxy,
          default: nil,
          doc_type: 'URI::HTTP, String',
          docstring: <<~DOCS)
            A proxy to send requests through. Formatted like 'http://proxy.com:123'.
          DOCS

        ## Transport

        option(
          :transport,
          doc_type: 'Smithy::Client::NetHTTP::Transport',
          docstring: <<~DOCS) do |config|
            The transport used to send requests. Defaults to an HTTP/1.1 transport based on
            Net::HTTP ({Smithy::Client::NetHTTP::Transport}), constructed with the resolved
            transport-agnostic client options. Supply a custom object responding to
            `#transmit(request)` (returning a stream) to swap the transport, or a
            directly-constructed `NetHTTP::Transport` to set Net::HTTP-specific knobs. A
            customer-supplied transport instance is used as-is.
          DOCS
          Client::NetHTTP::Transport.new(
            **TRANSPORT_OPTIONS.to_h { |name| [name, config.send(name)] }
          )
        end

        handler(Client::SendHandler, step: :send)

        # Validates a customer-supplied +:transport+ before the config is built,
        # so the default transport is not eagerly constructed just to check it.
        # Only +#transmit+ is required, since that is the sole method the send
        # handler invokes; the stream it returns has its own (send-time)
        # contract that cannot be checked here.
        # @param [Class<Client::Base>] _client_class
        # @param [Hash] options
        # @raise [ArgumentError] If a supplied transport does not respond to
        #   +#transmit+.
        def before_initialize(_client_class, options)
          transport = options[:transport]
          return if transport.nil? || transport.respond_to?(:transmit)

          raise ArgumentError,
                ':transport must respond to #transmit(request), got ' \
                "#{transport.class}"
        end
      end
    end
  end
end
