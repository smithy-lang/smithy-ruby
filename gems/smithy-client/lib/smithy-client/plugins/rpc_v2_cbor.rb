# frozen_string_literal: true

require_relative '../rpc_v2_cbor/build_handler'
require_relative '../rpc_v2_cbor/parse_handler'
require_relative '../rpc_v2_cbor/stubber'

module Smithy
  module Client
    module Plugins
      # @api private
      class RPCv2CBOR < Plugin
        option(
          :protocol,
          default: 'smithy-rpc-v2-cbor',
          doc_default: '"smithy-rpc-v2-cbor"',
          doc_type: String,
          docstring: 'The protocol to use for request serialization and response deserialization.'
        )

        def add_handlers(handlers, config)
          return unless config.protocol == 'smithy-rpc-v2-cbor'

          handlers.add(Client::RPCv2CBOR::BuildHandler)
          handlers.add(Client::RPCv2CBOR::ParseHandler, step: :parse)
        end

        def after_initialize(client)
          return unless client.config.protocol == 'smithy-rpc-v2-cbor'

          client.config.protocol_stubber = Client::RPCv2CBOR::Stubber
        end
      end
    end
  end
end
