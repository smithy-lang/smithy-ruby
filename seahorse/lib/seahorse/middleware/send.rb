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

      # @param input
      # @param context
      # @return [Types::<Operation>Output]
      def call(input, context)
        if @stub_responses
          stub = @stubs.next(context.metadata[:api_method])
          apply_stub(stub, context)
          nil
        else
          @client.transmit(
            request: context.request,
            response: context.response
          )
          nil
        end
      end

      private

      # TODO: Remove output here
      def apply_stub(stub, context, output)
        case stub
        when Proc
          stub = stub.call(context)
          apply_stub(stub, context, output) if stub
        when Exception
          output.error = stub
        when Class
          output.error = stub.new
        when Hash
          @stub_class.stub(context.response, stub)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
    end
  end
end
