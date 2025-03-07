# frozen_string_literal: true

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Welds
    # TODO: Update Welds to have a functionality to control ordering since there
    #  is a priority ordered list of protocols and a requirement that SDK MUST
    #  select the first entry in their priority ordered list that is also supported
    #  by the service. Generic code generation MUST accept configuration of this priority
    #  priority ordered list for use.
    #  The priority order is as follows (within AWS context):
    #  - Smithy RPCv2 CBOR
    #  - AWS JSON 1.0
    #  - AWS JSON 1.1
    #  - REST JSON
    #  - REST XML
    #  - AWS/Query
    #  - EC2/Query
    #  Possible solution: priority system similar to the handler registration
    class RPCv2CBOR < Weld
      def for?(service)
        _, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.protocols#rpcv2Cbor')

        say_status :insert, 'Adding the RPCv2 CBOR protocol', @plan.quiet
        true
      end

      def plugins
        {
          Smithy::Client::Plugins::RPCv2CBOR => {
            require_path: 'smithy-client/plugins/rpc_v2_cbor'
          }
        }
      end
    end
  end
end
