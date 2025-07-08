# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module RpcV2Cbor; end
  end
end

require_relative 'rpc_v2_cbor/error_handler'
require_relative 'rpc_v2_cbor/handler'
require_relative 'stubbing/rpc_v2_cbor'
