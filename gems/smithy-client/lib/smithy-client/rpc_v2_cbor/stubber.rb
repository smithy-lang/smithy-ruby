# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      module Stubber
        def self.stub_data(operation, data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          resp.body = CBOR::Codec.serialize(operation.output, data)
          resp
        end

        def self.stub_error(error_code)
          resp = HTTP::Response.new
          resp.status_code = 400
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          data = { '__type' => error_code, 'message' => 'stubbed-error-message' }
          resp.body = CBOR.encode(data)
          resp
        end
      end
    end
  end
end
