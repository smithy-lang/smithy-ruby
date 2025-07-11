# frozen_string_literal: true

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Welds
    # Adds any supported protocol plugins to the client if the service has the traits.
    class Protocols < Weld
      def add_plugins
        service_traits = @plan.service.fetch('traits', {})
        plugins = {}
        rpc_v2_cbor(service_traits, plugins)
        plugins
      end

      private

      def rpc_v2_cbor(traits, plugins)
        return unless traits.key?('smithy.protocols#rpcv2Cbor')

        say_status :insert, 'Adding the rpcv2Cbor protocol plugin', :yellow unless @plan.quiet
        plugins[Smithy::Client::Plugins::RpcV2Cbor] = { require_path: 'smithy-client/plugins/rpc_v2_cbor' }
      end
    end
  end
end
