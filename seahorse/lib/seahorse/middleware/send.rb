# frozen_string_literal: true

module Seahorse
  module Middleware
    class Send

      def initialize(_app, client:, stub_responses:, stub_class:, stubs: Seahorse::Stubbing::Stubs.new)
        @client = client
        @stub_responses = stub_responses
        @stub_class = stub_class
        @stubs = stubs
      end

      def call(request:, response:, context:)
        if @stub_responses
          stub = @stubs.next(context[:api_method])
          output = Output.new(context: context)
          apply_stub(stub, request, response, context, output)
          output
        else
          context[:logger].debug("Sending request #{request}")
          @client.transmit(
            request: request,
            response: response
          )
          Output.new(context: context)
        end
      end

      private

      def apply_stub(stub, request, response, context, output)
        case stub
        when Proc then apply_stub(stub.call(context.merge(request: request)), request, response, context, output)
        when Exception then
          output.error = stub
        when Class then
          output.error = stub.new
        when String then
          # TODO: Need a protocol specific error stubber
          raise NotImplementedError, 'String error codes are not yet supported'
        when Hash then apply_hash_stub(stub, request, response, context, output)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end

      def apply_hash_stub(stub, request, response, context, output)
        if stub.keys.sort == [:body, :headers, :status_code]
          response.body = stub[:body]
          response.status_code = stub[:status_code]
          response.headers = stub[:headers]
        else
          @stub_class.stub(http_resp: response, stub_data: stub)
        end
      end
    end
  end
end
