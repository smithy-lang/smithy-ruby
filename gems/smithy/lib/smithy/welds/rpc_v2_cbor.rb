# frozen_string_literal: true

module Smithy
  module Welds
    # Adds the RPCv2 CBOR protocol to the client if the service has the trait.
    class RPCv2CBOR < Weld
      def for?(service)
        _, service = service.first
        return false unless service.fetch('traits', {}).key?('smithy.protocols#rpcv2Cbor')

        say_status :insert, 'Adding the RPCv2 CBOR protocol', :yellow unless @plan.quiet
        true
      end

      def protocols
        { 'rpcv2Cbor' => Smithy::Client::RPCv2CBOR::Protocol }
      end
    end
  end
end
