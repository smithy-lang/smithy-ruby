# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      class ResponseStubber
        def initialize(options = {})
          @codec = CBOR::Codec.new(options)
        end

        def stub_data(_service, operation, data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          resp.body = @codec.serialize(operation.output, data)
          resp
        end

        def stub_error(_service, error_code)
          resp = HTTP::Response.new
          resp.status_code = 400
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          resp.headers['X-Amzn-RequestId'] = 'stubbed-request-id'
          data = { '__type' => error_code, 'message' => 'stubbed-error-message' }
          resp.body = CBOR.encode(data)
          resp
        end
      end
    end
  end
end
