# frozen_string_literal: true

module Seahorse
  module Middleware
    class Send

      def initialize(_app, client:, stub_responses:, stub_class:, stubs:, response:, output:)
        @client = client
        @stub_responses = stub_responses
        @stub_class = stub_class
        @stubs = stubs
        @response = response
        @output = output
      end

      def call(request:, context:)
        if @stub_responses
          stub = @stubs.next(context[:api_method])
          apply_stub(stub, request, @response, context, @output)
        else
          @client.transmit(
            request: request,
            response: @response
          )
        end
        @response
      end

      private

      def apply_stub(stub, request, response, context, output)
        case stub
        when Proc
          stub = stub.call(request, response, context)
          apply_stub(stub, request, response, context, output) if stub
        when Exception
          output.error = stub
        when Class
          output.error = stub.new
        when Hash
          @stub_class.stub(response, stub)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
    end
  end
end
