# frozen_string_literal: true

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Welds
    # Adds a supported protocol plugin to the client if the service has the trait, prioritized by a list.
    class Protocols < Weld
      PROTOCOL_PRIORITY = ['smithy.protocols#rpcv2Cbor'].freeze

      def for?(service)
        _id, service = service.first
        service_traits = service.fetch('traits', {})
        PROTOCOL_PRIORITY.each do |id|
          if service_traits.key?(id)
            @protocol = id
            return true
          end
        end
        false
      end

      def add_plugins
        case @protocol
        when 'smithy.protocols#rpcv2Cbor'
          { Smithy::Client::Plugins::RpcV2Cbor => { require_path: 'smithy-client/plugins/rpc_v2_cbor' } }
        end
      end

      def add_dependencies
        case @protocol
        when 'smithy.protocols#rpcv2Cbor'
          { 'smithy-cbor' => '1.0.0.pre1' }
        end
      end
    end
  end
end
