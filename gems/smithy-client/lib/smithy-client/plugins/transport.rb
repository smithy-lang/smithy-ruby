# frozen_string_literal: true

require_relative '../send_handler'
require_relative '../transport'
require_relative '../net_http/transport'

module Smithy
  module Client
    module Plugins
      # Generic transport plugin for Smithy clients. It:
      #
      # * registers the shared +:send+ handler ({SendHandler}),
      # * defines the common client transport options, and
      # * constructs the default transport when one is not supplied explicitly.
      #
      # These client options cover the shared transport settings exposed on
      # +Client.new(...)+. Transport-specific options remain adapter-specific and
      # must be configured on the transport instance itself (see
      # {Smithy::Client::NetHTTP::Transport}). If a caller supplies a transport
      # via +:transport+, that instance is used as-is.
      # @api private
      class Transport < Plugin
        # The common client transport options forwarded to the default
        # transport. This list is the reference for which client options are
        # forwarded: add a name here and define the matching +option(...)+ below
        # and it is forwarded automatically. Note that {NetHTTP::Transport}
        # translates these onto {NetHTTP::ConnectionPool::OPTIONS}, so the three
        # surfaces are coupled and can drift; treat this const as the source of
        # truth for the forwarded set.
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
            Defaults to `nil`, which uses the transport's default; the default
            Net::HTTP transport uses 60 seconds.
          DOCS

        option(
          :read_timeout,
          default: nil,
          doc_type: Numeric,
          docstring: <<~DOCS)
            The number of seconds to wait for data to be read before timing out.
            Defaults to `nil`, which uses the transport's default; the default
            Net::HTTP transport uses 60 seconds.
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
            common client transport options. Supply a custom object responding to
            `#transmit(request)` (returning a stream) to swap the transport, or a
            directly-constructed `NetHTTP::Transport` to set Net::HTTP-specific knobs. A
            caller-supplied transport instance is used as-is.
          DOCS
          Client::NetHTTP::Transport.new(
            **TRANSPORT_OPTIONS.to_h { |name| [name, config.send(name)] }
          )
        end

        handler(Client::SendHandler, step: :send)

        # Validates a customer-supplied +:transport+ before the config is built,
        # so the default transport is not eagerly constructed just to check it.
        # Validates against {Client::Transport::REQUIRED_METHODS} by duck typing,
        # so any conforming object is accepted without requiring a particular
        # base class or module. The stream a transport returns has its own
        # (send-time) contract that cannot be checked here.
        # @param [Class<Client::Base>] _client_class
        # @param [Hash] options
        # @raise [ArgumentError] If a supplied transport does not answer the
        #   transport contract.
        def before_initialize(_client_class, options)
          transport = options[:transport]
          return if transport.nil?
          return if Client::Transport::REQUIRED_METHODS.all? { |m| transport.respond_to?(m) }

          raise ArgumentError,
                "#{transport.class} does not implement the transport contract " \
                "(#{Client::Transport::REQUIRED_METHODS.join(', ')})"
        end
      end
    end
  end
end
