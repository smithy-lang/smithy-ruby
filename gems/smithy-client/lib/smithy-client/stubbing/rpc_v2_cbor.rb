# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # @api private
      class RpcV2Cbor
        def stub_data(config, operation, data)
          response = HTTP::Response.new
          response.status_code = 200
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          response.body = config.cbor_codec.serialize(operation.output, data)
          response
        end

        def stub_error(_config, error_code)
          response = HTTP::Response.new
          response.status_code = 400
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          data = { '__type' => error_code, 'message' => 'stubbed-error-message' }
          response.body = CBOR.encode(data)
          response
        end
      end
    end
  end
end
