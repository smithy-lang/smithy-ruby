# frozen_string_literal: true

module Seahorse
  module Middleware
    class Send

      def initialize(_app, client:, stub_responses:, stub_class:, stubs:)
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
        when Proc
          apply_stub(
            stub.call(context.merge(request: request)),
            request, response, context, output
          )
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
