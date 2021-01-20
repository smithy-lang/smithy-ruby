# frozen_string_literal: true

module Seahorse
  module Middleware
    class Send

      def initialize(_app, client:, stub_responses: nil, stub: nil)
        @client = client
        @stub_responses = stub_responses
        @stub = stub
      end

      def call(http_req:, http_resp:, metadata:)
        if @stub_responses
          # params = { name: 'bucket-foo', contents: [{key: 'foo'}] }
          # stub.new.stub(http_resp: http_resp, params: params)
          # http_resp.status_code = 200
          # TODO somehow stub responses..
        else
          @client.transmit(
            http_req: http_req,
            http_resp: http_resp,
          )
        end
        Response.new(metadata: metadata)
      end

    end
  end
end
