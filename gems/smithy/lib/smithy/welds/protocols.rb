# frozen_string_literal: true

require_relative '../../../../smithy-client/lib/smithy-client/rpc_v2_cbor'

module Smithy
  module Welds
    # Registers a supported protocol for the client if the service has the trait,
    # prioritized by a list. The generic Protocol plugin itself is added as a
    # default plugin (see DefaultPlugins); this weld only contributes the
    # protocol registry entry and its runtime dependency.
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

      def add_protocols
        case @protocol
        when 'smithy.protocols#rpcv2Cbor'
          {
            rpc_v2_cbor: {
              class_name: Smithy::Client::RpcV2Cbor,
              require_path: 'smithy-client/rpc_v2_cbor'
            }
          }
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
