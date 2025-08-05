# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # @api private
      class RpcV2Cbor
        def stub_data(_config, operation, data)
          response = Http::Response.new
          response.status_code = 200
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          response.body = Cbor::Builder.new(operation.output).build(data)
          response
        end

        def stub_error(_config, error_code)
          response = Http::Response.new
          response.status_code = 400
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          data = { '__type' => "smithy.ruby.tests##{error_code}", 'message' => 'stubbed-error-message' }
          response.body = Cbor.encode(data)
          response
        end
      end
    end
  end
end
