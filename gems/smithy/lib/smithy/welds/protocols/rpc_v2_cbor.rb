# frozen_string_literal: true

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Welds
    module Protocols
      # Adds the rpcv2Cbor protocol to the client if the service has the trait.
      class RpcV2Cbor < Weld
        def for?(service)
          _, service = service.first
          return false unless service.fetch('traits', {}).key?('smithy.protocols#rpcv2Cbor')

          say_status :insert, 'Adding the RpcV2Cbor protocol plugin', :yellow unless @plan.quiet
          true
        end

        def add_plugins
          { Smithy::Client::Plugins::RpcV2Cbor => { require_path: 'smithy-client/plugins/rpc_v2_cbor' } }
        end
      end
    end
  end
end
