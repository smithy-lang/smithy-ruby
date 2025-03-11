# frozen_string_literal: true

module Smithy
  module Welds
    class RPCv2CBOR < Weld
      def for?(service)
        _, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.protocols#rpcv2Cbor')

        say_status :insert, 'Adding the RPCv2 CBOR protocol', @plan.quiet
        true
      end

      def protocols
        { 'rpcv2Cbor' => Smithy::Client::RPCv2CBOR::Protocol }
      end
    end
  end
end
