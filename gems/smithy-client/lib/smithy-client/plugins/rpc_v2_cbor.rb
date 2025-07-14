# frozen_string_literal: true

require_relative '../rpc_v2_cbor/error_handler'
require_relative '../rpc_v2_cbor/handler'
require_relative '../stubbing/rpc_v2_cbor'

module Smithy
  module Client
    module Plugins
      # @api private
      class RpcV2Cbor < Plugin
        # @api private
        option(:stubber) { Stubbing::RpcV2Cbor.new }

        handler(Client::RpcV2Cbor::Handler)
        handler(Client::RpcV2Cbor::ErrorHandler, step: :sign)
      end
    end
  end
end
