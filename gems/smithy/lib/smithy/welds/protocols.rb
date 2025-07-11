# frozen_string_literal: true

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Welds
    # Adds a supported protocol plugin to the client if the service has the trait, prioritized by a list.
    class Protocols < Weld
      PROTOCOL_PRIORITY = ['smithy.protocols#rpcv2Cbor'].freeze

      def add_plugins
        _, service = @plan.service.first
        service_traits = service.fetch('traits', {})

        PROTOCOL_PRIORITY.each do |id|
          next unless service_traits.key?(id)

          say_status :insert, "Adding a protocol plugin for #{id}", :yellow unless @plan.quiet
          return protocol_plugin(id)
        end
        {}
      end

      private

      def protocol_plugin(id)
        case id
        when 'smithy.protocols#rpcv2Cbor'
          { Smithy::Client::Plugins::RpcV2Cbor => { require_path: 'smithy-client/plugins/rpc_v2_cbor' } }
        end
      end
    end
  end
end
