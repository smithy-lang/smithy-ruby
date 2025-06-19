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
          response = HTTP::Response.new
          response.status_code = 200
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          response.body = @codec.serialize(operation.output, data)
          response
        end

        def stub_error(_service, error_code)
          response = HTTP::Response.new
          response.status_code = 400
          response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['X-Amzn-RequestId'] = 'stubbed-request-id'
          data = { '__type' => error_code, 'message' => 'stubbed-error-message' }
          response.body = CBOR.encode(data)
          response
        end
      end
    end
  end
end
